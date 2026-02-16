<?php
require_once 'config/db.php';

$sql = file_get_contents('new_updates.sql');

try {
    // تقسيم الملف إلى جمل SQL منفصلة
    $queries = explode(';', $sql);
    foreach ($queries as $query) {
        $query = trim($query);
        if (!empty($query)) {
            $pdo->exec($query);
        }
    }
    echo "تم تحديث قاعدة البيانات بنجاح.";
} catch (PDOException $e) {
    echo "خطأ أثناء التحديث: " . $e->getMessage();
}
?>
