<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role_level'] != 1) {
    header("Location: dashboard.php");
    exit();
}

$message = "";
$statObj = new Stat($pdo);

// دالة للتحقق من وجود Foreign Key يشير إلى users في جدول معين وحذفه
function dropForeignKeyToUsers($pdo, $table) {
    $stmt = $pdo->prepare("
        SELECT CONSTRAINT_NAME 
        FROM information_schema.KEY_COLUMN_USAGE 
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = ? 
          AND REFERENCED_TABLE_NAME = 'users'
    ");
    $stmt->execute([$table]);
    $fk = $stmt->fetchColumn();
    if ($fk) {
        $pdo->exec("ALTER TABLE `$table` DROP FOREIGN KEY `$fk`");
        return true;
    }
    return false;
}

// معالجة طلب الأرشفة
if (isset($_POST['archive_year'])) {
    $year = (int)$_POST['archive_year'];
    try {
        $pdo->beginTransaction();
        
        // جلب كافة الإحصائيات (غير ملفات)
        $stats = $statObj->getAvailableStats($_SESSION['user_id'], 1);
        $archived_count = 0;
        $archived_tables = [];
        
        foreach ($stats as $s) {
            if ($s['stat_type'] == 'file_exchange') continue;
            
            $table = $s['table_name'];
            $archive_table = $table . "_archive_" . $year;
            
            // 1. إنشاء جدول الأرشفة إذا لم يوجد (بنفس الهيكل)
            $pdo->exec("CREATE TABLE IF NOT EXISTS `$archive_table` LIKE `$table`");
            
            // 2. إزالة أي Foreign Key يشير إلى users (لأن البيانات المؤرشفة لا يجب أن تتأثر بحذف المستخدمين)
            dropForeignKeyToUsers($pdo, $archive_table);
            
            // 3. نقل البيانات من الجدول الأصلي إلى جدول الأرشفة
            $stmt = $pdo->prepare("INSERT INTO `$archive_table` SELECT * FROM `$table` WHERE stat_year = ?");
            $stmt->execute([$year]);
            $count = $stmt->rowCount();
            
            if ($count > 0) {
                // 4. (اختياري) حذف البيانات من الجدول النشط - يمكن تفعيله حسب الرغبة
                // $pdo->prepare("DELETE FROM `$table` WHERE stat_year = ?")->execute([$year]);
                $archived_count += $count;
                $archived_tables[] = $archive_table;
            }
        }
        
        $pdo->commit();
        $message = "<div class='alert alert-success'>✅ تمت عملية الأرشفة بنجاح لسنة $year. تم أرشفة $archived_count سجلاً في " . count($archived_tables) . " جدول.</div>";
    } catch (Exception $e) {
        $pdo->rollBack();
        $message = "<div class='alert alert-danger'>❌ خطأ في الأرشفة: " . $e->getMessage() . "</div>";
    }
}

// جلب قائمة جداول الأرشيف الموجودة (لمحة سريعة)
$archive_tables = [];
try {
    $stmt = $pdo->query("SHOW TABLES LIKE '%\_archive\_%'");
    $archive_tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
} catch (Exception $e) {
    // تجاهل
}
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>نظام الأرشفة المتقدم | جامعة ميلة</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .alert { padding: 15px; border-radius: 8px; margin-bottom: 20px; }
        .alert-success { background: #d1fae5; color: #065f46; border: 1px solid #a7f3d0; }
        .alert-danger { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin-top: 20px; }
        .stat-card { background: #fff; padding: 20px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); border: 1px solid #e2e8f0; }
        .stat-card h3 { margin-top: 0; color: #1e293b; }
        .archive-list { background: #f8fafc; padding: 15px; border-radius: 8px; margin-top: 15px; }
        .archive-item { display: flex; justify-content: space-between; align-items: center; padding: 8px; border-bottom: 1px solid #e2e8f0; }
        .archive-item:last-child { border-bottom: none; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        <div class="main-content">
            <h2><i class="fas fa-archive"></i> إدارة الأرشفة والبيانات التاريخية</h2>
            <p style="color: #64748b;">تتيح هذه الواجهة لمدير الجامعة أرشفة بيانات السنوات السابقة لتحسين أداء النظام وضمان سلامة البيانات التاريخية.</p>
            
            <?php echo $message; ?>

            <div class="stats-grid">
                <div class="stat-card">
                    <h3><i class="fas fa-plus-square"></i> إنشاء أرشيف جديد</h3>
                    <form method="POST" onsubmit="return confirm('هل أنت متأكد من بدء عملية الأرشفة؟ سيتم إنشاء نسخ احتياطية من كافة البيانات لهذه السنة.')">
                        <div class="form-group" style="margin: 20px 0;">
                            <label>اختر السنة للأرشفة:</label>
                            <select name="archive_year" class="card" style="width: 100%; padding: 12px; margin-top: 10px;" required>
                                <?php for($y=date('Y')-1; $y>=2020; $y--) echo "<option value='$y'>سنة $y</option>"; ?>
                            </select>
                        </div>
                        <button type="submit" class="btn" style="background: #2563eb; color: white; width: 100%; padding: 15px; border: none; border-radius: 8px; font-weight: bold; cursor: pointer;">
                            <i class="fas fa-archive"></i> بدء عملية الأرشفة الآن
                        </button>
                    </form>
                </div>

                <div class="stat-card">
                    <h3><i class="fas fa-info-circle"></i> حالة قاعدة البيانات</h3>
                    <div style="padding: 15px; background: #f8fafc; border-radius: 10px; margin-top: 15px;">
                        <ul style="line-height: 2; list-style: none; padding-right: 0;">
                            <li><i class="fas fa-table"></i> إجمالي النماذج النشطة: <strong><?php echo count($statObj->getAvailableStats($_SESSION['user_id'], 1)); ?></strong></li>
                            <li><i class="fas fa-database"></i> عدد جداول الأرشيف: <strong><?php echo count($archive_tables); ?></strong></li>
                            <li><i class="fas fa-hdd"></i> حجم البيانات المقدر: <strong>خفيف</strong></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="card" style="margin-top: 30px;">
                <h3><i class="fas fa-history"></i> سجل الأرشيفات المتوفرة</h3>
                <?php if (empty($archive_tables)): ?>
                    <div style="text-align: center; padding: 30px; color: #94a3b8;">
                        <i class="fas fa-box-open fa-3x" style="margin-bottom: 15px;"></i>
                        <p>لا توجد أرشيفات منشأة حالياً.</p>
                    </div>
                <?php else: ?>
                    <div class="archive-list">
                        <?php foreach ($archive_tables as $table): 
                            // استخراج السنة من اسم الجدول (افتراضي: ..._archive_YYYY)
                            preg_match('/_archive_(\d{4})$/', $table, $matches);
                            $year = $matches[1] ?? 'غير معروف';
                            // الحصول على عدد السجلات
                            $count = 0;
                            try {
                                $stmt = $pdo->query("SELECT COUNT(*) FROM `$table`");
                                $count = $stmt->fetchColumn();
                            } catch (Exception $e) {}
                        ?>
                            <div class="archive-item">
                                <div>
                                    <strong>سنة <?php echo $year; ?></strong>
                                    <span style="color: #64748b; margin-right: 10px;">(جدول: <?php echo $table; ?>)</span>
                                </div>
                                <div>
                                    <span class="badge" style="background: #e2e8f0; color: #1e293b;"><?php echo $count; ?> سجل</span>
                                    <a href="view_archive.php?table=<?php echo urlencode($table); ?>" class="btn-sm" style="margin-right: 10px; background: #2563eb; color: white; padding: 5px 10px; border-radius: 5px; text-decoration: none;">عرض</a>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</body>
</html>