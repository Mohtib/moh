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
    die("يرجى اختيار إحصائية لتوليد الملخص التنفيذي.");
}

$stat = $statObj->getStatDetails($stat_id);
if (!$stat) {
    die("الإحصائية غير موجودة.");
}

// التحقق من أن نوع الإحصائية مناسب للملخص التنفيذي
if ($stat['stat_type'] === 'file_exchange') {
    die("لا يمكن توليد ملخص تنفيذي لهذا النوع من الإحصائيات (تبادل الملفات).");
}

$data = $statObj->getStatData($stat['table_name'], null, 1);
$calc = $statObj->calculateStats($data, $stat['columns']);

// دالة توليد الملخص التنفيذي الذكي (معدلة للتعامل مع البيانات المفقودة)
function generateExecutiveSummary($stat, $calc) {
    $summary = "<h3><i class='fas fa-file-alt'></i> الملخص التنفيذي الذكي</h3>";
    $summary .= "<p>بناءً على التحليل الإحصائي المتقدم لبيانات <strong>{$stat['stat_name']}</strong>، نضع بين أيديكم الرؤى التالية:</p>";
    
    // 1. نظرة عامة - مع التأكد من وجود yearly_data
    $total_records = isset($calc['yearly_data']) && is_array($calc['yearly_data']) ? count($calc['yearly_data']) : 0;
    $summary .= "<div class='summary-section'><h4>1. النطاق الزمني والأداء العام</h4>";
    if ($total_records > 0) {
        $summary .= "يغطي التقرير فترة زمنية قدرها $total_records سنوات. نلاحظ استقراراً في تدفق البيانات مع ";
        
        // التأكد من وجود growth
        $growth_avg = 0;
        if (isset($calc['growth']) && is_array($calc['growth']) && count($calc['growth']) > 0) {
            $growth_avg = array_sum($calc['growth']) / count($calc['growth']);
        }
        
        if ($growth_avg > 0) {
            $summary .= "اتجاه صعودي عام بمعدل نمو إجمالي قدره " . round($growth_avg, 2) . "%، مما يشير إلى تحسن مستمر في المؤشرات.";
        } else {
            $summary .= "تذبذب طفيف في المؤشرات العامة يتطلب متابعة دقيقة لبعض القطاعات.";
        }
    } else {
        $summary .= "لا توجد بيانات كافية لتحليل النطاق الزمني.";
    }
    $summary .= "</div>";

    // 2. النقاط الجوهرية - مع التأكد من وجود totals
    if (isset($calc['totals']) && is_array($calc['totals']) && !empty($calc['totals'])) {
        $summary .= "<div class='summary-section'><h4>2. أبرز المؤشرات (Key Performance Indicators)</h4><ul>";
        foreach ($calc['totals'] as $col => $val) {
            $label = "";
            foreach ($stat['columns'] as $c) {
                if ($c['column_name'] == $col) {
                    $label = $c['column_label'];
                    break;
                }
            }
            $summary .= "<li>بلغ إجمالي <strong>$label</strong> قيمة قدرها " . number_format($val, 2) . ".</li>";
        }
        $summary .= "</ul></div>";
    } else {
        $summary .= "<div class='summary-section'><h4>2. أبرز المؤشرات</h4><p>لا توجد مؤشرات إجمالية لعرضها.</p></div>";
    }

    // 3. التوصيات الإدارية (يمكن عرض توصيات عامة حتى لو كانت البيانات ناقصة)
    $summary .= "<div class='summary-section'><h4>3. التوصيات الإدارية المقترحة</h4><ul>";
    if (isset($growth_avg) && $growth_avg < 5 && $growth_avg > 0) {
        $summary .= "<li><strong>تعزيز الأداء:</strong> يوصى بوضع خطة عمل لرفع وتيرة الإنجاز في القطاعات التي سجلت نمواً أقل من 5%.</li>";
    }
    $summary .= "<li><strong>جودة البيانات:</strong> الاستمرار في تفعيل نظام الرقابة الفوري لضمان دقة التقارير المستقبلية.</li>";
    $summary .= "<li><strong>التوسع التنبؤي:</strong> الاعتماد على التوقعات الإحصائية في تخصيص الموارد للسنة القادمة.</li>";
    $summary .= "</ul></div>";

    return $summary;
}

?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>الملخص التنفيذي الذكي | جامعة ميلة</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .summary-box { background: white; padding: 40px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); border: 1px solid #e2e8f0; max-width: 900px; margin: 20px auto; }
        .summary-section { margin-bottom: 30px; line-height: 1.8; color: #334155; }
        .summary-section h4 { color: #1e293b; border-right: 4px solid #2563eb; padding-right: 15px; margin-bottom: 15px; }
        .summary-section ul { padding-right: 25px; }
        .summary-section li { margin-bottom: 10px; }
        @media print { .sidebar, .btn-print { display: none; } .summary-box { box-shadow: none; border: none; width: 100%; max-width: 100%; } }
    </style>
</head>
<body style="background: #f8fafc;">
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        <div class="main-content">
            <div style="text-align: left; margin-bottom: 20px;">
                <button onclick="window.print()" class="btn btn-print" style="background: #1e293b; color: white;"><i class="fas fa-print"></i> طباعة الملخص الرسمي</button>
            </div>
            
            <div class="summary-box">
                <div style="text-align: center; margin-bottom: 40px;">
                    <img src="assets/logo_mila.png" alt="جامعة ميلة" style="height: 80px;">
                    <h2 style="margin-top: 15px; color: #1e293b;">الجمهورية الجزائرية الديمقراطية الشعبية</h2>
                    <h3 style="color: #64748b;">وزارة التعليم العالي والبحث العلمي - جامعة ميلة</h3>
                    <hr style="width: 100px; border: 2px solid #2563eb; margin: 20px auto;">
                </div>

                <?php echo generateExecutiveSummary($stat, $calc); ?>

                <div style="margin-top: 60px; display: flex; justify-content: space-between;">
                    <div style="text-align: center;">
                        <p><strong>توقيع المسؤول عن الإحصاء</strong></p>
                        <div style="height: 80px;"></div>
                    </div>
                    <div style="text-align: center;">
                        <p><strong>ختم الإدارة المركزية</strong></p>
                        <div style="height: 80px;"></div>
                    </div>
                </div>
                
                <div style="margin-top: 40px; text-align: center; font-size: 0.8rem; color: #94a3b8; border-top: 1px solid #f1f5f9; padding-top: 20px;">
                    تم توليد هذا الملخص تلقائياً بواسطة محرك الذكاء الاصطناعي لنظام إحصائيات جامعة ميلة - <?php echo date('Y-m-d H:i'); ?>
                </div>
            </div>
        </div>
    </div>
</body>
</html>