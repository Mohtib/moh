<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';
require_once 'includes/User.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$statObj = new Stat($pdo);
$userObj = new User($pdo);
$user_id = $_SESSION['user_id'];
$role_level = (int)$_SESSION['role_level'];

// جلب الإحصائيات الأب للبدء بالفلترة الهرمية
$stmt = $pdo->query("SELECT id, stat_name FROM stat_definitions WHERE parent_stat_id IS NULL");
$root_stats = $stmt->fetchAll();
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>التحليل الذكي المتقدم | نظام الإحصائيات</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .analytics-grid { display: grid; grid-template-columns: 1fr 350px; gap: 20px; margin-top: 20px; }
        .ai-card { background: linear-gradient(135deg, #f5f3ff 0%, #ede9fe 100%); border-right: 5px solid #7c3aed; padding: 20px; border-radius: 12px; margin-bottom: 20px; }
        .stat-selector-box { background: #fff; padding: 20px; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 20px; }
        .chart-box { background: #fff; padding: 20px; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); height: 400px; }
        .percentage-table { width: 100%; border-collapse: collapse; margin-top: 15px; background: #fff; border-radius: 8px; overflow: hidden; }
        .percentage-table th, .percentage-table td { padding: 10px; border: 1px solid #f1f5f9; text-align: center; font-size: 0.9rem; }
        .percentage-table th { background: #f8fafc; }
        .ai-insight-item { margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px dashed #ddd; }
        .ai-insight-item i { color: #7c3aed; margin-left: 10px; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        <div class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
                <div>
                    <h2><i class="fas fa-brain"></i> محرك التحليل الذكي (AI Analytics)</h2>
                    <p style="color: #64748b;">تحليل هرمي للجداول، حساب النسب المئوية، وتوليد رؤى استراتيجية.</p>
                </div>
                <div class="ai-badge" style="background: #7c3aed; color: #fff; padding: 8px 15px; border-radius: 20px; font-weight: bold;">
                    <i class="fas fa-bolt"></i> نظام نشط
                </div>
            </div>

            <!-- الفلترة الهرمية للجداول في التحليل -->
            <div class="stat-selector-box">
                <div style="display: flex; gap: 15px;">
                    <div style="flex: 1;">
                        <label>الإحصائية الرئيسية</label>
                        <select id="ana_stat_1" onchange="loadAnaSubStats(this.value, 2)" style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #ddd;">
                            <option value="">اختر الإحصائية...</option>
                            <?php foreach($root_stats as $s) echo "<option value='{$s['id']}'>{$s['stat_name']}</option>"; ?>
                        </select>
                    </div>
                    <div style="flex: 1;">
                        <label>الإحصائية الفرعية</label>
                        <select id="ana_stat_2" onchange="loadAnaSubStats(this.value, 3)" disabled style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #ddd;">
                            <option value="">اختر...</option>
                        </select>
                    </div>
                    <div style="flex: 1;">
                        <label>إحصائية التفاصيل</label>
                        <select id="ana_stat_3" onchange="startAIAnalysis()" disabled style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #ddd;">
                            <option value="">اختر...</option>
                        </select>
                    </div>
                </div>
            </div>

            <div id="analysisContent" style="display: none;">
                <div class="ai-card">
                    <h3><i class="fas fa-robot"></i> استنتاجات الذكاء الاصطناعي</h3>
                    <div id="aiInsights">
                        <!-- سيتم ملؤه ديناميكياً -->
                    </div>
                </div>

                <div class="analytics-grid">
                    <div class="chart-box">
                        <h3><i class="fas fa-chart-line"></i> تحليل الاتجاهات والمقارنات</h3>
                        <canvas id="anaChart"></canvas>
                    </div>
                    <div class="stat-selector-box" style="height: 400px; overflow-y: auto;">
                        <h3><i class="fas fa-percentage"></i> توزيع النسب المئوية</h3>
                        <div id="percentageResults">
                            <!-- سيتم ملؤه ديناميكياً -->
                        </div>
                    </div>
                </div>

                <div class="stat-selector-box" style="margin-top: 20px;">
                    <h3><i class="fas fa-table"></i> الجدول الإحصائي التحليلي (أفقي وعمودي)</h3>
                    <div id="detailedTable" style="overflow-x: auto;">
                        <!-- سيتم ملؤه ديناميكياً -->
                    </div>
                </div>
            </div>

            <div id="anaLoader" style="display: none; text-align: center; padding: 50px;">
                <i class="fas fa-circle-notch fa-spin fa-3x" style="color: #7c3aed;"></i>
                <p style="margin-top: 15px; font-weight: bold;">جاري معالجة البيانات الضخمة وتوليد التحليل...</p>
            </div>
        </div>
    </div>

    <script>
        let anaChart = null;

        function loadAnaSubStats(parentId, level) {
            if (!parentId) {
                resetAnaLevels(level);
                return;
            }
            $.get('api/smart_filter.php', { action: 'get_child_stats', parent_id: parentId }, function(data) {
                let html = '<option value="">اختر...</option>';
                data.forEach(s => html += `<option value="${s.id}">${s.stat_name}</option>`);
                $(`#ana_stat_${level}`).html(html).prop('disabled', false);
                startAIAnalysis();
            });
        }

        function resetAnaLevels(level) {
            for (let i = level; i <= 3; i++) {
                $(`#ana_stat_${i}`).html('<option value="">اختر...</option>').prop('disabled', true);
            }
        }

        function startAIAnalysis() {
            const statId = $('#ana_stat_3').val() || $('#ana_stat_2').val() || $('#ana_stat_1').val();
            if (!statId) return;

            $('#analysisContent').hide();
            $('#anaLoader').show();

            $.get('api/smart_filter.php', { action: 'get_stat_data_advanced', stat_id: statId }, function(res) {
                renderAIAnalysis(res);
                $('#anaLoader').hide();
                $('#analysisContent').fadeIn();
            });
        }

        function renderAIAnalysis(res) {
            const { stat, data, analysis } = res;
            
            // 1. توليد استنتاجات AI
            let aiHtml = '';
            const numericCols = stat.columns.filter(c => ['number', 'integer', 'decimal'].includes(c.data_type));
            
            if (data.length > 0) {
                aiHtml += `<div class="ai-insight-item"><i class="fas fa-check-circle"></i> تم تحليل <strong>${data.length}</strong> سجلات بنجاح.</div>`;
                const topCol = numericCols[0];
                if (topCol) {
                    aiHtml += `<div class="ai-insight-item"><i class="fas fa-lightbulb"></i> نلاحظ أن مؤشر <strong>"${topCol.column_label}"</strong> هو الأكثر تأثيراً بمجموع <strong>${analysis.totals[topCol.column_name]}</strong>.</div>`;
                }
                aiHtml += `<div class="ai-insight-item"><i class="fas fa-exclamation-triangle"></i> توصية: يرجى متابعة الأقسام التي تقل نسبة مساهمتها عن 10% لضمان توازن الأداء.</div>`;
            } else {
                aiHtml = '<p>لا توجد بيانات كافية للتحليل حالياً.</p>';
            }
            $('#aiInsights').html(aiHtml);

            // 2. تحديث الرسم البياني
            const ctx = document.getElementById('anaChart').getContext('2d');
            if (anaChart) anaChart.destroy();
            
            anaChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: data.map(d => d.full_name),
                    datasets: numericCols.map((c, i) => ({
                        label: c.column_label,
                        data: data.map(d => d[c.column_name] || 0),
                        backgroundColor: `rgba(${50 + i*50}, ${100 + i*20}, 235, 0.7)`
                    }))
                },
                options: { responsive: true, maintainAspectRatio: false }
            });

            // 3. حساب النسب المئوية لكل صف (field_percentages) يدوياً
            const totals = analysis.totals;
            const fieldPercentages = data.map(row => {
                const percRow = {};
                numericCols.forEach(col => {
                    const total = totals[col.column_name] || 0;
                    percRow[col.column_name] = total ? ((parseFloat(row[col.column_name]) || 0) / total * 100).toFixed(1) : 0;
                });
                return percRow;
            });

            // 4. تحديث جدول النسب المئوية
            let percHtml = '<table class="percentage-table"><thead><tr><th>المؤشر</th><th>المجموع</th><th>النسبة</th></tr></thead><tbody>';
            numericCols.forEach(c => {
                const total = totals[c.column_name] || 0;
                percHtml += `<tr><td>${c.column_label}</td><td>${total}</td><td>100%</td></tr>`;
            });
            percHtml += '</tbody></table>';
            $('#percentageResults').html(percHtml);

            // 5. الجدول التفصيلي (أفقي وعمودي)
            let tableHtml = `
                <table class="stat-table">
                    <thead>
                        <tr>
                            <th>المستخدم</th>
                            ${stat.columns.map(c => `<th>${c.column_label}</th>`).join('')}
                            <th>المجموع الأفقي</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${data.map((row, idx) => {
                            let rowSum = 0;
                            stat.columns.forEach(c => rowSum += parseFloat(row[c.column_name] || 0));
                            return `
                                <tr>
                                    <td style="font-weight:bold">${row.full_name}</td>
                                    ${stat.columns.map(c => {
                                        const val = row[c.column_name] || 0;
                                        const isNumeric = numericCols.some(nc => nc.column_name === c.column_name);
                                        const perc = (isNumeric && fieldPercentages[idx]) ? fieldPercentages[idx][c.column_name] : 0;
                                        return `<td>${val} <br><small style="color:#7c3aed">${perc}%</small></td>`;
                                    }).join('')}
                                    <td style="background:#f5f3ff; font-weight:bold">${rowSum}</td>
                                </tr>
                            `;
                        }).join('')}
                    </tbody>
                </table>
            `;
            $('#detailedTable').html(tableHtml);
        }
    </script>
</body>
</html>