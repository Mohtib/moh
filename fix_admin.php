<?php
require_once 'config/db.php';

// توليد هاش جديد لكلمة المرور admin123
$new_password = password_hash('admin123', PASSWORD_DEFAULT);

try {
    // تحديث كلمة مرور الأدمن
    $stmt = $pdo->prepare("UPDATE users SET password = ? WHERE username = 'admin'");
    $stmt->execute([$new_password]);
    
    // إذا لم يكن موجوداً، قم بإضافته
    if ($stmt->rowCount() == 0) {
        $stmt = $pdo->prepare("INSERT INTO users (username, password, full_name, role_level) VALUES ('admin', ?, 'مدير الجامعة', 1)");
        $stmt->execute([$new_password]);
    }
    
    echo "تم تحديث كلمة مرور المدير بنجاح. يمكنك الآن الدخول باستخدام:<br>المستخدم: admin<br>كلمة المرور: admin123<br><br><a href='index.php'>الذهاب لصفحة الدخول</a>";
} catch (Exception $e) {
    echo "خطأ: " . $e->getMessage();
}
?>
