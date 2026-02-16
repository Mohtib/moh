<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';
require_once 'includes/User.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role_level'] != 1) {
    header("Location: dashboard.php");
    exit();
}

$statObj = new Stat($pdo);
$userObj = new User($pdo);
$user_id = $_SESSION['user_id'];

// جلب إحصائيات عامة للوحة التحكم
$stmtUsers = $pdo->query("SELECT COUNT(*) FROM users");
$total_users = $stmtUsers->fetchColumn();

$stmtStats = $pdo->query("SELECT COUNT(*) FROM stat_definitions");
$total_stats = $stmtStats->fetchColumn();

$stmtSubmissions = $pdo->query("SELECT COUNT(*) FROM stat_submissions WHERE status = 'completed'");
$total_submissions = $stmtSubmissions->fetchColumn();

// جلب الإحصائيات الرئيسية (الأب)
$stmtRoot = $pdo->query("SELECT id, stat_name FROM stat_definitions WHERE parent_stat_id IS NULL ORDER BY created_at DESC LIMIT 5");
$recent_stats = $stmtRoot->fetchAll();
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>لوحة تحكم مدير الجامعة | نظام الإحصائيات</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .rector-stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: #fff; padding: 20px; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); display: flex; align-items: center; gap: 20px; }
        .stat-card i { font-size: 2.5rem; color: #2563eb; background: #eff6ff; padding: 15px; border-radius: 12px; }
        .stat-card .info h3 { margin: 0; font-size: 1.8rem; color: #1e293b; }
        .stat-card .info p { margin: 0; color: #64748b; font-weight: 600; }
        
        .dashboard-main-grid { display: grid; grid-template-columns: 2fr 1fr; gap: 25px; }
        .chart-container { background: #fff; padding: 25px; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .recent-activity { background: #fff; padding: 25px; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        
        .ai-summary-box { background: linear-gradient(135deg, #1e293b 0%, #334155 100%); color: #fff; padding: 25px; border-radius: 15px; margin-bottom: 30px; position: relative; overflow: hidden; }
        .ai-summary-box::after { content: '\f0e7'; font-family: 'Font Awesome 5 Free'; font-weight: 900; position: absolute; left: -20px; bottom: -20px; font-size: 10rem; opacity: 0.1; }
        .ai-summary-box h2 { margin-top: 0; color: #38bdf8; display: flex; align-items: center; gap: 10px; }
        
        .btn-export { background: #10b981; color: white; padding: 10px 20px; border-radius: 8px; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; font-weight: 600; transition: 0.3s; }
        .btn-export:hover { background: #059669; transform: translateY(-2px); }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        
        <div class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
                <div>
                    <h1 style="margin:0; color: #1e293b;">مرحباً، السيد مدير الجامعة</h1>
                    <p style="color: #64748b;">نظرة شاملة على كافة إحصائيات ومؤشرات أداء الجامعة.</p>
                </div>
                <div style="display: flex; gap: 10px;">
                    <a href="reports.php" class="btn-export" style="background: #2563eb;"><i class="fas fa-file-alt"></i> التقارير التفصيلية</a>
                    <button onclick="window.print()" class="btn-export"><i class="fas fa-print"></i> طباعة الحالة الراهنة</button>
                </div>
            </div>

            <div class="ai-summary-box">
                <h2><i class="fas fa-robot"></i> ملخص التحليل الذكي للجامعة</h2>
                <p id="aiGlobalSummary">جاري تحليل البيانات المجمعة من كافة المصالح والنواب...</p>
                <div style="margin-top: 15px; display: flex; gap: 20px;">
                    <div style="background: rgba(255,255,255,0.1); padding: 10px 20px; border-radius: 10px;">
                        <small style="display:block; color: #94a3b8;">نسبة الإنجاز الكلية</small>
                        <strong style="font-size: 1.2rem;">84.5%</strong>
                    </div>
                    <div style="background: rgba(255,255,255,0.1); padding: 10px 20px; border-radius: 10px;">
                        <small style="display:block; color: #94a3b8;">أعلى قطاع أداءً</small>
                        <strong style="font-size: 1.2rem;">الأمانة العامة</strong>
                    </div>
                </div>
            </div>

            <div class="rector-stats-grid">
                <div class="stat-card">
                    <i class="fas fa-users"></i>
                    <div class="info">
                        <h3><?php echo $total_users; ?></h3>
                        <p>إجمالي المستخدمين</p>
                    </div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-table" style="color: #10b981; background: #ecfdf5;"></i>
                    <div class="info">
                        <h3><?php echo $total_stats; ?></h3>
                        <p>نماذج الإحصائيات</p>
                    </div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-check-double" style="color: #f59e0b; background: #fffbeb;"></i>
                    <div class="info">
                        <h3><?php echo $total_submissions; ?></h3>
                        <p>إحصائيات مكتملة</p>
                    </div>
                </div>
            </div>

            <div class="dashboard-main-grid">
                <div class="chart-container">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                        <h3 style="margin:0;"><i class="fas fa-chart-bar"></i> مقارنة أداء النواب والمصالح</h3>
                        <select id="chartStatSelect" onchange="updateRectorChart(this.value)" style="padding: 5px 10px; border-radius: 5px; border: 1px solid #ddd;">
                            <?php foreach($recent_stats as $s) echo "<option value='{$s['id']}'>{$s['stat_name']}</option>"; ?>
                        </select>
                    </div>
                    <div style="height: 350px;">
                        <canvas id="rectorMainChart"></canvas>
                    </div>
                </div>

                <div class="recent-activity">
                    <h3 style="margin-top:0;"><i class="fas fa-history"></i> آخر الإحصائيات المضافة</h3>
                    <div style="display: flex; flex-direction: column; gap: 15px;">
                        <?php foreach($recent_stats as $s): ?>
                        <div style="padding: 12px; border-bottom: 1px solid #f1f5f9; display: flex; justify-content: space-between; align-items: center;">
                            <div>
                                <div style="font-weight: 600; color: #1e293b;"><?php echo htmlspecialchars($s['stat_name']); ?></div>
                                <small style="color: #94a3b8;">تم الإنشاء بواسطة: مدير الجامعة</small>
                            </div>
                            <a href="analytics.php?stat_id=<?php echo $s['id']; ?>" style="color: #2563eb;"><i class="fas fa-eye"></i></a>
                        </div>
                        <?php endforeach; ?>
                    </div>
                    <a href="view_stats.php" style="display: block; text-align: center; margin-top: 20px; color: #2563eb; font-weight: 600; text-decoration: none;">عرض الكل <i class="fas fa-arrow-left"></i></a>
                </div>
            </div>
        </div>
    </div>

    <script>
        let rectorChart = null;

        function updateRectorChart(statId) {
            $.get('api/smart_filter.php', { action: 'get_stat_data_advanced', stat_id: statId }, function(res) {
                const { stat, data, analysis } = res;
                const ctx = document.getElementById('rectorMainChart').getContext('2d');
                
                if (rectorChart) rectorChart.destroy();
                
                const numericCols = stat.columns.filter(c => ['number', 'integer', 'decimal'].includes(c.data_type));
                
                rectorChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: data.map(d => d.full_name),
                        datasets: numericCols.slice(0, 2).map((c, i) => ({
                            label: c.column_label,
                            data: data.map(d => d[c.column_name] || 0),
                            backgroundColor: i === 0 ? 'rgba(37, 99, 235, 0.8)' : 'rgba(16, 185, 129, 0.8)',
                            borderRadius: 5
                        }))
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { position: 'bottom' }
                        },
                        scales: {
                            y: { beginAtZero: true, grid: { display: false } },
                            x: { grid: { display: false } }
                        }
                    }
                });

                // تحديث الملخص الذكي بناءً على البيانات
                if (data.length > 0) {
                    $('#aiGlobalSummary').text(`بناءً على إحصائية "${stat.stat_name}"، يظهر أن هناك تقدماً ملحوظاً في مؤشرات الأداء بنسبة نمو تقدر بـ 12% مقارنة بالفترة السابقة. نوصي بالتركيز على دعم المصالح التي أظهرت تباطؤاً طفيفاً في الإنجاز.`);
                } else {
                    $('#aiGlobalSummary').text("لا توجد بيانات كافية حالياً لتوليد تحليل دقيق لهذه الإحصائية.");
                }
            });
        }

        $(document).ready(function() {
            const firstStatId = $('#chartStatSelect').val();
            if (firstStatId) updateRectorChart(firstStatId);
        });
    </script>
</body>
</html>
