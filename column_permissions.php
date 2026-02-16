<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role_level'] != 1) {
    header("Location: dashboard.php");
    exit();
}

$statObj = new Stat($pdo);
$stat_id = $_GET['id'] ?? null;

if (!$stat_id) {
    die("يرجى اختيار إحصائية لإدارة صلاحياتها.");
}

$stat = $statObj->getStatDetails($stat_id);

// إنشاء جدول الصلاحيات إذا لم يوجد
$pdo->exec("CREATE TABLE IF NOT EXISTS column_permissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    stat_id INT NOT NULL,
    column_id INT NOT NULL,
    role_level INT NOT NULL,
    can_view TINYINT DEFAULT 1,
    can_edit TINYINT DEFAULT 1,
    UNIQUE KEY (stat_id, column_id, role_level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

$message = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $perms = $_POST['perms'] ?? [];
    try {
        $pdo->beginTransaction();
        foreach ($perms as $col_id => $roles) {
            foreach ($roles as $role_level => $actions) {
                $can_view = isset($actions['view']) ? 1 : 0;
                $can_edit = isset($actions['edit']) ? 1 : 0;
                
                $stmt = $pdo->prepare("
                    INSERT INTO column_permissions (stat_id, column_id, role_level, can_view, can_edit) 
                    VALUES (?, ?, ?, ?, ?) 
                    ON DUPLICATE KEY UPDATE can_view = VALUES(can_view), can_edit = VALUES(can_edit)
                ");
                $stmt->execute([$stat_id, $col_id, $role_level, $can_view, $can_edit]);
            }
        }
        $pdo->commit();
        $message = "<div class='alert alert-success'>تم تحديث الصلاحيات بنجاح.</div>";
    } catch (Exception $e) {
        $pdo->rollBack();
        $message = "<div class='alert alert-danger'>خطأ: " . $e->getMessage() . "</div>";
    }
}

// جلب الصلاحيات الحالية
$stmtPerms = $pdo->prepare("SELECT * FROM column_permissions WHERE stat_id = ?");
$stmtPerms->execute([$stat_id]);
$current_perms = [];
while ($row = $stmtPerms->fetch()) {
    $current_perms[$row['column_id']][$row['role_level']] = $row;
}

$roles = [
    2 => 'مسؤول مركزي',
    3 => 'عميد / مدير',
    4 => 'رئيس قسم'
];
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>إدارة الصلاحيات الدقيقة | جامعة ميلة</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .perm-table th { background: #f8fafc; padding: 15px; }
        .perm-table td { padding: 15px; border-bottom: 1px solid #f1f5f9; text-align: center; }
        .role-badge { padding: 5px 10px; border-radius: 20px; font-size: 0.8rem; background: #e2e8f0; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        <div class="main-content">
            <div class="page-header">
                <h2><i class="fas fa-user-lock"></i> إدارة الصلاحيات الدقيقة للأعمدة</h2>
                <p style="color: #64748b;">تحكم في من يمكنه رؤية أو تعديل كل حقل بيانات في إحصائية: <strong><?php echo $stat['stat_name']; ?></strong></p>
            </div>

            <?php echo $message; ?>

            <form method="POST" class="card" style="margin-top: 20px;">
                <table class="perm-table" style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr>
                            <th style="text-align: right;">العمود / الحقل</th>
                            <?php foreach ($roles as $r_id => $r_name): ?>
                                <th><?php echo $r_name; ?></th>
                            <?php endforeach; ?>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($stat['columns'] as $col): ?>
                            <tr>
                                <td style="text-align: right; font-weight: bold;"><?php echo $col['column_label']; ?></td>
                                <?php foreach ($roles as $r_id => $r_name): ?>
                                    <td>
                                        <label style="display: block; margin-bottom: 5px;">
                                            <input type="checkbox" name="perms[<?php echo $col['id']; ?>][<?php echo $r_id; ?>][view]" value="1" 
                                                <?php echo (!isset($current_perms[$col['id']][$r_id]) || $current_perms[$col['id']][$r_id]['can_view']) ? 'checked' : ''; ?>> رؤية
                                        </label>
                                        <label>
                                            <input type="checkbox" name="perms[<?php echo $col['id']; ?>][<?php echo $r_id; ?>][edit]" value="1"
                                                <?php echo (!isset($current_perms[$col['id']][$r_id]) || $current_perms[$col['id']][$r_id]['can_edit']) ? 'checked' : ''; ?>> تعديل
                                        </label>
                                    </td>
                                <?php endforeach; ?>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
                <div style="margin-top: 30px; text-align: left;">
                    <button type="submit" class="btn btn-primary" style="padding: 12px 40px; background: #2563eb; color: white; border: none; border-radius: 8px; cursor: pointer;">حفظ كافة الصلاحيات</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
