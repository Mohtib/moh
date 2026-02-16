<?php
session_start();
require_once 'config/db.php';
if (!isset($_SESSION['user_id']) || ($_SESSION['role_level'] != 1 && $_SESSION['role_level'] != 2 && $_SESSION['role_level'] != 3)) {
    header("Location: dashboard.php");
    exit();
}

// جلب الإحصائيات الحالية لتكون كأب (هرمية)
$stmt = $pdo->prepare("SELECT id, stat_name FROM stat_definitions");
$stmt->execute();
$all_stats = $stmt->fetchAll();

// جلب المستخدمين التابعين لتحديد المستهدفين
require_once 'includes/User.php';
$userObj = new User($pdo);
    // جلب كافة المستخدمين إذا كان مديراً، أو التابعين فقط لغيره
    if ($_SESSION['role_level'] == 1) {
        $stmtAll = $pdo->prepare("SELECT id, full_name FROM users WHERE id != ? ORDER BY full_name ASC");
        $stmtAll->execute([$_SESSION['user_id']]);
        $subordinates = $stmtAll->fetchAll();
    } else {
        $subordinates = $userObj->getSubordinates($_SESSION['user_id'], false); 
    }

// إذا كان هناك طلب تعديل
$edit_stat = null;
if (isset($_GET['edit_id'])) {
    require_once 'includes/Stat.php';
    $statObj = new Stat($pdo);
    $edit_stat = $statObj->getStatDetails($_GET['edit_id']);
}
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title><?php echo $edit_stat ? 'تعديل' : 'إنشاء'; ?> إحصائية | جامعة ميلة</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .error-message { color: #ef4444; background: #fee2e2; padding: 10px; border-radius: 5px; margin-bottom: 15px; display: none; }
        .success-message { color: #10b981; background: #d1fae5; padding: 10px; border-radius: 5px; margin-bottom: 15px; display: none; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>

        <div class="main-content">
            <h2><i class="fas fa-plus-circle"></i> <?php echo $edit_stat ? 'تعديل هيكل الإحصائية' : 'إنشاء نموذج إحصائي جديد'; ?></h2>
            
            <div id="msgContainer">
                <div class="error-message" id="errorMsg"></div>
                <div class="success-message" id="successMsg"></div>
            </div>

            <div class="card">
                <form id="createStatForm">
                    <?php if($edit_stat): ?>
                        <input type="hidden" name="edit_id" value="<?php echo $edit_stat['id']; ?>">
                    <?php endif; ?>
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                        <div>
                            <label>اسم الإحصائية</label>
                            <input type="text" name="stat_name" value="<?php echo $edit_stat ? htmlspecialchars($edit_stat['stat_name']) : ''; ?>" class="card" style="width:100%; padding:10px; margin-top:5px;" placeholder="مثلاً: إحصائيات الموظفين" required>
                        </div>
                        <div>
                            <label>دورية الإحصاء</label>
                            <select name="stat_type" class="card" style="width:100%; padding:10px; margin-top:5px;">
                                <option value="monthly" <?php echo ($edit_stat && $edit_stat['stat_type'] == 'monthly') ? 'selected' : ''; ?>>شهري</option>
                                <option value="six_months" <?php echo ($edit_stat && $edit_stat['stat_type'] == 'six_months') ? 'selected' : ''; ?>>سداسي (كل 6 أشهر)</option>
                                <option value="yearly" <?php echo ($edit_stat && $edit_stat['stat_type'] == 'yearly') ? 'selected' : ''; ?>>سنوي</option>
                            </select>
                        </div>
                        <div>
                            <label>إحصائية أب (للهرمية)</label>
                            <select name="parent_stat_id" class="card" style="width:100%; padding:10px; margin-top:5px;">
                                <option value="">لا يوجد (إحصائية رئيسية)</option>
                                <?php foreach($all_stats as $s): ?>
                                    <option value="<?php echo $s['id']; ?>" <?php echo ($edit_stat && $edit_stat['parent_stat_id'] == $s['id']) ? 'selected' : ''; ?>><?php echo htmlspecialchars($s['stat_name']); ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>

                    <div class="card" style="margin-bottom: 20px; background: #f8fafc;">
                        <h3><i class="fas fa-user-tag"></i> توجيه الإحصائية</h3>
                        <div style="margin-top: 10px;">
                            <label style="display: block; margin-bottom: 10px;">
                                <input type="radio" name="target_type" value="all_subordinates" <?php echo (!$edit_stat || $edit_stat['target_type'] == 'all_subordinates') ? 'checked' : ''; ?> onchange="toggleUserSelection(false)"> 
                                توجيه لكافة التابعين المباشرين
                            </label>
                            <label style="display: block; margin-bottom: 10px;">
                                <input type="radio" name="target_type" value="specific_users" <?php echo ($edit_stat && $edit_stat['target_type'] == 'specific_users') ? 'checked' : ''; ?> onchange="toggleUserSelection(true)"> 
                                تحديد مستخدمين معينين
                            </label>
                        </div>
                        
                        <div id="userSelection" style="<?php echo ($edit_stat && $edit_stat['target_type'] == 'specific_users') ? '' : 'display: none;'; ?> margin-top: 15px; padding: 15px; border: 1px solid #e2e8f0; border-radius: 8px; max-height: 200px; overflow-y: auto;">
                            <label style="font-weight: bold; display: block; margin-bottom: 10px;">اختر المستخدمين:</label>
                            <?php 
                            $assigned = [];
                            if($edit_stat) {
                                $stmtAssigned = $pdo->prepare("SELECT user_id FROM stat_assignments WHERE stat_id = ?");
                                $stmtAssigned->execute([$edit_stat['id']]);
                                $assigned = $stmtAssigned->fetchAll(PDO::FETCH_COLUMN);
                            }
                            ?>
                            <?php foreach($subordinates as $sub): ?>
                                <label style="display: block; margin-bottom: 5px;">
                                    <input type="checkbox" name="assigned_users[]" value="<?php echo $sub['id']; ?>" <?php echo in_array($sub['id'], $assigned) ? 'checked' : ''; ?>> 
                                    <?php echo htmlspecialchars($sub['full_name']); ?>
                                </label>
                            <?php endforeach; ?>
                        </div>
                    </div>

                    <hr style="border: 0; border-top: 1px solid #e2e8f0; margin: 20px 0;">
                    
                    <h3><i class="fas fa-columns"></i> تعريف أعمدة الجدول وأنواع البيانات</h3>
                    <div id="columnsContainer">
                        <?php if($edit_stat && !empty($edit_stat['columns'])): ?>
                            <?php foreach($edit_stat['columns'] as $col): ?>
                                <div class="column-row" style="display: grid; grid-template-columns: 1fr 1fr 1fr auto; gap: 10px; margin-bottom: 10px;">
                                    <input type="text" name="col_label[]" value="<?php echo htmlspecialchars($col['column_label']); ?>" placeholder="اسم العمود (بالعربية)" class="card" style="padding:10px;" required>
                                    <input type="text" name="col_name[]" value="<?php echo htmlspecialchars($col['column_name']); ?>" placeholder="اسم العمود (Database Key)" class="card" style="padding:10px;" readonly>
                                    <select name="col_type[]" class="card" style="padding:10px;">
                                        <option value="string" <?php echo $col['data_type'] == 'string' ? 'selected' : ''; ?>>سلسلة حروف (String)</option>
                                        <option value="integer" <?php echo $col['data_type'] == 'integer' ? 'selected' : ''; ?>>رقم طبيعي (Integer)</option>
                                        <option value="decimal" <?php echo $col['data_type'] == 'decimal' ? 'selected' : ''; ?>>رقم حقيقي (Decimal)</option>
                                        <option value="date" <?php echo $col['data_type'] == 'date' ? 'selected' : ''; ?>>تاريخ (Date)</option>
                                        <option value="text" <?php echo $col['data_type'] == 'text' ? 'selected' : ''; ?>>نص طويل (Text)</option>
                                        <option value="boolean" <?php echo $col['data_type'] == 'boolean' ? 'selected' : ''; ?>>منطقي (نعم/لا)</option>
                                        <option value="file" <?php echo $col['data_type'] == 'file' ? 'selected' : ''; ?>>ملف (PDF/Word)</option>
                                        <option value="image" <?php echo $col['data_type'] == 'image' ? 'selected' : ''; ?>>صورة (JPG/PNG)</option>
                                    </select>
                                    <button type="button" class="btn" style="background:#ef4444; color:white;" disabled>X</button>
                                </div>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <div class="column-row" style="display: grid; grid-template-columns: 1fr 1fr 1fr auto; gap: 10px; margin-bottom: 10px;">
                                <input type="text" name="col_label[]" placeholder="اسم العمود (بالعربية)" class="card" style="padding:10px;" required>
                                <input type="text" name="col_name[]" placeholder="اسم العمود (Database Key)" class="card" style="padding:10px;" required>
                                <select name="col_type[]" class="card" style="padding:10px;">
                                    <option value="string">سلسلة حروف (String)</option>
                                    <option value="integer">رقم طبيعي (Integer)</option>
                                    <option value="decimal">رقم حقيقي (Decimal)</option>
                                    <option value="date">تاريخ (Date)</option>
                                    <option value="text">نص طويل (Text)</option>
                                    <option value="boolean">منطقي (نعم/لا)</option>
                                    <option value="file">ملف (PDF/Word)</option>
                                    <option value="image">صورة (JPG/PNG)</option>
                                </select>
                                <button type="button" class="btn" style="background:#ef4444; color:white;" onclick="$(this).parent().remove()">X</button>
                            </div>
                        <?php endif; ?>
                    </div>
                    
                    <?php if(!$edit_stat): ?>
                        <button type="button" class="btn" style="background:#10b981; color:white; margin-bottom:20px;" onclick="addColumn()">+ إضافة عمود آخر</button>
                    <?php endif; ?>
                    
                    <div style="text-align: left;">
                        <button type="submit" id="submitBtn" class="btn btn-primary" style="padding: 15px 40px; background:#2563eb; color:white; border:none; border-radius:8px; cursor:pointer;">
                            <?php echo $edit_stat ? 'حفظ التعديلات' : 'إنشاء الإحصائية والجدول الياً'; ?>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function toggleUserSelection(show) {
            if (show) {
                $('#userSelection').slideDown();
            } else {
                $('#userSelection').slideUp();
            }
        }

        function addColumn() {
            const html = `
                <div class="column-row" style="display: grid; grid-template-columns: 1fr 1fr 1fr auto; gap: 10px; margin-bottom: 10px;">
                    <input type="text" name="col_label[]" placeholder="اسم العمود (بالعربية)" class="card" style="padding:10px;" required>
                    <input type="text" name="col_name[]" placeholder="اسم العمود (Database Key)" class="card" style="padding:10px;" required>
                    <select name="col_type[]" class="card" style="padding:10px;">
                        <option value="string">سلسلة حروف (String)</option>
                        <option value="integer">رقم طبيعي (Integer)</option>
                        <option value="decimal">رقم حقيقي (Decimal)</option>
                        <option value="date">تاريخ (Date)</option>
                        <option value="text">نص طويل (Text)</option>
                        <option value="boolean">منطقي (نعم/لا)</option>
                        <option value="file">ملف (PDF/Word)</option>
                        <option value="image">صورة (JPG/PNG)</option>
                    </select>
                    <button type="button" class="btn" style="background:#ef4444; color:white;" onclick="$(this).parent().remove()">X</button>
                </div>`;
            $('#columnsContainer').append(html);
        }

        $('#createStatForm').on('submit', function(e) {
            e.preventDefault();
            
            // التحقق من اختيار المستخدمين إذا كان النوع محدد
            const targetType = $('input[name="target_type"]:checked').val();
            if (targetType === 'specific_users') {
                const selectedUsers = $('input[name="assigned_users[]"]:checked').length;
                if (selectedUsers === 0) {
                    $('#errorMsg').text('يجب اختيار مستخدم واحد على الأقل').fadeIn();
                    $('#successMsg').hide();
                    return;
                }
            }

            $('#submitBtn').prop('disabled', true).text('جاري المعالجة...');
            $('#errorMsg').hide();
            $('#successMsg').hide();

            $.ajax({
                url: 'api/create_stat.php',
                method: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    $('#submitBtn').prop('disabled', false).text('<?php echo $edit_stat ? "حفظ التعديلات" : "إنشاء الإحصائية والجدول الياً"; ?>');
                    try {
                        const res = typeof response === 'object' ? response : JSON.parse(response);
                        if(res.success) {
                            $('#successMsg').text(res.message).fadeIn();
                            setTimeout(() => {
                                window.location.href = 'manage_stats.php';
                            }, 1500);
                        } else {
                            $('#errorMsg').text(res.message).fadeIn();
                        }
                    } catch(e) {
                        $('#errorMsg').text('حدث خطأ في استجابة الخادم').fadeIn();
                    }
                },
                error: function() {
                    $('#submitBtn').prop('disabled', false).text('<?php echo $edit_stat ? "حفظ التعديلات" : "إنشاء الإحصائية والجدول الياً"; ?>');
                    $('#errorMsg').text('حدث خطأ أثناء الاتصال بالخادم').fadeIn();
                }
            });
        });
    </script>
</body>
</html>
