<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';
require_once 'includes/User.php';

if (!isset($_SESSION['user_id']) || !in_array($_SESSION['role_level'], [1, 2, 3])) {
    header("Location: index.php");
    exit();
}

$userObj = new User($pdo);
$statObj = new Stat($pdo);

if ($_SESSION['role_level'] == 1) {
    $stmtAll = $pdo->prepare("SELECT id, full_name FROM users WHERE id != ? ORDER BY full_name ASC");
    $stmtAll->execute([$_SESSION['user_id']]);
    $subordinates = $stmtAll->fetchAll();
} else {
    $subordinates = $userObj->getSubordinates($_SESSION['user_id'], false); 
}

$success = "";
$error = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $stat_name = filter_input(INPUT_POST, 'stat_name', FILTER_SANITIZE_SPECIAL_CHARS);
    $stat_type = filter_input(INPUT_POST, 'stat_type', FILTER_SANITIZE_SPECIAL_CHARS);
    $target_type = $_POST['target_type'] ?? 'all_subordinates';
    $assigned_users = isset($_POST['assigned_users']) && is_array($_POST['assigned_users']) ? array_map('intval', $_POST['assigned_users']) : [];
    $creator_id = $_SESSION['user_id'];
    
    if (empty($stat_name)) {
        $error = "يرجى إدخال اسم الإحصائية.";
    } elseif ($target_type === 'specific_users' && empty($assigned_users)) {
        $error = "يرجى اختيار مستخدم واحد على الأقل عند تحديد مستخدمين معينين.";
    } else {
        try {
            // التحقق من وجود معاملة نشطة
            if ($pdo->inTransaction()) {
                // لا نفعل شيئاً أو ننهيها إذا لزم الأمر
            }
            
            $pdo->beginTransaction();
            
            $table_name = "file_stat_" . time() . "_" . rand(100, 999);
            
            // 1. إدراج التعريف في stat_definitions
            $stmt = $pdo->prepare("INSERT INTO stat_definitions (creator_id, stat_name, stat_type, table_name, target_type) VALUES (?, ?, ?, ?, ?)");
            $stmt->execute([$creator_id, $stat_name, 'file_exchange', $table_name, $target_type]);
            $stat_id = $pdo->lastInsertId();

            // 2. إنشاء الجدول الخاص بالملفات
            $createTableSql = "CREATE TABLE `$table_name` (
                id INT AUTO_INCREMENT PRIMARY KEY,
                user_id INT NOT NULL,
                stat_year INT NOT NULL,
                stat_period INT NOT NULL,
                file_path VARCHAR(255),
                notes TEXT,
                is_completed TINYINT DEFAULT 0,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                INDEX (user_id),
                INDEX (stat_year, stat_period),
                FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci";
            
            $pdo->exec($createTableSql);

            // 3. تخصيص المستخدمين وإرسال الإشعارات
            $target_users = [];
            if ($target_type == 'specific_users' && !empty($assigned_users)) {
                $stmtAssign = $pdo->prepare("INSERT INTO stat_assignments (stat_id, user_id) VALUES (?, ?)");
                foreach ($assigned_users as $uid) {
                    $stmtAssign->execute([$stat_id, $uid]);
                    $target_users[] = $uid;
                }
            } else {
                foreach ($subordinates as $sub) {
                    $target_users[] = $sub['id'];
                }
            }

            foreach ($target_users as $uid) {
                if ($uid == $creator_id) continue;
                $statObj->addNotification($uid, "تم توجيه إحصائية ملفات جديدة لك: $stat_name");
                $stmtSub = $pdo->prepare("INSERT IGNORE INTO stat_submissions (stat_id, user_id, status) VALUES (?, ?, 'pending')");
                $stmtSub->execute([$stat_id, $uid]);
            }

            $pdo->commit();
            $success = "تم إنشاء إحصائية الملفات وتوجيهها بنجاح.";
        } catch (Exception $e) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $error = "خطأ في النظام: " . $e->getMessage();
            error_log("Error in create_file_stat: " . $e->getMessage());
        }
    }
}
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>إنشاء إحصائية ملفات | جامعة ميلة</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .alert { padding: 15px; border-radius: 8px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .alert-success { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }
        .alert-danger { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #334155; }
        .form-control { width: 100%; padding: 12px; border: 1px solid #e2e8f0; border-radius: 8px; font-size: 1rem; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        
        <div class="main-content">
            <div class="page-header" style="margin-bottom: 30px;">
                <h2><i class="fas fa-file-upload"></i> إنشاء إحصائية خاصة لتبادل الملفات</h2>
                <p style="color: #64748b;">هذا النوع من الإحصائيات يتيح للمستخدمين رفع ملفات (PDF, Excel, Word) بدلاً من ملء جداول البيانات.</p>
            </div>

            <?php if($success): ?>
                <div class="alert alert-success"><i class="fas fa-check-circle"></i> <?php echo $success; ?></div>
            <?php endif; ?>
            <?php if($error): ?>
                <div class="alert alert-danger"><i class="fas fa-exclamation-triangle"></i> <?php echo $error; ?></div>
            <?php endif; ?>

            <div class="card" style="max-width: 800px;">
                <form method="POST" id="fileStatForm">
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin-bottom: 20px;">
                        <div class="form-group">
                            <label>اسم الإحصائية:</label>
                            <input type="text" name="stat_name" class="form-control" required placeholder="مثلاً: تقارير النشاط الشهري">
                        </div>
                        <div class="form-group">
                            <label>دورية الإحصاء:</label>
                            <select name="stat_type" class="form-control">
                                <option value="monthly">شهري</option>
                                <option value="six_months">سداسي (كل 6 أشهر)</option>
                                <option value="yearly">سنوي</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="card" style="margin-bottom: 20px; background: #f8fafc; border: 1px solid #e2e8f0;">
                        <h3><i class="fas fa-user-tag"></i> توجيه الإحصائية (تحديد المستهدفين)</h3>
                        <div style="margin-top: 15px;">
                            <label style="display: block; margin-bottom: 12px; cursor: pointer;">
                                <input type="radio" name="target_type" value="all_subordinates" checked onclick="$('#userSelection').slideUp()"> 
                                <span style="margin-right: 8px;">توجيه لكافة التابعين المباشرين</span>
                            </label>
                            <label style="display: block; margin-bottom: 12px; cursor: pointer;">
                                <input type="radio" name="target_type" value="specific_users" onclick="$('#userSelection').slideDown()"> 
                                <span style="margin-right: 8px;">تحديد مستخدمين معينين</span>
                            </label>
                        </div>
                        
                        <div id="userSelection" style="display: none; margin-top: 15px; padding: 15px; border: 1px solid #e2e8f0; border-radius: 8px; max-height: 250px; overflow-y: auto; background: white;">
                            <label style="font-weight: bold; display: block; margin-bottom: 10px;">اختر المستخدمين:</label>
                            <?php if(empty($subordinates)): ?>
                                <p style="color: #94a3b8; font-size: 0.9rem;">لا يوجد مستخدمين تابعين حالياً.</p>
                            <?php else: ?>
                                <?php foreach($subordinates as $sub): ?>
                                    <label style="display: block; margin-bottom: 10px; cursor: pointer; padding: 5px; border-radius: 4px; transition: background 0.2s;">
                                        <input type="checkbox" name="assigned_users[]" value="<?php echo $sub['id']; ?>"> 
                                        <span style="margin-right: 8px;"><?php echo htmlspecialchars($sub['full_name']); ?></span>
                                    </label>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center; padding: 14px; background: #7c3aed; color: white; border: none; border-radius: 8px; font-weight: bold; cursor: pointer;">
                        <i class="fas fa-check"></i> إنشاء الإحصائية وتوجيهها
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script>
        $('#fileStatForm').on('submit', function(e) {
            const targetType = $('input[name="target_type"]:checked').val();
            if (targetType === 'specific_users') {
                const selectedUsers = $('input[name="assigned_users[]"]:checked').length;
                if (selectedUsers === 0) {
                    e.preventDefault();
                    alert('يجب اختيار مستخدم واحد على الأقل عند تحديد مستخدمين معينين.');
                }
            }
        });
    </script>
</body>
</html>
