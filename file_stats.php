<?php
session_start();
require_once 'config/db.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$user_id = $_SESSION['user_id'];
$role_level = (int)$_SESSION['role_level'];

// جلب إحصائيات الملفات المتاحة للمستخدم
if ($role_level == 1) {
    $stmt = $pdo->prepare("SELECT sd.*, u.full_name as creator_name FROM stat_definitions sd JOIN users u ON sd.creator_id = u.id WHERE sd.stat_type = 'file_exchange'");
    $stmt->execute();
} else {
    $stmt = $pdo->prepare("
        SELECT sd.*, u.full_name as creator_name FROM stat_definitions sd 
        JOIN users u ON sd.creator_id = u.id 
        WHERE sd.stat_type = 'file_exchange' 
        AND (sd.creator_id = ? OR sd.creator_id = (SELECT parent_id FROM users WHERE id = ?) OR sd.creator_id = 1)
    ");
    $stmt->execute([$user_id, $user_id]);
}
$file_stats = $stmt->fetchAll();

// معالجة رفع أو تعديل ملف
$upload_msg = "";
$msg_type = "success";

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['upload_file'])) {
    $stat_id = $_POST['stat_id'];
    $year = $_POST['stat_year'];
    $period = $_POST['stat_period'] ?? 1;
    $notes = $_POST['notes'] ?? '';
    $existing_file_id = $_POST['existing_file_id'] ?? null;
    
    if (isset($_FILES['file']) && $_FILES['file']['error'] == 0) {
        $file_name = $_FILES['file']['name'];
        $file_size = $_FILES['file']['size'];
        $file_ext = strtolower(pathinfo($file_name, PATHINFO_EXTENSION));
        
        $allowed_exts = ['pdf', 'docx', 'xlsx', 'xls', 'png', 'jpg', 'jpeg'];
        $max_size = 20 * 1024 * 1024; // 20MB

        if (!in_array($file_ext, $allowed_exts)) {
            $upload_msg = "نوع الملف غير مسموح. المسموح: PDF, DOCX, Excel, الصور.";
            $msg_type = "error";
        } elseif ($file_size > $max_size) {
            $upload_msg = "حجم الملف كبير جداً. الحد الأقصى 20 ميغابايت.";
            $msg_type = "error";
        } else {
            $upload_dir = 'uploads/files/';
            if (!is_dir($upload_dir)) mkdir($upload_dir, 0777, true);
            
            $new_file_name = time() . '_' . rand(100,999) . '_' . preg_replace("/[^a-zA-Z0-9.]/", "_", $file_name);
            $target_path = $upload_dir . $new_file_name;
            
            if (move_uploaded_file($_FILES['file']['tmp_name'], $target_path)) {
                if ($existing_file_id) {
                    $stmtOld = $pdo->prepare("SELECT file_path FROM file_exchanges WHERE id = ? AND user_id = ?");
                    $stmtOld->execute([$existing_file_id, $user_id]);
                    $oldFile = $stmtOld->fetch();
                    if ($oldFile && file_exists($oldFile['file_path'])) {
                        unlink($oldFile['file_path']);
                    }

                    $stmt = $pdo->prepare("UPDATE file_exchanges SET file_path = ?, file_name = ?, notes = ?, stat_year = ?, stat_period = ?, uploaded_at = CURRENT_TIMESTAMP WHERE id = ? AND user_id = ?");
                    $stmt->execute([$target_path, $file_name, $notes, $year, $period, $existing_file_id, $user_id]);
                    $upload_msg = "تم تحديث الملف بنجاح.";
                } else {
                    $stmt = $pdo->prepare("INSERT INTO file_exchanges (stat_id, user_id, file_path, file_name, notes, stat_year, stat_period) VALUES (?, ?, ?, ?, ?, ?, ?)");
                    $stmt->execute([$stat_id, $user_id, $target_path, $file_name, $notes, $year, $period]);
                    $upload_msg = "تم رفع الملف بنجاح.";
                }
            }
        }
    } elseif ($existing_file_id && isset($_POST['notes'])) {
        $stmt = $pdo->prepare("UPDATE file_exchanges SET notes = ?, stat_year = ?, stat_period = ? WHERE id = ? AND user_id = ?");
        $stmt->execute([$notes, $year, $period, $existing_file_id, $user_id]);
        $upload_msg = "تم تحديث البيانات بنجاح.";
    }
}

$arabic_months = [
    1 => 'جانفي', 2 => 'فيفري', 3 => 'مارس', 4 => 'أفريل',
    5 => 'ماي', 6 => 'جوان', 7 => 'جويلية', 8 => 'أوت',
    9 => 'سبتمبر', 10 => 'أكتوبر', 11 => 'نوفمبر', 12 => 'ديسمبر'
];
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>مركز الملفات | نظام الإحصائيات</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .file-card { background: white; border-radius: 12px; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); border-right: 5px solid #64748b; }
        .file-card.active { border-right-color: #2563eb; }
        .upload-section { background: #f8fafc; padding: 15px; border-radius: 8px; margin-top: 15px; border: 1px dashed #cbd5e1; }
        .files-list { margin-top: 15px; border-top: 1px solid #e2e8f0; padding-top: 15px; }
        .file-item { display: flex; justify-content: space-between; align-items: center; padding: 12px; background: white; border: 1px solid #f1f5f9; border-radius: 8px; margin-bottom: 8px; transition: all 0.2s; }
        .file-item:hover { border-color: #bfdbfe; background: #f0f9ff; }
        .alert { padding: 15px; border-radius: 8px; margin-bottom: 20px; }
        .alert-success { background: #d1fae5; color: #065f46; border: 1px solid #34d399; }
        .alert-error { background: #fee2e2; color: #991b1b; border: 1px solid #f87171; }
        .file-info { display: flex; align-items: center; gap: 15px; }
        .file-icon { font-size: 2rem; color: #2563eb; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        
        <div class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
                <h2><i class="fas fa-folder-open"></i> مركز تبادل الملفات</h2>
            </div>

            <?php if($upload_msg): ?>
                <div class="alert alert-<?php echo $msg_type; ?>"><?php echo $upload_msg; ?></div>
            <?php endif; ?>

            <?php if(empty($file_stats)): ?>
                <div class="card" style="text-align: center; padding: 50px;">
                    <i class="fas fa-file-excel fa-4x" style="color: #e2e8f0; margin-bottom: 20px;"></i>
                    <p style="color: #94a3b8;">لا توجد إحصائيات ملفات متاحة حالياً.</p>
                </div>
            <?php else: ?>
                <?php foreach($file_stats as $stat): ?>
                    <div class="file-card active">
                        <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                            <div>
                                <h3 style="color: #1e293b;"><?php echo htmlspecialchars($stat['stat_name']); ?></h3>
                                <div style="margin-top: 5px;">
                                    <span class="badge" style="background: #e0f2fe; color: #0369a1; padding: 2px 8px; border-radius: 4px; font-size: 0.75rem;">
                                        <?php 
                                            if($stat['stat_type'] == 'yearly') echo 'سنوية';
                                            elseif($stat['stat_type'] == 'six_months') echo 'سداسية';
                                            else echo 'شهرية';
                                        ?>
                                    </span>
                                    <small style="color: #94a3b8; margin-right: 10px;">بواسطة: <?php echo htmlspecialchars($stat['creator_name']); ?></small>
                                </div>
                            </div>
                            <?php if($role_level >= 3): ?>
                                <button onclick="toggleUploadForm(<?php echo $stat['id']; ?>)" class="btn" style="background: #2563eb; color: white; padding: 8px 15px; border-radius: 5px; border: none; cursor: pointer;">
                                    <i class="fas fa-upload"></i> رفع ملف جديد
                                </button>
                            <?php endif; ?>
                        </div>

                        <div id="upload-form-<?php echo $stat['id']; ?>" class="upload-section" style="display: none;">
                            <form method="POST" enctype="multipart/form-data">
                                <input type="hidden" name="stat_id" value="<?php echo $stat['id']; ?>">
                                
                                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 15px;">
                                    <div>
                                        <label>السنة:</label>
                                        <select name="stat_year" class="card" style="width: 100%; padding: 8px;">
                                            <?php for($y=date('Y'); $y>=2020; $y--) echo "<option value='$y'>$y</option>"; ?>
                                        </select>
                                    </div>
                                    <?php if($stat['stat_type'] != 'yearly'): ?>
                                    <div>
                                        <label>الفترة:</label>
                                        <select name="stat_period" class="card" style="width: 100%; padding: 8px;">
                                            <?php if($stat['stat_type'] == 'six_months'): ?>
                                                <option value="1">الفترة 1 (السداسي الأول)</option>
                                                <option value="2">الفترة 2 (السداسي الثاني)</option>
                                            <?php else: ?>
                                                <?php foreach($arabic_months as $m_num => $m_name): ?>
                                                    <option value="<?php echo $m_num; ?>"><?php echo $m_name; ?></option>
                                                <?php endforeach; ?>
                                            <?php endif; ?>
                                        </select>
                                    </div>
                                    <?php endif; ?>
                                </div>

                                <div style="margin-bottom: 15px;">
                                    <label>اختر الملف (PDF, DOCX, Excel, الصور):</label>
                                    <input type="file" name="file" required style="display: block; margin-top: 5px;">
                                </div>
                                <div style="margin-bottom: 15px;">
                                    <label>ملاحظات:</label>
                                    <textarea name="notes" style="width: 100%; padding: 8px; border-radius: 5px; border: 1px solid #cbd5e1;"></textarea>
                                </div>
                                <div style="display: flex; gap: 10px;">
                                    <button type="submit" name="upload_file" style="background: #10b981; color: white; border: none; padding: 8px 20px; border-radius: 5px; cursor: pointer;">تأكيد الرفع</button>
                                    <button type="button" onclick="toggleUploadForm(<?php echo $stat['id']; ?>)" style="background: #64748b; color: white; border: none; padding: 8px 20px; border-radius: 5px; cursor: pointer;">إلغاء</button>
                                </div>
                            </form>
                        </div>

                        <div class="files-list">
                            <h4 style="font-size: 0.9rem; color: #64748b; margin-bottom: 10px;">الملفات المرفوعة:</h4>
                            <?php
                                $stmtFiles = $pdo->prepare("
                                    SELECT fe.*, u.full_name FROM file_exchanges fe 
                                    JOIN users u ON fe.user_id = u.id 
                                    WHERE fe.stat_id = ? AND (fe.user_id = ? OR u.parent_id = ? OR ? = 1)
                                    ORDER BY fe.stat_year DESC, fe.stat_period DESC
                                ");
                                $stmtFiles->execute([$stat['id'], $user_id, $user_id, $role_level]);
                                $files = $stmtFiles->fetchAll();
                                
                                if(empty($files)):
                            ?>
                                <p style="font-size: 0.85rem; color: #94a3b8;">لا توجد ملفات مرفوعة بعد.</p>
                            <?php else: ?>
                                <?php foreach($files as $file): 
                                    $ext = strtolower(pathinfo($file['file_name'], PATHINFO_EXTENSION));
                                    $icon = "fa-file-alt";
                                    if($ext == 'pdf') $icon = "fa-file-pdf";
                                    elseif(in_array($ext, ['xlsx', 'xls'])) $icon = "fa-file-excel";
                                    elseif(in_array($ext, ['docx', 'doc'])) $icon = "fa-file-word";
                                    elseif(in_array($ext, ['png', 'jpg', 'jpeg'])) $icon = "fa-file-image";
                                ?>
                                    <div class="file-item">
                                        <div class="file-info">
                                            <i class="fas <?php echo $icon; ?> file-icon"></i>
                                            <div>
                                                <div style="font-weight: bold;"><?php echo htmlspecialchars($file['file_name']); ?></div>
                                                <small style="color: #64748b;">
                                                    بواسطة: <?php echo htmlspecialchars($file['full_name']); ?> | 
                                                    السنة: <?php echo $file['stat_year']; ?> | 
                                                    الفترة: <?php 
                                                        if($stat['stat_type'] == 'yearly') echo 'سنوية';
                                                        elseif($stat['stat_type'] == 'six_months') echo ($file['stat_period'] == 1 ? 'السداسي 1' : 'السداسي 2');
                                                        else echo $arabic_months[$file['stat_period']] ?? $file['stat_period'];
                                                    ?>
                                                </small>
                                            </div>
                                        </div>
                                        <div style="display: flex; gap: 10px;">
                                            <a href="<?php echo $file['file_path']; ?>" target="_blank" class="btn" style="background: #f1f5f9; color: #1e293b; padding: 5px 10px; border-radius: 5px; text-decoration: none; font-size: 0.8rem;">
                                                <i class="fas fa-eye"></i> عرض
                                            </a>
                                            <a href="<?php echo $file['file_path']; ?>" download class="btn" style="background: #2563eb; color: white; padding: 5px 10px; border-radius: 5px; text-decoration: none; font-size: 0.8rem;">
                                                <i class="fas fa-download"></i> تحميل
                                            </a>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </div>
                    </div>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>
    </div>

    <script>
        function toggleUploadForm(id) {
            $('#upload-form-' + id).slideToggle();
        }
    </script>
</body>
</html>
