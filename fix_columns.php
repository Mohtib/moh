<?php
require_once 'config/db.php';

echo "<h2>جاري تحديث هيكلة الجداول الديناميكية...</h2>";

try {
    // جلب جميع الجداول الديناميكية من تعريفات الإحصائيات
    $stmt = $pdo->query("SELECT table_name FROM stat_definitions");
    $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);

    foreach ($tables as $table) {
        echo "فحص الجدول: $table ... ";
        
        // التحقق من وجود حقل is_completed
        $check = $pdo->query("SHOW COLUMNS FROM `$table` LIKE 'is_completed'");
        if ($check->rowCount() == 0) {
            $pdo->exec("ALTER TABLE `$table` ADD COLUMN `is_completed` TINYINT(1) DEFAULT 0 AFTER `stat_period` ");
            echo "<span style='color:green'>تم إضافة حقل is_completed بنجاح.</span><br>";
        } else {
            echo "<span style='color:blue'>الحقل موجود مسبقاً.</span><br>";
        }
    }
    
    echo "<h3>تم الانتهاء من تحديث جميع الجداول بنجاح!</h3>";
    echo "<a href='dashboard.php'>العودة للوحة التحكم</a>";

} catch (Exception $e) {
    echo "<span style='color:red'>خطأ: " . $e->getMessage() . "</span>";
}
?>
