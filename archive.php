<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$user_id = $_SESSION['user_id'];
$role_level = (int)$_SESSION['role_level'];
$statObj = new Stat($pdo);

$year = $_GET['year'] ?? date('Y');
$compare_year = $_GET['compare_year'] ?? null;

// جلب السنوات المتاحة في النظام
$years = [];
$stats_list = $statObj->getAvailableStats($user_id, $role_level);
foreach ($stats_list as $s) {
    if ($s['stat_type'] != 'file_exchange') {
        try {
            $stmt = $pdo->query("SELECT DISTINCT stat_year FROM `{$s['table_name']}` ORDER BY stat_year DESC");
            while($row = $stmt->fetch()) {
                if (!in_array($row['stat_year'], $years)) $years[] = $row['stat_year'];
            }
        } catch (Exception $e) {}
    }
}
sort($years);
$years = array_reverse($years);
if (empty($years)) $years = [date('Y')];

?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>الأرشيف والمقارنات | نظام الإحصائيات</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .archive-grid { display: grid; grid-template-columns: 250px 1fr; gap: 20px; }
        .year-sidebar { background: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); height: fit-content; }
        .year-link { display: block; padding: 12px; margin-bottom: 8px; border-radius: 8px; text-decoration: none; color: #475569; transition: all 0.2s; border: 1px solid #f1f5f9; }
        .year-link:hover { background: #f8fafc; border-color: #2563eb; color: #2563eb; }
        .year-link.active { background: #2563eb; color: white; border-color: #2563eb; }
        .stat-summary-card { background: white; padding: 20px; border-radius: 12px; margin-bottom: 20px; border-right: 5px solid #2563eb; }
        .comparison-container { background: #f8fafc; padding: 20px; border-radius: 12px; margin-top: 20px; border: 1px solid #e2e8f0; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        
        <div class="main-content">
            <h2><i class="fas fa-archive"></i> الأرشيف السنوي والمقارنات</h2>
            
            <div class="archive-grid">
                <div class="year-sidebar">
                    <h4 style="margin-bottom: 15px; color: #1e293b;">اختر السنة</h4>
                    <?php foreach($years as $y): ?>
                        <a href="archive.php?year=<?php echo $y; ?>" class="year-link <?php echo $year == $y ? 'active' : ''; ?>">
                            <i class="fas fa-calendar-alt"></i> إحصائيات سنة <?php echo $y; ?>
                        </a>
                    <?php endforeach; ?>
                    
                    <hr style="margin: 20px 0; border: 0; border-top: 1px solid #f1f5f9;">
                    <h4 style="margin-bottom: 15px; color: #1e293b;">مقارنة مع سنة أخرى</h4>
                    <form action="archive.php" method="GET">
                        <input type="hidden" name="year" value="<?php echo $year; ?>">
                        <select name="compare_year" onchange="this.form.submit()" style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #e2e8f0;">
                            <option value="">اختر سنة للمقارنة...</option>
                            <?php foreach($years as $y): if($y != $year): ?>
                                <option value="<?php echo $y; ?>" <?php echo $compare_year == $y ? 'selected' : ''; ?>><?php echo $y; ?></option>
                            <?php endif; endforeach; ?>
                        </select>
                    </form>
                </div>

                <div class="archive-content">
                    <div class="card" style="margin-bottom: 20px; background: #eff6ff; border: 1px solid #bfdbfe;">
                        <h3 style="color: #1e40af;"><i class="fas fa-info-circle"></i> عرض بيانات سنة <?php echo $year; ?> 
                        <?php if($compare_year) echo "مقارنة بـ $compare_year"; ?></h3>
                    </div>

                    <?php 
                    $found_data = false;
                    foreach($stats_list as $s): 
                        if($s['stat_type'] == 'file_exchange') continue;
                        
                        $data = $statObj->getStatData($s['table_name'], $user_id, $role_level, ['year' => $year]);
                        if(empty($data)) continue;
                        $found_data = true;
                        
                        $analysis = $statObj->calculateStats($data, $statObj->getStatDetails($s['id'])['columns']);
                        
                        $compare_data = null;
                        if($compare_year) {
                            $compare_data = $statObj->getStatData($s['table_name'], $user_id, $role_level, ['year' => $compare_year]);
                            $compare_analysis = $statObj->calculateStats($compare_data, $statObj->getStatDetails($s['id'])['columns']);
                        }
                    ?>
                        <div class="stat-summary-card">
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <h4><?php echo htmlspecialchars($s['stat_name']); ?></h4>
                                <a href="view_stat_data.php?id=<?php echo $s['id']; ?>&year=<?php echo $year; ?>" class="btn btn-sm" style="background: #e2e8f0; color: #475569; text-decoration: none; padding: 5px 10px; border-radius: 5px;">عرض التفاصيل</a>
                            </div>
                            
                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 15px; margin-top: 15px;">
                                <?php foreach($analysis['totals'] as $col_name => $total): 
                                    $col_label = "";
                                    foreach($statObj->getStatDetails($s['id'])['columns'] as $c) if($c['column_name'] == $col_name) $col_label = $c['column_label'];
                                ?>
                                    <div style="background: #f8fafc; padding: 10px; border-radius: 8px; text-align: center;">
                                        <div style="font-size: 0.8rem; color: #64748b;"><?php echo $col_label; ?></div>
                                        <div style="font-size: 1.2rem; font-weight: bold; color: #2563eb;"><?php echo number_format($total, 2); ?></div>
                                        
                                        <?php if($compare_year && isset($compare_analysis['totals'][$col_name])): 
                                            $comp_total = $compare_analysis['totals'][$col_name];
                                            $diff = $total - $comp_total;
                                            $perc = $comp_total > 0 ? ($diff / $comp_total) * 100 : 0;
                                            $color = $diff >= 0 ? '#10b981' : '#ef4444';
                                            $icon = $diff >= 0 ? 'fa-arrow-up' : 'fa-arrow-down';
                                        ?>
                                            <div style="font-size: 0.75rem; color: <?php echo $color; ?>; margin-top: 5px;">
                                                <i class="fas <?php echo $icon; ?>"></i> <?php echo abs(round($perc, 1)); ?>% عن <?php echo $compare_year; ?>
                                            </div>
                                        <?php endif; ?>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                        </div>
                    <?php endforeach; ?>

                    <?php if(!$found_data): ?>
                        <div class="card" style="text-align: center; padding: 50px;">
                            <i class="fas fa-history fa-4x" style="color: #e2e8f0; margin-bottom: 20px;"></i>
                            <p style="color: #94a3b8;">لا توجد بيانات مؤرشفة لهذه السنة.</p>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
