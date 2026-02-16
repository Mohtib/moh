<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role_level'] > 3) {
    header("Location: dashboard.php");
    exit();
}

$statObj = new Stat($pdo);
$message = "";

if (isset($_GET['delete'])) {
    $stat_id = (int)$_GET['delete'];
    if ($statObj->deleteStat($stat_id, $_SESSION['user_id'], $_SESSION['role_level'])) {
        $message = "<div class='alert alert-success'><i class='fas fa-check-circle'></i> تم حذف الإحصائية بنجاح.</div>";
    } else {
        $message = "<div class='alert alert-danger'><i class='fas fa-times-circle'></i> فشل الحذف. قد لا تملك الصلاحية أو حدث خطأ تقني.</div>";
    }
}

// جلب الإحصائيات مع تطبيق التصفية الهرمية المحدثة في كلاس Stat
$stats = $statObj->getAvailableStats($_SESSION['user_id'], $_SESSION['role_level']);
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>إدارة الإحصائيات | نظام الإحصائيات</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        th, td { padding: 15px; text-align: right; border-bottom: 1px solid #f1f5f9; }
        th { background: #f8fafc; font-weight: 700; color: #1e293b; }
        .btn-sm { padding: 6px 12px; font-size: 0.85em; border-radius: 6px; text-decoration: none; display: inline-flex; align-items: center; gap: 5px; margin-bottom: 2px; }
        .alert { padding: 15px; border-radius: 8px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .alert-success { background: #dcfce7; color: #166534; }
        .alert-danger { background: #fee2e2; color: #991b1b; }
        .badge-type { padding: 3px 8px; border-radius: 12px; font-size: 0.75rem; font-weight: bold; }
        .type-monthly { background: #dbeafe; color: #1e40af; }
        .type-six_months { background: #fef3c7; color: #92400e; }
        .type-yearly { background: #d1fae5; color: #065f46; }
        .type-file { background: #f3e8ff; color: #6b21a8; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>

        <div class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
                <div>
                    <h2><i class="fas fa-tasks"></i> إدارة الإحصائيات</h2>
                    <p style="color: #64748b;">عرض وإدارة الإحصائيات الخاصة بك وبتابعيك هرمياً.</p>
                </div>
                <div style="display: flex; gap: 10px;">
                    <a href="create_stat.php" class="btn" style="background: #2563eb; color: white; padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: bold;"><i class="fas fa-plus"></i> إحصائية بيانات</a>
                    <a href="create_file_stat.php" class="btn" style="background: #7c3aed; color: white; padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: bold;"><i class="fas fa-file-upload"></i> إحصائية ملفات</a>
                </div>
            </div>

            <?php echo $message; ?>

            <table>
                <thead>
                    <tr>
                        <th>اسم الإحصائية</th>
                        <th>النوع</th>
                        <th>بواسطة</th>
                        <th>تاريخ الإنشاء</th>
                        <th>الإجراءات</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if(empty($stats)): ?>
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 40px; color: #94a3b8;">لا توجد إحصائيات متاحة للعرض حالياً.</td>
                        </tr>
                    <?php else: ?>
                        <?php foreach ($stats as $stat): ?>
                        <tr>
                            <td><strong><?php echo htmlspecialchars($stat['stat_name']); ?></strong></td>
                            <td>
                                <span class="badge-type type-<?php echo $stat['stat_type']; ?>">
                                    <?php 
                                        if($stat['stat_type'] == 'monthly') echo 'شهري';
                                        elseif($stat['stat_type'] == 'six_months') echo 'سداسي';
                                        elseif($stat['stat_type'] == 'yearly') echo 'سنوي';
                                        else echo 'ملفات';
                                    ?>
                                </span>
                            </td>
                            <td><?php echo htmlspecialchars($stat['creator_name']); ?></td>
                            <td><?php echo date('Y-m-d', strtotime($stat['created_at'])); ?></td>
                            <td>
                                <?php if($stat['stat_type'] == 'file_exchange'): ?>
                                    <a href="file_stats.php" class="btn-sm" style="background: #eff6ff; color: #2563eb; border: 1px solid #bfdbfe;"><i class="fas fa-folder-open"></i> إدارة الملفات</a>
                                <?php else: ?>
                                    <a href="view_stat_data.php?id=<?php echo $stat['id']; ?>" class="btn-sm" style="background: #f8fafc; color: #475569; border: 1px solid #e2e8f0;" title="عرض البيانات"><i class="fas fa-eye"></i> عرض</a>
                                    
                                    <!-- خيارات متقدمة للمدير أو المنشئ -->
                                    <?php if($_SESSION['role_level'] == 1 || $stat['creator_id'] == $_SESSION['user_id']): ?>
                                        <a href="hyper_analytics.php?id=<?php echo $stat['id']; ?>" class="btn-sm" style="background: #eff6ff; color: #2563eb; border: 1px solid #bfdbfe;" title="التحليل الفائق"><i class="fas fa-microchip"></i> فائق</a>
                                        <a href="official_pdf_report.php?id=<?php echo $stat['id']; ?>" class="btn-sm" style="background: #f0fdf4; color: #166534; border: 1px solid #bbf7d0;" title="تقرير PDF احترافي"><i class="fas fa-file-pdf"></i> PDF</a>
                                    <?php endif; ?>
                                <?php endif; ?>
                                
                                <?php if($stat['creator_id'] == $_SESSION['user_id'] || $_SESSION['role_level'] == 1): ?>
                                    <a href="create_stat.php?edit_id=<?php echo $stat['id']; ?>" class="btn-sm" style="background: #fef3c7; color: #92400e; border: 1px solid #fde68a;"><i class="fas fa-edit"></i> تعديل</a>
                                    <a href="?delete=<?php echo $stat['id']; ?>" class="btn-sm" style="background: #fee2e2; color: #991b1b; border: 1px solid #fecaca;" onclick="return confirm('هل أنت متأكد من حذف هذه الإحصائية وكافة بياناتها؟')"><i class="fas fa-trash"></i> حذف</a>
                                <?php endif; ?>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
