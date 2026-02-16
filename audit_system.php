<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role_level'] != 1) {
    header("Location: dashboard.php");
    exit();
}

// دالة لجلب سجل الأنشطة
function getAuditLogs($pdo, $limit = 50) {
    $stmt = $pdo->prepare("
        SELECT al.*, u.full_name, u.role_level 
        FROM audit_logs al 
        JOIN users u ON al.user_id = u.id 
        ORDER BY al.created_at DESC 
        LIMIT ?
    ");
    $stmt->execute([$limit]);
    return $stmt->fetchAll();
}

$logs = getAuditLogs($pdo);
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>سجل الأنشطة والرقابة | جامعة ميلة</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .log-item { border-bottom: 1px solid #f1f5f9; padding: 15px; transition: background 0.2s; }
        .log-item:hover { background: #f8fafc; }
        .log-time { font-size: 0.8rem; color: #94a3b8; }
        .log-user { font-weight: bold; color: #2563eb; }
        .log-action { margin: 5px 0; font-size: 0.95rem; }
        .badge-action { padding: 3px 8px; border-radius: 4px; font-size: 0.75rem; font-weight: bold; }
        .bg-create { background: #dcfce7; color: #166534; }
        .bg-update { background: #dbeafe; color: #1e40af; }
        .bg-delete { background: #fee2e2; color: #991b1b; }
        .bg-login { background: #fef9c3; color: #854d0e; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        <div class="main-content">
            <div class="page-header">
                <h2><i class="fas fa-shield-alt"></i> سجل الأنشطة والرقابة النظامية</h2>
                <p style="color: #64748b;">تتبع كافة العمليات الحساسة التي تتم على النظام لضمان الشفافية التامة.</p>
            </div>

            <div class="card" style="margin-top: 20px;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h3><i class="fas fa-list"></i> آخر العمليات المنفذة</h3>
                    <button class="btn btn-primary" onclick="window.location.reload()"><i class="fas fa-sync"></i> تحديث</button>
                </div>

                <div class="logs-container">
                    <?php if (empty($logs)): ?>
                        <div style="text-align: center; padding: 50px; color: #94a3b8;">
                            <i class="fas fa-history fa-3x" style="margin-bottom: 15px;"></i>
                            <p>لا توجد سجلات أنشطة حالياً. سيتم تسجيل العمليات تلقائياً عند حدوثها.</p>
                        </div>
                    <?php else: ?>
                        <?php foreach ($logs as $log): ?>
                            <div class="log-item">
                                <div style="display: flex; justify-content: space-between;">
                                    <div>
                                        <span class="log-user"><?php echo htmlspecialchars($log['full_name']); ?></span>
                                        <span class="log-time"> (<?php echo $log['created_at']; ?>)</span>
                                    </div>
                                    <span class="badge-action bg-<?php echo strtolower($log['action_type']); ?>">
                                        <?php echo htmlspecialchars($log['action_type']); ?>
                                    </span>
                                </div>
                                <div class="log-action"><?php echo htmlspecialchars($log['description']); ?></div>
                                <?php if ($log['ip_address']): ?>
                                    <div style="font-size: 0.75rem; color: #cbd5e1;">IP: <?php echo $log['ip_address']; ?></div>
                                <?php endif; ?>
                            </div>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
