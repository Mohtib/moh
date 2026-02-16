<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role_level'] != 1) {
    header("Location: dashboard.php");
    exit();
}

$statObj = new Stat($pdo);
$stat_id = $_GET['id'] ?? null;

if (!$stat_id) {
    die("يرجى اختيار إحصائية لبناء التقرير.");
}

$stat = $statObj->getStatDetails($stat_id);
$all_users = $pdo->query("SELECT id, full_name FROM users")->fetchAll();
$years = $pdo->query("SELECT DISTINCT stat_year FROM `{$stat['table_name']}` ORDER BY stat_year DESC")->fetchAll(PDO::FETCH_COLUMN);

?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>محرك التقارير الديناميكي | جامعة ميلة</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .builder-grid { display: grid; grid-template-columns: 300px 1fr; gap: 20px; margin-top: 20px; }
        .control-panel { background: white; padding: 20px; border-radius: 12px; border: 1px solid #e2e8f0; height: fit-content; }
        .preview-panel { background: white; padding: 25px; border-radius: 12px; border: 1px solid #e2e8f0; min-height: 500px; }
        .column-selector { margin-bottom: 20px; }
        .column-item { display: flex; align-items: center; gap: 10px; margin-bottom: 8px; padding: 8px; background: #f8fafc; border-radius: 6px; cursor: pointer; }
        .column-item:hover { background: #f1f5f9; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; font-size: 0.9rem; }
        th, td { padding: 12px; border: 1px solid #e2e8f0; text-align: center; }
        th { background: #f1f5f9; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        <div class="main-content">
            <div class="page-header">
                <h2><i class="fas fa-magic"></i> محرك بناء التقارير المخصصة</h2>
                <p>قم بتخصيص التقرير الخاص بإحصائية: <strong><?php echo $stat['stat_name']; ?></strong></p>
            </div>

            <div class="builder-grid">
                <div class="control-panel">
                    <h4><i class="fas fa-sliders-h"></i> إعدادات التقرير</h4>
                    <hr style="margin: 15px 0; opacity: 0.1;">
                    
                    <div class="column-selector">
                        <label style="font-weight: bold; display: block; margin-bottom: 10px;">الأعمدة المطلوبة:</label>
                        <?php foreach ($stat['columns'] as $col): ?>
                            <label class="column-item">
                                <input type="checkbox" class="col-check" value="<?php echo $col['column_name']; ?>" data-label="<?php echo $col['column_label']; ?>" checked>
                                <?php echo $col['column_label']; ?>
                            </label>
                        <?php endforeach; ?>
                    </div>

                    <div style="margin-bottom: 20px;">
                        <label style="font-weight: bold; display: block; margin-bottom: 5px;">فلترة حسب السنة:</label>
                        <select id="reportYear" class="card" style="width: 100%; padding: 8px;">
                            <option value="">كافة السنوات</option>
                            <?php foreach ($years as $y) echo "<option value='$y'>$y</option>"; ?>
                        </select>
                    </div>

                    <div style="margin-bottom: 20px;">
                        <label style="font-weight: bold; display: block; margin-bottom: 5px;">فلترة حسب الجهة:</label>
                        <select id="reportUser" class="card" style="width: 100%; padding: 8px;">
                            <option value="">كافة الجهات</option>
                            <?php foreach ($all_users as $u) echo "<option value='{$u['id']}'>{$u['full_name']}</option>"; ?>
                        </select>
                    </div>

                    <button onclick="generatePreview()" class="btn btn-primary" style="width: 100%; padding: 12px; background: #2563eb; color: white; border: none; border-radius: 8px; font-weight: bold;">تحديث المعاينة</button>
                    <button onclick="exportExcel()" class="btn" style="width: 100%; margin-top: 10px; padding: 12px; background: #10b981; color: white; border: none; border-radius: 8px; font-weight: bold;"><i class="fas fa-file-excel"></i> تصدير Excel</button>
                    <button onclick="window.print()" class="btn" style="width: 100%; margin-top: 10px; padding: 12px; background: #ef4444; color: white; border: none; border-radius: 8px; font-weight: bold;"><i class="fas fa-file-pdf"></i> تصدير PDF رسمي</button>
                </div>

                <div class="preview-panel" id="reportPreview">
                    <div style="text-align: center; padding: 100px; color: #94a3b8;">
                        <i class="fas fa-table fa-4x" style="margin-bottom: 20px; opacity: 0.3;"></i>
                        <p>اضغط على "تحديث المعاينة" لعرض البيانات المخصصة</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function generatePreview() {
            const selectedCols = [];
            const colLabels = [];
            $('.col-check:checked').each(function() {
                selectedCols.push($(this).val());
                colLabels.push($(this).data('label'));
            });

            const year = $('#reportYear').val();
            const userId = $('#reportUser').val();

            $('#reportPreview').html('<p style="text-align:center;">جاري جلب البيانات وتوليد التقرير...</p>');

            $.get('api/smart_filter.php', {
                action: 'custom_report_filter',
                stat_id: <?php echo $stat_id; ?>,
                cols: selectedCols,
                year: year,
                user_id: userId
            }, function(data) {
                if (data.length === 0) {
                    $('#reportPreview').html('<p style="text-align:center; padding:50px;">لا توجد بيانات تطابق هذه الفلاتر.</p>');
                    return;
                }

                let html = `<h3>معاينة التقرير المخصص</h3><div style="overflow-x:auto;"><table><thead><tr><th>الجهة</th><th>السنة</th>`;
                colLabels.forEach(label => html += `<th>${label}</th>`);
                html += `</tr></thead><tbody>`;

                data.forEach(row => {
                    html += `<tr><td>${row.full_name}</td><td>${row.stat_year}</td>`;
                    selectedCols.forEach(col => html += `<td>${row[col] || '-'}</td>`);
                    html += `</tr>`;
                });

                html += `</tbody></table></div>`;
                $('#reportPreview').html(html);
            });
        }

        function exportExcel() {
            let table = document.querySelector("#reportPreview table");
            if (!table) { alert("يرجى توليد المعاينة أولاً"); return; }
            let html = table.outerHTML;
            let blob = new Blob([html], {type: 'application/vnd.ms-excel'});
            let url = URL.createObjectURL(blob);
            let a = document.createElement('a');
            a.href = url;
            a.download = 'custom_report_<?php echo date('Ymd'); ?>.xls';
            a.click();
        }
    </script>
</body>
</html>
