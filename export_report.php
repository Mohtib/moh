<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';
require_once 'includes/User.php';

if (!isset($_SESSION['user_id'])) {
    die("غير مصرح");
}

// تحديد وضع التصدير (عادي، word، csv)
$export_word = isset($_GET['export']) && $_GET['export'] === 'word';
$export_csv = isset($_GET['export']) && $_GET['export'] === 'csv';

$stat_id = $_GET['stat_id'] ?? ($_GET['id'] ?? null);
$all_stats = isset($_GET['all']) && $_GET['all'] == 1;
$user_id_filter = $_GET['user_id'] ?? null;
$statObj = new Stat($pdo);

$reports = [];
$skipped_stats = 0;

if ($all_stats) {
    $stats_list = $statObj->getAvailableStats($_SESSION['user_id'], $_SESSION['role_level']);
    foreach ($stats_list as $s) {
        if ($s['stat_type'] != 'file_exchange') {
            $details = $statObj->getStatDetails($s['id']);
            try {
                $data = $statObj->getStatData($details['table_name'], $_SESSION['user_id'], $_SESSION['role_level'], ['user_id' => $user_id_filter]);
                if (!empty($data)) {
                    $reports[] = [
                        'stat' => $details,
                        'data' => $data,
                        'analysis' => $statObj->calculateStats($data, $details['columns']),
                        'ai_report' => $statObj->analyzeWithAI($data, $details['stat_name'], $details['columns'])
                    ];
                }
            } catch (PDOException $e) {
                $skipped_stats++;
                continue;
            }
        }
    }
    $title = $_SESSION['role_level'] == 1 ? "التقرير الإحصائي الشامل - جامعة ميلة" : "التقرير الإحصائي الموحد - " . $_SESSION['full_name'];
} else {
    if (!$stat_id) die("إحصائية غير محددة");
    $details = $statObj->getStatDetails($stat_id);
    try {
        $data = $statObj->getStatData($details['table_name'], $user_id_filter, $_SESSION['role_level']);
        $reports[] = [
            'stat' => $details,
            'data' => $data,
            'analysis' => $statObj->calculateStats($data, $details['columns']),
            'ai_report' => $statObj->analyzeWithAI($data, $details['stat_name'], $details['columns'])
        ];
    } catch (PDOException $e) {
        die("تعذر العثور على بيانات الإحصائية المطلوبة.");
    }
    $title = "تقرير إحصائي: " . $details['stat_name'];
}

/**
 * تنسيق الأرقام حسب القواعد المطلوبة
 */
function formatNumberEnhanced($val, $type = 'number') {
    if (!is_numeric($val)) return htmlspecialchars($val);
    if ($type == 'integer' || floor($val) == $val) {
        return number_format($val, 0);
    } else {
        return number_format($val, 2);
    }
}

// معالجة تصدير CSV
if ($export_csv && !empty($reports)) {
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="' . $title . '.csv"');
    $output = fopen('php://output', 'w');
    fprintf($output, chr(0xEF).chr(0xBB).chr(0xBF));
    
    foreach ($reports as $report) {
        fputcsv($output, [$report['stat']['stat_name']]);
        $headers = ['الجهة / المستخدم', 'السنة', 'الفترة'];
        foreach ($report['stat']['columns'] as $col) $headers[] = $col['column_label'];
        fputcsv($output, $headers);
        
        foreach ($report['data'] as $row) {
            $csv_row = [$row['full_name'], $row['stat_year'], $row['stat_period']];
            foreach ($report['stat']['columns'] as $col) $csv_row[] = $row[$col['column_name']];
            fputcsv($output, $csv_row);
        }
        fputcsv($output, []); // سطر فارغ بين الإحصائيات
    }
    fclose($output);
    exit();
}

// معالجة تصدير Word
if ($export_word) {
    header("Content-Type: application/msword");
    header("Content-Disposition: attachment; filename=\"" . $title . ".doc\"");
}

?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title><?php echo $title; ?></title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Tajawal:wght@400;700&display=swap');
        body { font-family: 'Tajawal', sans-serif; line-height: 1.6; color: #1e293b; padding: 20px; background: #fff; }
        .report-header { text-align: center; border-bottom: 2px solid #2563eb; padding-bottom: 20px; margin-bottom: 30px; }
        .stat-section { margin-bottom: 50px; page-break-inside: avoid; }
        .stat-title { color: #1e40af; border-right: 5px solid #2563eb; padding-right: 15px; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #cbd5e1; padding: 12px; text-align: center; }
        th { background: #f8fafc; font-weight: bold; }
        .total-row { background: #eff6ff; font-weight: bold; color: #1e40af; }
        .ai-box { background: #f1f5f9; padding: 20px; border-radius: 10px; border: 1px solid #e2e8f0; font-size: 0.9rem; white-space: pre-wrap; }
        .no-print { margin-bottom: 20px; text-align: center; }
        .btn { padding: 10px 20px; background: #2563eb; color: #fff; text-decoration: none; border-radius: 5px; font-weight: bold; margin: 0 5px; }
        @media print { .no-print { display: none; } }
    </style>
</head>
<body>
    <div class="no-print">
        <button onclick="window.print()" class="btn">طباعة / PDF</button>
        <a href="?<?php echo http_build_query(array_merge($_GET, ['export' => 'word'])); ?>" class="btn" style="background: #10b981;">Word</a>
        <a href="?<?php echo http_build_query(array_merge($_GET, ['export' => 'csv'])); ?>" class="btn" style="background: #f59e0b;">CSV / Excel</a>
    </div>

    <div class="report-header">
        <h1>جامعة عبد الحفيظ بو الصوف - ميلة</h1>
        <h2><?php echo $title; ?></h2>
        <p>تاريخ التقرير: <?php echo date('Y-m-d'); ?></p>
    </div>

    <?php foreach ($reports as $report): ?>
        <div class="stat-section">
            <h3 class="stat-title"><?php echo htmlspecialchars($report['stat']['stat_name']); ?></h3>
            <table>
                <thead>
                    <tr>
                        <th>الجهة</th>
                        <th>السنة</th>
                        <th>الفترة</th>
                        <?php foreach ($report['stat']['columns'] as $col) echo "<th>{$col['column_label']}</th>"; ?>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($report['data'] as $row): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($row['full_name']); ?></td>
                            <td><?php echo $row['stat_year']; ?></td>
                            <td><?php echo $row['stat_period']; ?></td>
                            <?php foreach ($report['stat']['columns'] as $col): ?>
                                <td><?php echo formatNumberEnhanced($row[$col['column_name']], $col['data_type']); ?></td>
                            <?php endforeach; ?>
                        </tr>
                    <?php endforeach; ?>
                    <tr class="total-row">
                        <td colspan="3">المجموع الإجمالي</td>
                        <?php foreach ($report['stat']['columns'] as $col): ?>
                            <td><?php echo formatNumberEnhanced($report['analysis']['totals'][$col['column_name']] ?? 0, $col['data_type']); ?></td>
                        <?php endforeach; ?>
                    </tr>
                </tbody>
            </table>

            <h4>🤖 التحليل الذكي للبيانات:</h4>
            <div class="ai-box"><?php echo strip_tags($report['ai_report']); ?></div>
        </div>
    <?php endforeach; ?>

    <div style="margin-top: 50px; text-align: center; color: #94a3b8; font-size: 0.8rem;">
        تم توليد هذا التقرير آلياً بواسطة نظام الإحصائيات الفائق - جامعة ميلة
    </div>
</body>
</html>
