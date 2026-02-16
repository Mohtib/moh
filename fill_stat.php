<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$statObj = new Stat($pdo);
$stat_id = $_GET['id'] ?? null;
$edit_id = $_GET['edit_id'] ?? null;

if (!$stat_id) {
    header("Location: view_stats.php");
    exit();
}

$stat = $statObj->getStatDetails($stat_id);
if (!$stat) {
    die("الإحصائية غير موجودة");
}

// التحقق من وجود الجدول في قاعدة البيانات
$table_exists = $statObj->tableExists($stat['table_name']);

// ========== التحقق من الصلاحية ==========
$available_stats = $statObj->getAvailableStats($_SESSION['user_id'], $_SESSION['role_level']);
$is_allowed = false;
foreach ($available_stats as $s) {
    if ($s['id'] == $stat_id) {
        $is_allowed = true;
        break;
    }
}
if (!$is_allowed) {
    die("غير مصرح لك بالوصول إلى هذه الإحصائية.");
}
// =======================================

$message = "";

// معالجة الحفظ التلقائي عبر AJAX
if (isset($_GET['autosave']) && $_SERVER['REQUEST_METHOD'] == 'POST' && $table_exists) {
    header('Content-Type: application/json');
    $year = (int)$_POST['stat_year'];
    $period = ($stat['stat_type'] == 'yearly') ? 1 : (int)($_POST['stat_period'] ?? 1);
    
    $existing = $statObj->checkDataExists($stat['table_name'], $_SESSION['user_id'], $year, $period);
    $current_completed = $existing ? $existing['is_completed'] : 0;
    
    $data = [
        'user_id' => $_SESSION['user_id'],
        'stat_year' => $year,
        'stat_period' => $period,
        'is_completed' => $current_completed
    ];
    foreach ($stat['columns'] as $col) {
        if (!in_array($col['data_type'], ['file', 'image'])) {
            $data[$col['column_name']] = $_POST[$col['column_name']] ?? null;
        }
    }
    
    if ($existing) {
        $res = $statObj->updateData($stat['table_name'], $existing['id'], $data);
    } else {
        $res = $statObj->saveData($stat['table_name'], $data);
    }
    echo json_encode(['success' => $res]);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && $table_exists) {
    $year = (int)$_POST['stat_year'];
    $period = ($stat['stat_type'] == 'yearly') ? 1 : (int)($_POST['stat_period'] ?? 1);
    $is_completed = isset($_POST['is_completed']) ? 1 : 0;
    
    $data = [
        'user_id' => $_SESSION['user_id'],
        'stat_year' => $year,
        'stat_period' => $period,
        'is_completed' => $is_completed
    ];
    
    $upload_dir = 'uploads/dynamic/';
    if (!file_exists($upload_dir)) mkdir($upload_dir, 0777, true);

    $errors = [];
    foreach ($stat['columns'] as $col) {
        $col_name = $col['column_name'];
        if ($col['data_type'] == 'file' || $col['data_type'] == 'image') {
            if (isset($_FILES[$col_name]) && $_FILES[$col_name]['error'] == 0) {
                $file_name = $_FILES[$col_name]['name'];
                $ext = strtolower(pathinfo($file_name, PATHINFO_EXTENSION));
                $file_size = $_FILES[$col_name]['size'];
                
                if ($col['data_type'] == 'file') {
                    $allowed = ['pdf', 'doc', 'docx', 'xls', 'xlsx'];
                    $allowed_mimes = ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'];
                } else {
                    $allowed = ['jpg', 'jpeg', 'png', 'gif'];
                    $allowed_mimes = ['image/jpeg', 'image/png', 'image/gif'];
                }
                
                $mime = mime_content_type($_FILES[$col_name]['tmp_name']);
                if (!in_array($ext, $allowed) || !in_array($mime, $allowed_mimes)) {
                    $errors[] = "نوع الملف غير مسموح للعمود {$col['column_label']}.";
                    continue;
                }
                
                $max_size = ($col['data_type'] == 'file') ? 20 * 1024 * 1024 : 5 * 1024 * 1024;
                if ($file_size > $max_size) {
                    $errors[] = "حجم الملف في العمود {$col['column_label']} كبير جداً.";
                    continue;
                }

                $new_file_name = time() . '_' . rand(100, 999) . '_' . preg_replace("/[^a-zA-Z0-9.]/", "_", basename($file_name));
                $target_path = $upload_dir . $new_file_name;
                if (move_uploaded_file($_FILES[$col_name]['tmp_name'], $target_path)) $data[$col_name] = $target_path;
            } else {
                $data[$col_name] = $_POST['old_' . $col_name] ?? null;
            }
        } else {
            $data[$col_name] = $_POST[$col_name] ?? null;
        }
    }
    
    if (empty($errors)) {
        $target_id = $edit_id;
        if (!$target_id) {
            $existing = $statObj->checkDataExists($stat['table_name'], $_SESSION['user_id'], $year, $period);
            if ($existing) $target_id = $existing['id'];
        }
        
        $success_db = $target_id ? $statObj->updateData($stat['table_name'], $target_id, $data) : $statObj->saveData($stat['table_name'], $data);

        if ($success_db) {
            $message = "<div class='alert alert-success'><i class='fas fa-check-circle'></i> تم حفظ البيانات بنجاح!</div>";
            $status = $is_completed ? 'completed' : 'pending';
            $stmtSub = $pdo->prepare("INSERT INTO stat_submissions (stat_id, user_id, status, submitted_at) VALUES (?, ?, ?, NOW()) ON DUPLICATE KEY UPDATE status=?, submitted_at=NOW()");
            $stmtSub->execute([$stat_id, $_SESSION['user_id'], $status, $status]);
            if ($is_completed) echo "<script>setTimeout(() => { window.location.href = 'view_stats.php'; }, 1500);</script>";
        } else {
            $message = "<div class='alert alert-danger'><i class='fas fa-times-circle'></i> خطأ في حفظ البيانات.</div>";
        }
    } else {
        $message = "<div class='alert alert-danger'><ul><li>" . implode("</li><li>", $errors) . "</li></ul></div>";
    }
}

$existing_entry = null;
if ($edit_id && $table_exists) {
    $stmtPrev = $pdo->prepare("SELECT * FROM `{$stat['table_name']}` WHERE id = ?");
    $stmtPrev->execute([$edit_id]);
    $existing_entry = $stmtPrev->fetch();
}

$arabic_months = [1 => 'جانفي', 2 => 'فيفري', 3 => 'مارس', 4 => 'أفريل', 5 => 'ماي', 6 => 'جوان', 7 => 'جويلية', 8 => 'أوت', 9 => 'سبتمبر', 10 => 'أكتوبر', 11 => 'نوفمبر', 12 => 'ديسمبر'];
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>تعبئة إحصائية: <?php echo htmlspecialchars($stat['stat_name']); ?></title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .alert { padding: 15px; border-radius: 8px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .alert-success { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }
        .alert-danger { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }
        .form-section { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); margin-bottom: 20px; }
        .form-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #334155; }
        .form-control { width: 100%; padding: 12px; border: 1px solid #e2e8f0; border-radius: 8px; font-size: 1rem; transition: all 0.2s; }
        .form-control:focus { border-color: #2563eb; outline: none; box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1); }
        .btn-submit { background: #2563eb; color: white; padding: 14px 28px; border: none; border-radius: 8px; font-weight: bold; cursor: pointer; width: 100%; display: flex; justify-content: center; align-items: center; gap: 10px; font-size: 1.1rem; }
        .autosave-status { font-size: 0.8rem; color: #64748b; margin-bottom: 10px; display: flex; align-items: center; gap: 5px; }
        .invalid { border-color: #ef4444 !important; }
        .error-hint { color: #ef4444; font-size: 0.75rem; margin-top: 4px; display: none; }
        .error-alert { background: #fee2e2; border-right: 5px solid #ef4444; color: #991b1b; padding: 20px; border-radius: 12px; margin-bottom: 25px; display: flex; align-items: center; gap: 15px; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        <div class="main-content">
            <div class="page-header" style="margin-bottom: 30px;">
                <div style="display: flex; justify-content: space-between; align-items: flex-end;">
                    <div>
                        <a href="view_stats.php" style="text-decoration: none; color: #64748b; display: flex; align-items: center; gap: 5px; margin-bottom: 10px;"><i class="fas fa-arrow-right"></i> العودة</a>
                        <h2>تعبئة بيانات: <span style="color: #2563eb;"><?php echo htmlspecialchars($stat['stat_name']); ?></span></h2>
                    </div>
                    <?php if ($table_exists): ?>
                        <div id="autosaveStatus" class="autosave-status"><i class="fas fa-sync"></i> جاهز للحفظ التلقائي</div>
                    <?php endif; ?>
                </div>
            </div>

            <?php if (!$table_exists): ?>
                <div class="error-alert">
                    <i class="fas fa-exclamation-triangle" style="font-size: 2rem;"></i>
                    <div>
                        <h3 style="margin: 0;">خطأ في قاعدة البيانات</h3>
                        <p style="margin: 5px 0 0 0;">عذراً، جدول البيانات الخاص بهذه الإحصائية مفقود. لا يمكن تعبئة البيانات حالياً.</p>
                    </div>
                </div>
            <?php endif; ?>

            <?php echo $message; ?>

            <?php if ($table_exists): ?>
            <form id="statForm" method="POST" enctype="multipart/form-data">
                <div class="form-section">
                    <h3 style="margin-top: 0; margin-bottom: 20px; font-size: 1.1rem; border-bottom: 1px solid #f1f5f9; padding-bottom: 10px;"><i class="fas fa-calendar-alt"></i> المعلومات الزمنية</h3>
                    <div class="form-grid">
                        <div class="form-group">
                            <label>السنة المرجعية</label>
                            <select name="stat_year" class="form-control">
                                <?php $current_year = date('Y'); for($y=$current_year; $y>=2020; $y--) { $selected = ($existing_entry && $existing_entry['stat_year']==$y) ? 'selected' : ''; echo "<option value='$y' $selected>$y</option>"; } ?>
                            </select>
                        </div>
                        <?php if ($stat['stat_type'] != 'yearly'): ?>
                        <div class="form-group">
                            <label>الفترة الزمنية</label>
                            <select name="stat_period" class="form-control">
                                <?php if ($stat['stat_type'] == 'six_months'): ?>
                                    <option value="1" <?php echo ($existing_entry && $existing_entry['stat_period']==1 ? 'selected':''); ?>>السداسي الأول</option>
                                    <option value="2" <?php echo ($existing_entry && $existing_entry['stat_period']==2 ? 'selected':''); ?>>السداسي الثاني</option>
                                <?php elseif ($stat['stat_type'] == 'monthly'): ?>
                                    <?php foreach ($arabic_months as $m_num => $m_name): ?>
                                        <option value="<?php echo $m_num; ?>" <?php echo ($existing_entry && $existing_entry['stat_period']==$m_num ? 'selected':''); ?>>شهر <?php echo $m_name; ?></option>
                                    <?php endforeach; ?>
                                <?php endif; ?>
                            </select>
                        </div>
                        <?php else: ?><input type="hidden" name="stat_period" value="1"><?php endif; ?>
                    </div>
                </div>

                <div class="form-section">
                    <h3 style="margin-top: 0; margin-bottom: 20px; font-size: 1.1rem; border-bottom: 1px solid #f1f5f9; padding-bottom: 10px;"><i class="fas fa-database"></i> بيانات الإحصاء</h3>
                    <div class="form-grid">
                        <?php foreach ($stat['columns'] as $col): ?>
                            <div class="form-group">
                                <label><?php echo htmlspecialchars($col['column_label']); ?></label>
                                <?php $val = $existing_entry ? $existing_entry[$col['column_name']] : ''; $type = $col['data_type']; ?>
                                <?php if(in_array($type, ['integer', 'decimal', 'number'])): ?>
                                    <input type="number" step="any" name="<?php echo $col['column_name']; ?>" value="<?php echo $val; ?>" class="form-control validate-number" required>
                                    <span class="error-hint">يرجى إدخال رقم صحيح</span>
                                <?php elseif($type == 'date'): ?>
                                    <input type="date" name="<?php echo $col['column_name']; ?>" value="<?php echo $val; ?>" class="form-control" required>
                                <?php elseif($type == 'boolean'): ?>
                                    <select name="<?php echo $col['column_name']; ?>" class="form-control"><option value="1" <?php echo $val == 1 ? 'selected' : ''; ?>>نعم</option><option value="0" <?php echo $val == 0 ? 'selected' : ''; ?>>لا</option></select>
                                <?php elseif($type == 'file' || $type == 'image'): ?>
                                    <input type="file" name="<?php echo $col['column_name']; ?>" class="form-control"><small><?php echo $type == 'file' ? 'PDF, Word, Excel' : 'JPG, PNG'; ?></small>
                                    <?php if($val): ?><div style="margin-top:5px;"><input type="hidden" name="old_<?php echo $col['column_name']; ?>" value="<?php echo $val; ?>"><a href="<?php echo $val; ?>" target="_blank">عرض المرفق الحالي</a></div><?php endif; ?>
                                <?php else: ?>
                                    <input type="text" name="<?php echo $col['column_name']; ?>" value="<?php echo htmlspecialchars($val); ?>" class="form-control" required>
                                <?php endif; ?>
                            </div>
                        <?php endforeach; ?>
                    </div>
                </div>

                <div class="form-section" style="background: #f8fafc; border: 1px solid #e2e8f0;">
                    <label style="display:flex; align-items:center; gap:12px; cursor:pointer;"><input type="checkbox" name="is_completed" value="1" style="width: 20px; height: 20px;" <?php echo ($existing_entry && $existing_entry['is_completed']) ? 'checked' : ''; ?>><div><strong>تأكيد إكمال التعبئة نهائياً</strong><br><span style="font-size: 0.85rem; color: #64748b;">لن تتمكن من التعديل بعد التأكيد النهائي.</span></div></label>
                </div>
                <button type="submit" class="btn-submit"><i class="fas fa-save"></i> حفظ وإرسال الإحصائية</button>
            </form>
            <?php endif; ?>
        </div>
    </div>

    <script>
    $(document).ready(function() {
        $('.validate-number').on('input', function() {
            if (isNaN($(this).val())) {
                $(this).addClass('invalid').next('.error-hint').show();
            } else {
                $(this).removeClass('invalid').next('.error-hint').hide();
            }
        });

        let autosaveTimer;
        $('#statForm input, #statForm select, #statForm textarea').on('change', function() {
            if ($(this).attr('type') === 'file') return;
            clearTimeout(autosaveTimer);
            $('#autosaveStatus').html('<i class="fas fa-spinner fa-spin"></i> جاري الحفظ التلقائي...');
            autosaveTimer = setTimeout(function() {
                const formData = $('#statForm').serialize();
                $.ajax({
                    url: 'fill_stat.php?id=<?php echo $stat_id; ?>&autosave=1',
                    method: 'POST',
                    data: formData,
                    success: function(res) {
                        if (res.success) {
                            const now = new Date().toLocaleTimeString('ar-DZ');
                            $('#autosaveStatus').html('<i class="fas fa-check"></i> تم الحفظ تلقائياً ' + now);
                        } else {
                            $('#autosaveStatus').html('<i class="fas fa-exclamation-triangle"></i> فشل الحفظ التلقائي');
                        }
                    }
                });
            }, 2000);
        });
    });
    </script>
</body>
</html>
