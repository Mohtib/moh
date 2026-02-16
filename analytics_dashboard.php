<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$statObj = new Stat($pdo);
$stat_id = $_GET['id'] ?? null;

if (!$stat_id) {
    // جلب أول إحصائية متاحة إذا لم يتم تحديد واحدة
    $available = $statObj->getAvailableStats($_SESSION['user_id'], $_SESSION['role_level']);
    if (!empty($available)) {
        foreach($available as $s) {
            if($s['stat_type'] != 'file_exchange') {
                $stat_id = $s['id'];
                break;
            }
        }
    }
}

$stat_details = $stat_id ? $statObj->getStatDetails($stat_id) : null;
$analysis = null;
$chart_data = [];

if ($stat_details) {
    $data = $statObj->getStatData($stat_details['table_name'], $_SESSION['user_id'], $_SESSION['role_level']);
    $analysis = $statObj->calculateStats($data, $stat_details['columns']);
    
    // تحضير بيانات الرسوم البيانية (آخر 5 سنوات)
    $years = [];
    if (isset($analysis['yearly_data']) && is_array($analysis['yearly_data'])) {
        $years = array_keys($analysis['yearly_data']);
        sort($years);
        $years = array_slice($years, -5);
    }
    
    $chart_data['labels'] = $years;
    $chart_data['datasets'] = [];
    
    $colors = ['#2563eb', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#06b6d4'];
    $color_idx = 0;
    
    foreach ($stat_details['columns'] as $col) {
        if (in_array($col['data_type'], ['number', 'integer', 'decimal'])) {
            $dataset = [
                'label' => $col['column_label'],
                'data' => [],
                'borderColor' => $colors[$color_idx % count($colors)],
                'backgroundColor' => $colors[$color_idx % count($colors)] . '20',
                'fill' => true,
                'tension' => 0.4
            ];
            foreach ($years as $year) {
                $dataset['data'][] = $analysis['yearly_data'][$year][$col['column_name']] ?? 0;
            }
            $chart_data['datasets'][] = $dataset;
            $color_idx++;
        }
    }
}
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>لوحة التحليل الذكي | جامعة ميلة</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card-pro { background: white; padding: 20px; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border-right: 5px solid #2563eb; }
        .stat-card-pro h4 { margin: 0; color: #64748b; font-size: 0.9rem; }
        .stat-card-pro .value { font-size: 1.8rem; font-weight: 800; color: #1e293b; margin: 10px 0; }
        .stat-card-pro .trend { font-size: 0.85rem; display: flex; align-items: center; gap: 5px; }
        .trend.up { color: #10b981; }
        .trend.down { color: #ef4444; }
        .chart-container { background: white; padding: 25px; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); margin-bottom: 30px; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        <div class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
                <div>
                    <h2><i class="fas fa-chart-line"></i> لوحة التحليل البياني المتقدم</h2>
                    <p style="color: #64748b;">تحليل البيانات والاتجاهات الزمنية للإحصائيات المختارة.</p>
                </div>
                <div style="width: 300px;">
                    <form method="GET">
                        <select name="id" onchange="this.form.submit()" class="card" style="width: 100%; padding: 10px;">
                            <option value="">اختر إحصائية للتحليل...</option>
                            <?php 
                            $all = $statObj->getAvailableStats($_SESSION['user_id'], $_SESSION['role_level']);
                            foreach($all as $s) {
                                if($s['stat_type'] != 'file_exchange') {
                                    echo "<option value='{$s['id']}' ".($stat_id == $s['id'] ? 'selected' : '').">{$s['stat_name']}</option>";
                                }
                            }
                            ?>
                        </select>
                    </form>
                </div>
            </div>

            <?php if (!$stat_details): ?>
                <div class="card" style="text-align: center; padding: 50px;">
                    <i class="fas fa-chart-pie fa-4x" style="color: #e2e8f0; margin-bottom: 20px;"></i>
                    <h3>يرجى اختيار إحصائية من القائمة أعلاه لعرض التحليلات</h3>
                </div>
            <?php else: ?>
                <div class="stats-grid">
                    <?php foreach ($stat_details['columns'] as $col): ?>
                        <?php if (in_array($col['data_type'], ['number', 'integer', 'decimal'])): ?>
                            <div class="stat-card-pro">
                                <h4>إجمالي <?php echo $col['column_label']; ?></h4>
                                <div class="value"><?php echo number_format($analysis['totals'][$col['column_name']] ?? 0, 2); ?></div>
                                <?php if (isset($analysis['growth'][$col['column_name']])): ?>
                                    <?php $g = $analysis['growth'][$col['column_name']]; ?>
                                    <div class="trend <?php echo $g >= 0 ? 'up' : 'down'; ?>">
                                        <i class="fas fa-caret-<?php echo $g >= 0 ? 'up' : 'down'; ?>"></i>
                                        <?php echo abs(round($g, 1)); ?>% مقارنة بالسنة الماضية
                                    </div>
                                <?php endif; ?>
                            </div>
                        <?php endif; ?>
                    <?php endforeach; ?>
                </div>

                <div class="chart-container">
                    <h3 style="margin-top: 0; margin-bottom: 20px;"><i class="fas fa-history"></i> التطور الزمني (آخر 5 سنوات)</h3>
                    <canvas id="mainChart" style="max-height: 400px;"></canvas>
                </div>
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="chart-container">
                        <h3><i class="fas fa-percentage"></i> التوزيع النسبي (المتوسطات)</h3>
                        <canvas id="pieChart" style="max-height: 300px;"></canvas>
                    </div>
                    <div class="chart-container">
                        <h3><i class="fas fa-lightbulb"></i> رؤى ذكية (Insights)</h3>
                        <div style="padding: 10px;">
                            <ul style="line-height: 2; color: #475569;">
                                <?php foreach ($analysis['growth'] as $col_name => $g): ?>
                                    <li>
                                        يشهد مؤشر <strong><?php 
                                            foreach($stat_details['columns'] as $c) if($c['column_name'] == $col_name) echo $c['column_label'];
                                        ?></strong> 
                                        <?php echo $g >= 0 ? 'نمواً' : 'انخفاضاً'; ?> بنسبة <strong><?php echo abs(round($g, 1)); ?>%</strong>.
                                    </li>
                                <?php endforeach; ?>
                                <li>تم تحليل بيانات <strong><?php echo count($years); ?></strong> سنوات مختلفة.</li>
                                <li>متوسط القيم المحققة لهذا العام هو <strong><?php echo number_format(array_sum($analysis['averages'])/max(1, count($analysis['averages'])), 2); ?></strong>.</li>
                            </ul>
                        </div>
                    </div>
                </div>
            <?php endif; ?>
        </div>
    </div>

    <script>
    <?php if ($stat_details): ?>
    const ctx = document.getElementById('mainChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: <?php echo json_encode($chart_data); ?>,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { position: 'bottom' }
            },
            scales: {
                y: { beginAtZero: true, grid: { drawBorder: false } },
                x: { grid: { display: false } }
            }
        }
    });

    const pieCtx = document.getElementById('pieChart').getContext('2d');
    new Chart(pieCtx, {
        type: 'doughnut',
        data: {
            labels: <?php echo json_encode(array_values(array_map(function($c){return $c['column_label'];}, array_filter($stat_details['columns'], function($c){return in_array($c['data_type'], ['number','integer','decimal']);})))); ?>,
            datasets: [{
                data: <?php echo json_encode(array_values($analysis['averages'])); ?>,
                backgroundColor: ['#2563eb', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#06b6d4']
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { position: 'bottom' } }
        }
    });
    <?php endif; ?>
    </script>
</body>
</html>
