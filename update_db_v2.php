<?php
require_once 'config/db.php';

try {
    // تحديث جدول file_exchanges لإضافة السنة والفترة
    $pdo->exec("ALTER TABLE file_exchanges ADD COLUMN IF NOT EXISTS stat_year INT AFTER notes");
    $pdo->exec("ALTER TABLE file_exchanges ADD COLUMN IF NOT EXISTS stat_period INT AFTER stat_year");
    
    // تحديث جدول stat_definitions لإضافة نوع التوجيه
    $pdo->exec("ALTER TABLE stat_definitions ADD COLUMN IF NOT EXISTS target_type ENUM('all_subordinates', 'specific_users') DEFAULT 'all_subordinates' AFTER table_name");

    echo "تم تحديث قاعدة البيانات بنجاح.";
} catch (Exception $e) {
    echo "خطأ في التحديث: " . $e->getMessage();
}
?>
