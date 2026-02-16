<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id']) || !isset($_GET['id'])) {
    header("Location: view_stats.php");
    exit();
}

$stat_id = $_GET['id'];
$statObj = new Stat($pdo);
$stat = $statObj->getStatDetails($stat_id);

if (!$stat) {
    die("الإحصائية غير موجودة");
}

// التحقق من وجود الجدول في قاعدة البيانات
$table_exists = $statObj->tableExists($stat['table_name']);

$user_id = $_SESSION['user_id'];
$role_level = (int)$_SESSION['role_level'];

// جلب البيانات فقط إذا كان الجدول موجوداً
$data = $table_exists ? $statObj->getStatData($stat['table_name'], $user_id, $role_level) : [];

// حساب المجاميع والنسب المئوية والتحليل الذكي
$calculations = $table_exists ? $statObj->calculateStats($data, $stat['columns']) : ['totals' => [], 'averages' => [], 'growth' => [], 'percentages' => [], 'yearly_data' => []];
$ai_analysis = $table_exists ? $statObj->analyzeWithAI($data, $stat['stat_name'], $stat['columns']) : "لا يمكن إجراء التحليل لأن جدول البيانات غير موجود.";
$quality_score = $table_exists ? $statObj->calculateQualityScore($data, $stat['columns']) : 0;

// جلب قائمة المستخدمين للفلترة (التابعين فقط هرمياً)
$sub_ids = $statObj->getAllSubordinateIds($user_id);
$available_users = [];
if (!empty($sub_ids)) {
    $placeholders = implode(',', array_fill(0, count($sub_ids), '?'));
    $stmtUsers = $pdo->prepare("SELECT id, full_name FROM users WHERE id IN ($placeholders)");
    $stmtUsers->execute($sub_ids);
    $available_users = $stmtUsers->fetchAll();
}

$arabic_months = [
    1 => 'جانفي', 2 => 'فيفري', 3 => 'مارس', 4 => 'أفريل', 
    5 => 'ماي', 6 => 'جوان', 7 => 'جويلية', 8 => 'أوت', 
    9 => 'سبتمبر', 10 => 'أكتوبر', 11 => 'نوفمبر', 12 => 'ديسمبر'
];

function formatNumber($val, $type) {
    if (!is_numeric($val)) return $val;
    if ($type == 'integer') return number_format($val, 0);
    if ($type == 'number' || $type == 'decimal') {
        return (floor($val) == $val) ? number_format($val, 0) : number_format($val, 2);
    }
    return $val;
}
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>تحليل البيانات: <?php echo $stat['stat_name']; ?></title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
    <style>
        :root {
            --primary: #2563eb;
            --secondary: #7c3aed;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --dark: #1e293b;
            --light: #f8fafc;
        }
        .filter-box { background: white; padding: 25px; border-radius: 15px; margin-bottom: 25px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); border-right: 5px solid var(--primary); }
        .filter-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px; }
        
        .data-table-container { background: white; border-radius: 15px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1); overflow: hidden; border: 1px solid #e2e8f0; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #f1f5f9; color: var(--dark); font-weight: 700; padding: 15px; text-align: center; border-bottom: 2px solid #e2e8f0; }
        td { padding: 12px 15px; border-bottom: 1px solid #f1f5f9; text-align: center; vertical-align: middle; }
        tr:hover { background-color: #f8fafc; }
        
        .total-row { background: #eff6ff !important; font-weight: 800; color: var(--primary); }
        .total-row td { border-top: 2px solid var(--primary); border-bottom: 2px solid var(--primary); }
        
        .percentage-badge { background: #f0fdf4; color: #166534; padding: 4px 8px; border-radius: 6px; font-size: 0.75rem; font-weight: 700; display: inline-block; margin-top: 4px; border: 1px solid #bbf7d0; }
        
        .ai-container { background: #1e293b; color: #e2e8f0; border-radius: 15px; padding: 25px; margin-bottom: 25px; border-right: 6px solid var(--secondary); box-shadow: 0 20px 25px -5px rgba(0,0,0,0.2); }
        .ai-content { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height: 1.8; }
        .ai-content h3, .ai-content h4 { color: #fff; margin-top: 20px; margin-bottom: 10px; border-bottom: 1px solid #334155; padding-bottom: 5px; }
        .ai-content ul { padding-right: 20px; }
        .ai-content li { margin-bottom: 8px; }
        
        .score-card { background: white; border-radius: 15px; padding: 20px; text-align: center; display: flex; flex-direction: column; justify-content: center; border: 1px solid #e2e8f0; }
        .score-value { font-size: 3.5rem; font-weight: 900; line-height: 1; margin: 10px 0; }
        
        .btn-action { padding: 10px 20px; border-radius: 8px; font-weight: 600; display: inline-flex; align-items: center; gap: 8px; transition: all 0.2s; border: none; cursor: pointer; text-decoration: none; }
        .btn-action:hover { transform: translateY(-2px); box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); }

        .error-alert { background: #fee2e2; border-right: 5px solid #ef4444; color: #991b1b; padding: 20px; border-radius: 12px; margin-bottom: 25px; display: flex; align-items: center; gap: 15px; }
        
        @media print {
            .sidebar, .filter-box, .no-print, .export-btns, .btn-back { display: none !important; }
            .main-content { margin: 0 !important; width: 100% !important; padding: 0 !important; }
            .ai-container { background: white !important; color: black !important; border: 1px solid #ccc !important; box-shadow: none !important; }
            .data-table-container { box-shadow: none !important; border: 1px solid #000 !important; }
            th, td { border: 1px solid #000 !important; }
        }
    </style>
</head>
<body style="background: #f1f5f9;">
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>

        <div class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
                <div>
                    <h1 style="margin: 0; color: var(--dark); font-size: 1.8rem;"><i class="fas fa-chart-pie" style="color: var(--primary);"></i> <?php echo htmlspecialchars($stat['stat_name']); ?></h1>
                    <p style="color: #64748b; margin-top: 5px;">تحليل البيانات الإحصائية والذكاء الاصطناعي</p>
                </div>
                <div style="display: flex; gap: 12px;">
                    <?php if ($table_exists): ?>
                        <button class="btn-action" style="background: #10b981; color: white;" onclick="exportExcel()"><i class="fas fa-file-excel"></i> Excel</button>
                        <a href="official_pdf_report.php?id=<?php echo $stat_id; ?>" class="btn-action" style="background: #1e3a8a; color: white;" target="_blank"><i class="fas fa-file-pdf"></i> تقرير PDF</a>
                        <button class="btn-action" style="background: #ef4444; color: white;" onclick="window.print()"><i class="fas fa-print"></i> طباعة</button>
                    <?php endif; ?>
                    <a href="view_stats.php" class="btn-action" style="background: #e2e8f0; color: #475569;"><i class="fas fa-arrow-right"></i> عودة</a>
                </div>
            </div>

            <?php if (!$table_exists): ?>
                <div class="error-alert">
                    <i class="fas fa-exclamation-triangle" style="font-size: 2rem;"></i>
                    <div>
                        <h3 style="margin: 0;">خطأ في قاعدة البيانات</h3>
                        <p style="margin: 5px 0 0 0;">عذراً، يبدو أن جدول البيانات الخاص بهذه الإحصائية غير موجود حالياً. قد يكون تم حذفه يدوياً من قاعدة البيانات. يرجى التواصل مع مسؤول النظام أو إعادة إنشاء الإحصائية.</p>
                    </div>
                </div>
            <?php endif; ?>

            <!-- لوحة الذكاء الاصطناعي والجودة -->
            <div style="display: grid; grid-template-columns: 1fr 300px; gap: 25px; margin-bottom: 30px;">
                <div class="ai-container">
                    <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 20px;">
                        <i class="fas fa-robot" style="font-size: 2rem; color: var(--secondary);"></i>
                        <h2 style="margin: 0; color: white;">محرك التحليل الذكي (AI Insight)</h2>
                    </div>
                    <div id="ai-content-markdown" class="ai-content">
                        <?php echo nl2br($ai_analysis); ?>
                    </div>
                </div>
                <div class="score-card">
                    <h3 style="color: #64748b; font-size: 1rem; margin: 0;">مؤشر جودة البيانات</h3>
                    <div class="score-value" style="color: <?php echo $quality_score > 80 ? 'var(--success)' : ($quality_score > 50 ? 'var(--warning)' : 'var(--danger)'); ?>;">
                        <?php echo $quality_score; ?><span style="font-size: 1.5rem;">%</span>
                    </div>
                    <div style="width: 100%; background: #e2e8f0; height: 8px; border-radius: 4px; margin: 15px 0;">
                        <div style="width: <?php echo $quality_score; ?>%; background: <?php echo $quality_score > 80 ? 'var(--success)' : ($quality_score > 50 ? 'var(--warning)' : 'var(--danger)'); ?>; height: 100%; border-radius: 4px;"></div>
                    </div>
                    <p style="color: #94a3b8; font-size: 0.8rem;">يعتمد على اكتمال الحقول تاريخياً.</p>
                </div>
            </div>

            <?php if ($table_exists): ?>
            <div class="filter-box no-print">
                <h3 style="margin: 0 0 20px 0; font-size: 1.1rem;"><i class="fas fa-filter" style="color: var(--primary);"></i> فلترة البيانات المتقدمة</h3>
                <div class="filter-grid">
                    <div>
                        <label style="display: block; font-size: 0.85rem; font-weight: 700; margin-bottom: 8px; color: var(--dark);">المستخدم / الجهة</label>
                        <select id="filterUser" style="width: 100%; padding: 12px; border: 1px solid #e2e8f0; border-radius: 10px; background: #f8fafc;">
                            <option value="">كل الجهات التابعة</option>
                            <?php foreach($available_users as $u) echo "<option value='".htmlspecialchars($u['full_name'])."'>".htmlspecialchars($u['full_name'])."</option>"; ?>
                        </select>
                    </div>
                    <div>
                        <label style="display: block; font-size: 0.85rem; font-weight: 700; margin-bottom: 8px; color: var(--dark);">السنة المالية</label>
                        <select id="filterYear" style="width: 100%; padding: 12px; border: 1px solid #e2e8f0; border-radius: 10px; background: #f8fafc;">
                            <option value="">كل السنوات</option>
                            <?php 
                            $years = array_unique(array_column($data, 'stat_year'));
                            sort($years);
                            foreach($years as $y) echo "<option value='$y'>$y</option>";
                            ?>
                        </select>
                    </div>
                    <div style="display: flex; align-items: flex-end;">
                        <button class="btn-action" style="background: var(--primary); color: white; width: 100%; justify-content: center;" onclick="smartFilter()">
                            <i class="fas fa-sync-alt"></i> تحديث العرض
                        </button>
                    </div>
                </div>
            </div>
            <?php endif; ?>

            <div class="data-table-container">
                <table id="dataTable">
                    <thead>
                        <tr>
                            <th>الجهة / المستخدم</th>
                            <th>السنة</th>
                            <th>الفترة</th>
                            <?php foreach ($stat['columns'] as $col): ?>
                                <th><?php echo $col['column_label']; ?></th>
                            <?php endforeach; ?>
                            <th class="no-print">الإجراءات</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if(empty($data)): ?>
                            <tr>
                                <td colspan="<?php echo count($stat['columns']) + 4; ?>" style="padding: 60px; color: #94a3b8; font-style: italic;">
                                    <?php echo $table_exists ? "لا توجد بيانات متاحة للعرض حالياً." : "تعذر جلب البيانات لعدم وجود الجدول."; ?>
                                </td>
                            </tr>
                        <?php else: ?>
                            <?php foreach ($data as $row): ?>
                            <tr class="data-row" data-user="<?php echo htmlspecialchars($row['full_name']); ?>" data-year="<?php echo $row['stat_year']; ?>">
                                <td style="text-align: right; font-weight: 700; color: var(--dark);"><?php echo htmlspecialchars($row['full_name']); ?></td>
                                <td><span style="background: #f1f5f9; padding: 4px 10px; border-radius: 20px; font-size: 0.85rem;"><?php echo $row['stat_year']; ?></span></td>
                                <td><?php 
                                    if($stat['stat_type'] == 'monthly') echo $arabic_months[$row['stat_period']];
                                    elseif($stat['stat_type'] == 'six_months') echo $row['stat_period'] == 1 ? 'السداسي 1' : 'السداسي 2';
                                    else echo "سنوي";
                                ?></td>
                                <?php foreach ($stat['columns'] as $col): ?>
                                    <td class="col-val" data-type="<?php echo $col['data_type']; ?>" data-name="<?php echo $col['column_name']; ?>">
                                        <div style="font-weight: 600;">
                                            <?php 
                                                $val = $row[$col['column_name']];
                                                echo formatNumber($val, $col['data_type']);
                                            ?>
                                        </div>
                                        <?php if (isset($calculations['percentages'][$row['id']][$col['column_name']])): ?>
                                            <div class="percentage-badge" title="نسبة المساهمة في الإجمالي">
                                                <?php echo round($calculations['percentages'][$row['id']][$col['column_name']], 1); ?>%
                                            </div>
                                        <?php endif; ?>
                                    </td>
                                <?php endforeach; ?>
                                <td class="no-print">
                                    <div style="display: flex; gap: 8px; justify-content: center;">
                                        <?php if($role_level == 1 || $row['user_id'] == $user_id): ?>
                                            <a href="fill_stat.php?id=<?php echo $stat_id; ?>&edit_id=<?php echo $row['id']; ?>" class="btn-action" style="background: #fef3c7; color: #92400e; padding: 6px 10px; font-size: 0.8rem;" title="تعديل">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                        <?php endif; ?>
                                    </div>
                                </td>
                            </tr>
                            <?php endforeach; ?>
                            
                            <tr class="total-row">
                                <td colspan="3">المجموع العام للبيانات المعروضة</td>
                                <?php foreach ($stat['columns'] as $col): ?>
                                    <td>
                                        <?php 
                                            $col_name = $col['column_name'];
                                            if (isset($calculations['totals'][$col_name])) {
                                                echo formatNumber($calculations['totals'][$col_name], $col['data_type']);
                                            } else {
                                                echo "-";
                                            }
                                        ?>
                                    </td>
                                <?php endforeach; ?>
                                <td class="no-print"></td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            if (typeof marked !== 'undefined') {
                const rawContent = $('#ai-content-markdown').html();
                const cleanContent = rawContent.replace(/<br\s*\/?>/mg, "\n");
                $('#ai-content-markdown').html(marked.parse(cleanContent));
            }
        });

        function smartFilter() {
            const user = $('#filterUser').val();
            const year = $('#filterYear').val();
            $('.data-row').each(function() {
                const rowUser = $(this).data('user');
                const rowYear = $(this).data('year').toString();
                let show = true;
                if (user && rowUser !== user) show = false;
                if (year && rowYear !== year) show = false;
                $(this).toggle(show);
            });
        }

        function exportExcel() {
            let csv = [];
            const rows = document.querySelectorAll("table tr");
            for (let i = 0; i < rows.length; i++) {
                if (rows[i].style.display === 'none') continue;
                let row = [], cols = rows[i].querySelectorAll("td, th");
                for (let j = 0; j < cols.length - 1; j++) {
                    let text = cols[j].innerText.replace(/(\r\n|\n|\r)/gm, " ").replace(/%/g, "");
                    row.push('"' + text + '"');
                }
                csv.push(row.join(","));
            }
            const csvFile = new Blob(["\ufeff" + csv.join("\n")], {type: "text/csv;charset=utf-8;"});
            const downloadLink = document.createElement("a");
            downloadLink.download = "<?php echo $stat['stat_name']; ?>_تحليل.csv";
            downloadLink.href = window.URL.createObjectURL(csvFile);
            downloadLink.style.display = "none";
            document.body.appendChild(downloadLink);
            downloadLink.click();
        }
    </script>
</body>
</html>
