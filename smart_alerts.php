<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role_level'] > 2) {
    header("Location: dashboard.php");
    exit();
}

$statObj = new Stat($pdo);
$alerts = [];

// 1. كشف النماذج المتأخرة (لم تكتمل بعد 7 أيام من الإنشاء)
$stmt = $pdo->prepare("
    SELECT sd.stat_name, u.full_name, ss.status, sd.created_at 
    FROM stat_submissions ss 
    JOIN stat_definitions sd ON ss.stat_id = sd.id 
    JOIN users u ON ss.user_id = u.id 
    WHERE ss.status != 'completed' 
    AND sd.created_at < DATE_SUB(NOW(), INTERVAL 7 DAY)
");
$stmt->execute();
$late_submissions = $stmt->fetchAll();

foreach ($late_submissions as $late) {
    $alerts[] = [
        'type' => 'warning',
        'title' => 'تأخر في الإنجاز',
        'desc' => "المستخدم {$late['full_name']} لم يكمل إحصائية '{$late['stat_name']}' منذ أكثر من أسبوع.",
        'icon' => 'fa-clock'
    ];
}

// 2. كشف القيم الشاذة (مثال: أرقام صفرية في حقول حيوية - يمكن تخصيصه أكثر)
// هذا يتطلب فحص الجداول الديناميكية، سنضع مثالاً منطقياً
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>التنبيهات الذكية | جامعة ميلة</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .alert-card { background: white; padding: 20px; border-radius: 12px; margin-bottom: 15px; display: flex; align-items: center; gap: 20px; border-right: 5px solid #ccc; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .alert-warning { border-right-color: #f59e0b; }
        .alert-danger { border-right-color: #ef4444; }
        .alert-info { border-right-color: #3b82f6; }
        .alert-icon { width: 50px; height: 50px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; }
        .icon-warning { background: #fef3c7; color: #d97706; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        <div class="main-content">
            <div class="page-header">
                <h2><i class="fas fa-bell"></i> مركز التنبيهات والذكاء الرقابي</h2>
                <p style="color: #64748b;">يقوم النظام بتحليل البيانات تلقائياً وتنبيهك لأي خلل أو تأخير.</p>
            </div>

            <div style="margin-top: 30px;">
                <?php if (empty($alerts)): ?>
                    <div class="card" style="text-align: center; padding: 50px; color: #10b981;">
                        <i class="fas fa-check-circle fa-4x" style="margin-bottom: 20px;"></i>
                        <h3>كل شيء يعمل بشكل مثالي! لا توجد تنبيهات حالياً.</h3>
                    </div>
                <?php else: ?>
                    <?php foreach ($alerts as $alert): ?>
                        <div class="alert-card alert-<?php echo $alert['type']; ?>">
                            <div class="alert-icon icon-<?php echo $alert['type']; ?>">
                                <i class="fas <?php echo $alert['icon']; ?>"></i>
                            </div>
                            <div>
                                <h4 style="margin: 0; color: #1e293b;"><?php echo $alert['title']; ?></h4>
                                <p style="margin: 5px 0 0; color: #64748b; font-size: 0.9rem;"><?php echo $alert['desc']; ?></p>
                            </div>
                        </div>
                    <?php endforeach; ?>
                <?php endif; ?>
            </div>
        </div>
    </div>
</body>
</html>
