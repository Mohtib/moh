<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id'])) {
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Unauthorized']);
    exit();
}

$statObj = new Stat($pdo);

// إنشاء جدول التعليقات إذا لم يوجد
$pdo->exec("CREATE TABLE IF NOT EXISTS stat_data_comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    stat_id INT NOT NULL,
    data_id INT NOT NULL, -- معرف السجل في الجدول الديناميكي
    user_id INT NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

// معالجة إضافة تعليق
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['action']) && $_POST['action'] == 'add') {
    $stat_id = (int)$_POST['stat_id'];
    $data_id = (int)$_POST['data_id'];
    $comment = filter_input(INPUT_POST, 'comment', FILTER_SANITIZE_SPECIAL_CHARS);
    
    // جلب اسم الجدول الديناميكي
    $stmtTable = $pdo->prepare("SELECT table_name FROM stat_definitions WHERE id = ?");
    $stmtTable->execute([$stat_id]);
    $table_name = $stmtTable->fetchColumn();
    
    if (!$table_name) {
        echo json_encode(['success' => false, 'error' => 'Stat not found']);
        exit();
    }
    
    // التحقق من أن المستخدم لديه صلاحية على هذا السجل
    $stmtCheck = $pdo->prepare("SELECT user_id FROM `$table_name` WHERE id = ?");
    $stmtCheck->execute([$data_id]);
    $owner_id = $stmtCheck->fetchColumn();
    
    // يمكن التعليق إذا كان المستخدم هو صاحب السجل أو مدير (أو أي صلاحية أخرى حسب الرغبة)
    if ($owner_id != $_SESSION['user_id'] && $_SESSION['role_level'] > 2) {
        echo json_encode(['success' => false, 'error' => 'Unauthorized']);
        exit();
    }
    
    $stmt = $pdo->prepare("INSERT INTO stat_data_comments (stat_id, data_id, user_id, comment) VALUES (?, ?, ?, ?)");
    $res = $stmt->execute([$stat_id, $data_id, $_SESSION['user_id'], $comment]);
    
    if ($res) {
        // إرسال إشعار لصاحب البيانات (إذا كان المعلق شخصاً آخر)
        if ($owner_id && $owner_id != $_SESSION['user_id']) {
            $stat_details = $statObj->getStatDetails($stat_id);
            $statObj->addNotification($owner_id, "لديك ملاحظة جديدة من {$_SESSION['full_name']} بخصوص إحصائية {$stat_details['stat_name']}");
        }
    }
    
    header('Content-Type: application/json');
    echo json_encode(['success' => $res]);
    exit();
}

// جلب التعليقات
if (isset($_GET['stat_id']) && isset($_GET['data_id'])) {
    $stat_id = (int)$_GET['stat_id'];
    $data_id = (int)$_GET['data_id'];
    
    $stmt = $pdo->prepare("
        SELECT c.*, u.full_name, u.role_level 
        FROM stat_data_comments c 
        JOIN users u ON c.user_id = u.id 
        WHERE c.stat_id = ? AND c.data_id = ? 
        ORDER BY c.created_at ASC
    ");
    $stmt->execute([$stat_id, $data_id]);
    $comments = $stmt->fetchAll();
    
    header('Content-Type: application/json');
    echo json_encode($comments);
    exit();
}
?>