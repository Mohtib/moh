<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role_level'] > 2) {
    header("Location: dashboard.php");
    exit();
}

$statObj = new Stat($pdo);
$stat_id = $_GET['id'] ?? null;

if (!$stat_id) {
    die("يرجى اختيار إحصائية للتحليل الذكي.");
}

$stat = $statObj->getStatDetails($stat_id);
$data = $statObj->getStatData($stat['table_name'], null, 1);
$ai_report = $statObj->analyzeWithAI($data, $stat['stat_name'], $stat['columns']);
$calc = $statObj->calculateStats($data, $stat['columns']);

?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>مركز التحليل الذكي | جامعة ميلة</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .ai-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 20px; }
        .ai-card { background: white; padding: 25px; border-radius: 15px; border: 1px solid #e2e8f0; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .ai-report-text { background: #f0f7ff; border-right: 5px solid #2563eb; padding: 20px; border-radius: 8px; font-family: 'Courier New', monospace; line-height: 1.8; white-space: pre-wrap; }
        .chart-container { height: 300px; margin-top: 20px; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        <div class="main-content">
            <div class="page-header" style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h2><i class="fas fa-brain"></i> مركز التحليل والذكاء الاصطناعي</h2>
                    <p>إحصائية: <strong><?php echo $stat['stat_name']; ?></strong></p>
                </div>
                <a href="dynamic_report_builder.php?id=<?php echo $stat_id; ?>" class="btn" style="background: #7c3aed; color: white;"><i class="fas fa-magic"></i> بناء تقرير مخصص</a>
            </div>

            <div class="ai-grid">
                <div class="ai-card" style="grid-column: span 2;">
                    <h4><i class="fas fa-robot"></i> تقرير محرك الذكاء الاصطناعي</h4>
                    <div class="ai-report-text"><?php echo $ai_report; ?></div>
                </div>

                <div class="ai-card">
                    <h4><i class="fas fa-chart-line"></i> تحليل الاتجاهات الزمنية</h4>
                    <div class="chart-container">
                        <canvas id="trendChart"></canvas>
                    </div>
                </div>

                <div class="ai-card">
                    <h4><i class="fas fa-chart-pie"></i> توزيع البيانات حسب الجهة</h4>
                    <div class="chart-container">
                        <canvas id="distributionChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // بيانات الرسم البياني للاتجاهات
        const yearlyData = <?php echo json_encode($calc['yearly_data']); ?>;
        const years = Object.keys(yearlyData).sort();
        const firstCol = "<?php echo $stat['columns'][0]['column_name']; ?>";
        const firstLabel = "<?php echo $stat['columns'][0]['column_label']; ?>";
        
        const trendData = years.map(y => yearlyData[y][firstCol] || 0);

        new Chart(document.getElementById('trendChart'), {
            type: 'line',
            data: {
                labels: years,
                datasets: [{
                    label: firstLabel,
                    data: trendData,
                    borderColor: '#2563eb',
                    tension: 0.3,
                    fill: true,
                    backgroundColor: 'rgba(37, 99, 235, 0.1)'
                }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        // بيانات التوزيع
        const rawData = <?php echo json_encode($data); ?>;
        const userGroups = {};
        rawData.forEach(row => {
            userGroups[row.full_name] = (userGroups[row.full_name] || 0) + (float)(row[firstCol] || 0);
        });

        new Chart(document.getElementById('distributionChart'), {
            type: 'doughnut',
            data: {
                labels: Object.keys(userGroups),
                datasets: [{
                    data: Object.values(userGroups),
                    backgroundColor: ['#2563eb', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6']
                }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });
    </script>
</body>
</html>
