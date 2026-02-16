<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id']) || !isset($_SESSION['role_level'])) {
    header("Location: index.php");
    exit();
}

$statObj = new Stat($pdo);
$notifications = $statObj->getNotifications($_SESSION['user_id']);
$unread_count = 0;
foreach($notifications as $n) if(!$n['is_read']) $unread_count++;

// جلب عدد الرسائل غير المقروءة
$stmtMsg = $pdo->prepare("SELECT COUNT(*) FROM messages WHERE receiver_id = ? AND is_read = 0");
$stmtMsg->execute([$_SESSION['user_id']]);
$unread_messages = $stmtMsg->fetchColumn();

$role_name = "";
$role_level = (int)$_SESSION['role_level'];
switch($role_level) {
    case 1: $role_name = "مدير الجامعة"; break;
    case 2: $role_name = "نائب مدير / مسؤول مركزي"; break;
    case 3: $role_name = "عميد كلية / مدير"; break;
    case 4: $role_name = "رئيس قسم"; break;
    default: $role_name = "مستخدم"; break;
}

// إحصائيات سريعة
$stats_list = $statObj->getAvailableStats($_SESSION['user_id'], $role_level);
$total_stats_defined = count($stats_list);

$total_users = 0;
if ($role_level == 1) {
    $stmt = $pdo->query("SELECT COUNT(*) FROM users");
    $total_users = $stmt->fetchColumn();
} else {
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM users WHERE parent_id = ?");
    $stmt->execute([$_SESSION['user_id']]);
    $total_users = $stmt->fetchColumn();
}
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>لوحة التحكم | نظام الإحصائيات</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="assets/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .notification-bell { position: relative; cursor: pointer; }
        .badge { position: absolute; top: -5px; right: -5px; background: #ef4444; color: white; border-radius: 50%; padding: 2px 6px; font-size: 0.7em; }
        .notif-dropdown { 
            display: none; position: absolute; left: 0; top: 40px; width: 300px; background: white; 
            box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1); border-radius: 8px; z-index: 100; border: 1px solid #e2e8f0;
        }
        .notif-item { padding: 12px; border-bottom: 1px solid #f1f5f9; font-size: 0.9em; }
        .notif-item.unread { background: #f0f9ff; }
        .main-content { padding: 30px; }
        .stat-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .card { background: white; padding: 20px; border-radius: 12px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); }
        .welcome-banner { 
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%); 
            color: white; padding: 30px; border-radius: 15px; margin-bottom: 30px;
            display: flex; justify-content: space-between; align-items: center;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>

        <div class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <div class="welcome-text">
                    <h1 style="font-size: 1.8rem; color: #1e293b;">مرحباً، <?php echo explode(' ', $_SESSION['full_name'])[0]; ?>!</h1>
                    <p style="color: #64748b;">أهلاً بك في نظام الإحصائيات الجامعي المطور.</p>
                </div>
                <div style="display: flex; gap: 20px; align-items: center;">
                    <div class="notification-bell" onclick="$('#notifDropdown').toggle()">
                        <i class="fas fa-bell fa-2x" style="color: #64748b;"></i>
                        <?php if($unread_count > 0): ?>
                            <span class="badge"><?php echo $unread_count; ?></span>
                        <?php endif; ?>
                        <div id="notifDropdown" class="notif-dropdown">
                            <div style="padding: 15px; border-bottom: 1px solid #f1f5f9; font-weight: bold; display: flex; justify-content: space-between;">
                                <span>الإشعارات</span>
                                <a href="#" onclick="markRead()" style="font-size: 0.8rem; color: #2563eb; text-decoration: none;">تحديد كقروء</a>
                            </div>
                            <div style="max-height: 300px; overflow-y: auto;">
                                <?php if(empty($notifications)): ?>
                                    <div class="notif-item">لا توجد إشعارات جديدة</div>
                                <?php else: ?>
                                    <?php foreach($notifications as $n): ?>
                                        <div class="notif-item <?php echo !$n['is_read'] ? 'unread' : ''; ?>">
                                            <?php echo htmlspecialchars($n['message']); ?>
                                            <div style="font-size: 0.7rem; color: #94a3b8; margin-top: 5px;"><?php echo $n['created_at']; ?></div>
                                        </div>
                                    <?php endforeach; ?>
                                <?php endif; ?>
                            </div>
                        </div>
                    </div>
                    <div style="text-align: left;">
                        <div id="current-date" style="font-size: 1.1rem; font-weight: bold; color: #1e293b;"><?php echo date('Y-m-d'); ?></div>
                        <div style="font-size: 0.9rem; color: #64748b;"><?php echo $role_name; ?></div>
                    </div>
                </div>
            </div>

            <div class="welcome-banner">
                <div style="max-width: 600px;">
                    <h2 style="margin-bottom: 10px;">نظرة عامة على الأداء</h2>
                    <p>يمكنك من خلال هذه اللوحة متابعة سير عملية جمع الإحصائيات، مراسلة المسؤولين، وتحليل البيانات بشكل فوري ودقيق.</p>
                </div>
                <i class="fas fa-chart-line fa-4x" style="opacity: 0.2;"></i>
            </div>

            <div class="stat-grid">
                <div class="card glass-card hover-lift">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <h4>الإحصائيات المتاحة</h4>
                        <div style="background: #e0e7ff; padding: 10px; border-radius: 10px;"><i class="fas fa-chart-pie fa-lg" style="color: #2563eb;"></i></div>
                    </div>
                    <div style="font-size: 2.5em; font-weight: 800; color: #2563eb; margin-top: 15px;"><?php echo $total_stats_defined; ?></div>
                    <div style="font-size: 0.8rem; color: #64748b; margin-top: 5px;">نماذج مفعلة حالياً</div>
                </div>
                <div class="card glass-card hover-lift">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <h4>المستخدمين التابعين</h4>
                        <div style="background: #d1fae5; padding: 10px; border-radius: 10px;"><i class="fas fa-users fa-lg" style="color: #10b981;"></i></div>
                    </div>
                    <div style="font-size: 2.5em; font-weight: 800; color: #10b981; margin-top: 15px;"><?php echo $total_users; ?></div>
                    <div style="font-size: 0.8rem; color: #64748b; margin-top: 5px;">تحت إدارتك المباشرة</div>
                </div>
                <div class="card glass-card hover-lift">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <h4>الرسائل الجديدة</h4>
                        <div style="background: #fef3c7; padding: 10px; border-radius: 10px;"><i class="fas fa-envelope-open-text fa-lg" style="color: #f59e0b;"></i></div>
                    </div>
                    <div style="font-size: 2.5em; font-weight: 800; color: #f59e0b; margin-top: 15px;"><?php echo $unread_messages; ?></div>
                    <div style="font-size: 0.8rem; color: #64748b; margin-top: 5px;">بانتظار المراجعة</div>
                </div>
            </div>

            <div class="card">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h3><i class="fas fa-robot"></i> تحليل الأداء الذكي</h3>
                </div>
                <div class="ai-analysis" style="background: #f8fafc; padding: 15px; border-radius: 10px; border-right: 4px solid #10b981; margin-bottom: 20px;">
                    <p><strong>تحليل النظام:</strong> 
                    نلاحظ استجابة جيدة في ملء الإحصائيات. يوصى بمتابعة الإحصائيات قيد التعبئة لضمان اكتمال البيانات في الوقت المحدد.
                    </p>
                </div>
                <canvas id="mainChart" style="max-height: 350px;"></canvas>
            </div>
        </div>
    </div>

    <script>
        const ctx = document.getElementById('mainChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['جانفي', 'فيفري', 'مارس', 'أفريل', 'ماي', 'جوان'],
                datasets: [{
                    label: 'نسبة الإنجاز',
                    data: [65, 72, 68, 85, 90, 95],
                    borderColor: '#2563eb',
                    backgroundColor: 'rgba(37, 99, 235, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { position: 'bottom' }
                },
                scales: {
                    y: { beginAtZero: true, max: 100 }
                }
            }
        });

        function markRead() {
            $.post('api/user_actions.php', { action: 'mark_notifications_read' }, function() {
                $('.badge').fadeOut();
                $('.notif-item').removeClass('unread');
            });
        }

        $(document).on('click', function(e) {
            if (!$(e.target).closest('.notification-bell').length) {
                $('#notifDropdown').hide();
            }
        });
    </script>
</body>
</html>
