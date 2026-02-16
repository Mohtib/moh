<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id'])) {
    die("غير مصرح");
}

$stat_id = $_GET['id'] ?? null;
if (!$stat_id) die("إحصائية غير محددة");

$user_id = $_SESSION['user_id'];
$role_level = (int)$_SESSION['role_level'];

$statObj = new Stat($pdo);
$stat = $statObj->getStatDetails($stat_id);

if (!$stat) {
    die("الإحصائية غير موجودة");
}

// التحقق من وجود الجدول في قاعدة البيانات
$table_exists = $statObj->tableExists($stat['table_name']);

// جلب البيانات مع التصفية الهرمية فقط إذا كان الجدول موجوداً
$data = $table_exists ? $statObj->getStatData($stat['table_name'], $user_id, $role_level) : [];
$analysis = $table_exists ? $statObj->calculateStats($data, $stat['columns']) : ['totals' => [], 'averages' => [], 'growth' => [], 'percentages' => [], 'yearly_data' => []];
$ai_report = $table_exists ? $statObj->analyzeWithAI($data, $stat['stat_name'], $stat['columns']) : "تعذر إجراء التحليل لعدم وجود جدول البيانات في قاعدة البيانات.";

/**
 * دالة لتنسيق الأرقام
 */
function formatNum($val, $type) {
    if (!is_numeric($val)) return $val;
    if ($type == 'integer') return number_format($val, 0);
    return (floor($val) == $val) ? number_format($val, 0) : number_format($val, 2);
}

// تحضير محتوى HTML للتقرير
ob_start();
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Tajawal:wght@400;500;700;800&display=swap');
        body { font-family: 'Tajawal', 'Arial', sans-serif; line-height: 1.6; color: #1e293b; background: #fff; margin: 0; padding: 0; }
        .page { padding: 40px; }
        .header-table { width: 100%; border: none; margin-bottom: 30px; }
        .header-table td { border: none; vertical-align: middle; text-align: center; }
        .university-info { text-align: center; font-weight: bold; font-size: 14px; }
        .report-header { text-align: center; background: #f8fafc; padding: 20px; border-radius: 15px; border: 1px solid #e2e8f0; margin-bottom: 30px; }
        .report-title { font-size: 24px; font-weight: 800; color: #1e3a8a; margin: 10px 0; }
        .meta-info { font-size: 12px; color: #64748b; margin-bottom: 20px; text-align: left; }
        
        .section-title { font-size: 18px; font-weight: 700; color: #2563eb; border-right: 4px solid #2563eb; padding-right: 10px; margin: 30px 0 15px 0; }
        
        table { width: 100%; border-collapse: collapse; margin-bottom: 25px; font-size: 12px; }
        th { background-color: #f1f5f9; color: #1e293b; font-weight: 700; padding: 12px; border: 1px solid #cbd5e1; text-align: center; }
        td { padding: 10px; border: 1px solid #cbd5e1; text-align: center; }
        .total-row { background-color: #eff6ff; font-weight: bold; color: #1e40af; }
        
        .ai-box { background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 10px; padding: 20px; font-size: 13px; white-space: pre-wrap; color: #334155; }
        .error-box { background: #fee2e2; border: 2px solid #ef4444; border-radius: 10px; padding: 20px; color: #991b1b; text-align: center; margin: 20px 0; }
        
        .footer { margin-top: 60px; width: 100%; }
        .signature-box { width: 300px; float: left; text-align: center; }
        .signature-title { font-weight: 700; margin-bottom: 50px; }
        .stamp-placeholder { width: 120px; height: 120px; border: 2px dashed #cbd5e1; border-radius: 50%; margin: 0 auto; display: flex; align-items: center; justify-content: center; color: #cbd5e1; font-size: 10px; }
        
        .print-footer { position: fixed; bottom: 20px; width: 100%; text-align: center; font-size: 10px; color: #94a3b8; border-top: 1px solid #e2e8f0; padding-top: 10px; }
    </style>
</head>
<body>
    <div class="page">
        <table class="header-table">
            <tr>
                <td width="30%">
                    <div class="university-info">
                        الجمهورية الجزائرية الديمقراطية الشعبية<br>
                        وزارة التعليم العالي والبحث العلمي
                    </div>
                </td>
                <td width="40%">
                    <img src="assets/logo_mila.png" style="height: 80px;" onerror="this.style.display='none'">
                </td>
                <td width="30%">
                    <div class="university-info">
                        جامعة عبد الحفيظ بو الصوف - ميلة<br>
                        الأمانة العامة / مديرية الإحصاء
                    </div>
                </td>
            </tr>
        </table>

        <div class="report-header">
            <div class="report-title">تقرير إحصائي تحليلي: <?php echo htmlspecialchars($stat['stat_name']); ?></div>
            <div style="color: #64748b;">نظام الإحصائيات المركزي - منصة التحليل الفائق</div>
        </div>

        <div class="meta-info">
            تاريخ استخراج التقرير: <?php echo date('Y-m-d H:i'); ?><br>
            المرجع الرقمي: UNIMILA-STAT-<?php echo $stat_id; ?>-<?php echo time(); ?>
        </div>

        <?php if (!$table_exists): ?>
            <div class="error-box">
                <h3>⚠️ خطأ فني: جدول البيانات مفقود</h3>
                <p>عذراً، لا يمكن توليد بيانات التقرير لأن الجدول الديناميكي المرتبط بهذه الإحصائية غير موجود في قاعدة البيانات.</p>
                <p>يرجى التواصل مع مسؤول النظام لإعادة مزامنة البيانات.</p>
            </div>
        <?php else: ?>
            <div class="section-title">أولاً: البيانات التفصيلية المجمعة</div>
            <table>
                <thead>
                    <tr>
                        <th>الجهة / المستخدم</th>
                        <th>السنة</th>
                        <th>الفترة</th>
                        <?php foreach ($stat['columns'] as $col): ?>
                            <th><?php echo $col['column_label']; ?></th>
                        <?php endforeach; ?>
                    </tr>
                </thead>
                <tbody>
                    <?php if (empty($data)): ?>
                        <tr>
                            <td colspan="<?php echo count($stat['columns']) + 3; ?>">لا توجد بيانات متاحة للعرض</td>
                        </tr>
                    <?php else: ?>
                        <?php foreach ($data as $row): ?>
                            <tr>
                                <td style="text-align: right; font-weight: bold;"><?php echo htmlspecialchars($row['full_name']); ?></td>
                                <td><?php echo $row['stat_year']; ?></td>
                                <td><?php 
                                    if($stat['stat_type'] == 'monthly') echo $row['stat_period'];
                                    elseif($stat['stat_type'] == 'six_months') echo $row['stat_period'] == 1 ? 'السداسي 1' : 'السداسي 2';
                                    else echo "سنوي";
                                ?></td>
                                <?php foreach ($stat['columns'] as $col): ?>
                                    <td><?php echo formatNum($row[$col['column_name']], $col['data_type']); ?></td>
                                <?php endforeach; ?>
                            </tr>
                        <?php endforeach; ?>
                        <tr class="total-row">
                            <td colspan="3">المجموع الإجمالي</td>
                            <?php foreach ($stat['columns'] as $col): ?>
                                <td><?php echo isset($analysis['totals'][$col['column_name']]) ? formatNum($analysis['totals'][$col['column_name']], $col['data_type']) : '-'; ?></td>
                            <?php endforeach; ?>
                        </tr>
                    <?php endif; ?>
                </tbody>
            </table>

            <div class="section-title">ثانياً: رؤى محرك الذكاء الاصطناعي</div>
            <div class="ai-box">
                <?php echo strip_tags($ai_report); ?>
            </div>
        <?php endif; ?>

        <div class="footer">
            <div class="signature-box">
                <div class="signature-title">توقيع وختم المسؤول</div>
                <div class="stamp-placeholder">ختم المؤسسة</div>
                <div style="margin-top: 10px; font-weight: bold;">حرر بميلة في: <?php echo date('Y-m-d'); ?></div>
            </div>
        </div>

        <div class="print-footer">
            هذا التقرير تم توليده آلياً من نظام جامعة ميلة للإحصائيات - أي كشط أو تغيير يلغي صلاحية التقرير
        </div>
    </div>
</body>
</html>
<?php
$html = ob_get_clean();
$report_path = "reports/official_report_{$stat_id}_" . time() . ".html";
if (!is_dir('reports')) mkdir('reports', 0777, true);
file_put_contents($report_path, $html);

echo "<!DOCTYPE html>
<html lang='ar' dir='rtl'>
<head>
    <meta charset='UTF-8'>
    <title>معاينة التقرير</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f1f5f9; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; }
        .card { background: white; padding: 40px; border-radius: 20px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); text-align: center; max-width: 500px; }
        .icon { font-size: 60px; color: #10b981; margin-bottom: 20px; }
        .icon-error { color: #ef4444; }
        h2 { color: #1e293b; margin-bottom: 10px; }
        p { color: #64748b; margin-bottom: 30px; }
        .btn { display: inline-block; padding: 15px 30px; background: #2563eb; color: white; text-decoration: none; border-radius: 10px; font-weight: bold; transition: background 0.2s; }
        .btn:hover { background: #1e40af; }
    </style>
</head>
<body>
    <div class='card'>
        " . ($table_exists ? "<div class='icon'>✅</div><h2>تم توليد التقرير الاحترافي</h2>" : "<div class='icon icon-error'>⚠️</div><h2>تنبيه: بيانات مفقودة</h2>") . "
        <p>" . ($table_exists ? "تم إعداد التقرير الإحصائي والتحليلي بنجاح. يمكنك الآن فتحه للمعاينة أو الطباعة كملف PDF." : "تم توليد هيكل التقرير ولكن تعذر جلب البيانات لعدم وجود الجدول في قاعدة البيانات.") . "</p>
        <a href='$report_path' target='_blank' class='btn'>فتح التقرير للمعاينة والطباعة</a>
        <div style='margin-top: 20px;'>
            <a href='view_stat_data.php?id=$stat_id' style='color: #64748b; text-decoration: none;'>العودة للبيانات</a>
        </div>
    </div>
</body>
</html>";
?>
