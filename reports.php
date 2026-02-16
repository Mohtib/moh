<?php
session_start();
require_once 'config/db.php';
require_once 'includes/User.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$userObj = new User($pdo);
$current_user_id = $_SESSION['user_id'];
$role_level = (int)$_SESSION['role_level'];
$full_name = $_SESSION['full_name'];

// جلب التابعين المباشرين للمستخدم الحالي
$subordinates = $userObj->getSubordinates($current_user_id);
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>التقارير المتقدمة | نظام الإحصائيات</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary: #2563eb;
            --primary-light: #3b82f6;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --dark: #1e293b;
            --light: #f8fafc;
            --gray: #64748b;
            --border: #e2e8f0;
        }

        * {
            box-sizing: border-box;
            font-family: 'Tajawal', sans-serif;
        }

        .filter-section { 
            background: #fff; 
            padding: 25px; 
            border-radius: 16px; 
            box-shadow: 0 4px 20px rgba(0,0,0,0.03); 
            margin-bottom: 25px; 
            border: 1px solid var(--border);
        }
        .filter-section h3 {
            margin-top: 0;
            margin-bottom: 20px;
            color: var(--dark);
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .filter-section h3 i {
            color: var(--primary);
        }
        .filter-row { 
            display: flex; 
            gap: 15px; 
            margin-bottom: 15px; 
            flex-wrap: wrap; 
        }
        .filter-item { 
            flex: 1; 
            min-width: 200px; 
        }
        .filter-item label { 
            display: block; 
            margin-bottom: 8px; 
            font-weight: 600; 
            color: var(--dark); 
            font-size: 0.9rem;
        }
        .filter-item select, .filter-item input { 
            width: 100%; 
            padding: 12px 15px; 
            border: 1px solid var(--border); 
            border-radius: 10px; 
            font-size: 0.95rem;
            transition: all 0.2s;
            background: #fff;
        }
        .filter-item select:focus, .filter-item input:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(37,99,235,0.1);
        }
        .stat-container { 
            margin-top: 25px; 
        }
        .stat-card { 
            background: #fff; 
            padding: 25px; 
            border-radius: 20px; 
            box-shadow: 0 8px 25px rgba(0,0,0,0.03); 
            margin-bottom: 30px; 
            border: 1px solid var(--border);
            border-right: 6px solid var(--primary); 
        }
        .stat-card h3 {
            margin: 0 0 15px 0;
            color: var(--dark);
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .stat-card h3 i {
            color: var(--primary);
        }
        .stat-table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 15px; 
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.02);
        }
        .stat-table th { 
            background: linear-gradient(135deg, #f1f5f9 0%, #e9eef3 100%);
            color: var(--dark);
            font-weight: 700;
            padding: 15px 12px; 
            border: none;
            font-size: 0.95rem;
        }
        .stat-table td { 
            padding: 14px 12px; 
            border-bottom: 1px solid var(--border);
            background: #fff;
        }
        .stat-table tbody tr:hover td {
            background: #f9fbfd;
        }
        .stat-table tfoot td {
            background: #eef2f6;
            font-weight: 700;
            color: var(--dark);
            border-top: 2px solid var(--border);
        }
        .stat-table .total-row {
            background: #f0f9ff;
            font-weight: 700;
        }
        .stat-table .grand-total {
            background: #dbeafe;
            color: var(--primary);
            font-weight: 800;
        }
        .loading { 
            display: none; 
            text-align: center; 
            padding: 40px; 
            background: #fff;
            border-radius: 16px;
            border: 1px solid var(--border);
        }
        .loading i {
            color: var(--primary);
        }
        .user-info-badge { 
            background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
            color: var(--primary); 
            padding: 15px 25px; 
            border-radius: 50px; 
            margin-bottom: 25px; 
            border: 1px solid #bfdbfe; 
            display: inline-block;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(37,99,235,0.1);
        }
        .export-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .export-btn {
            padding: 10px 18px;
            border-radius: 50px;
            color: white;
            font-size: 0.9rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
            border: none;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        .export-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.1);
        }
        .btn-pdf { background: var(--danger); }
        .btn-word { background: var(--primary); }
        .btn-excel { background: var(--success); }
        .btn-csv { background: var(--warning); }
        .btn-print { background: var(--dark); }
        .value-number {
            font-weight: 600;
            color: var(--dark);
        }
        .value-percent {
            color: var(--gray);
            font-size: 0.8rem;
            margin-right: 4px;
        }
    </style>
</head>
<body style="background: #f5f7fa;">
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        <div class="main-content">
            <h2 style="color: var(--dark); margin-bottom: 20px;"><i class="fas fa-file-invoice" style="color: var(--primary);"></i> مركز التقارير والفلترة الهرمية</h2>
            
            <div class="user-info-badge">
                <i class="fas fa-user-shield"></i> مرحباً <strong><?php echo htmlspecialchars($full_name); ?></strong>. 
                <?php if($role_level == 1): ?> أنت تشاهد إحصائيات النظام بالكامل.
                <?php else: ?> أنت تشاهد إحصائياتك وإحصائيات التابعين لك.
                <?php endif; ?>
            </div>

            <div class="filter-section">
                <h3><i class="fas fa-file-archive"></i> التقرير الموحد</h3>
                <p style="color: var(--gray); margin-bottom: 15px;"><?php echo $role_level == 1 ? 'تصدير كافة إحصائيات الجامعة في ملف واحد منظم.' : 'تصدير كافة إحصائياتك وإحصائيات التابعين لك في ملف واحد.'; ?></p>
                <a href="export_report.php?all=1" target="_blank" class="export-btn" style="background: var(--success);">
                    <i class="fas fa-file-pdf"></i> تصدير التقرير الموحد (PDF/Print)
                </a>
            </div>

            <!-- الفلترة الهرمية للمستخدمين -->
            <div class="filter-section">
                <h3><i class="fas fa-users"></i> فلترة حسب الهيكل التنظيمي</h3>
                <div class="filter-row">
                    <div class="filter-item">
                        <label>المستوى الأول (التابعين المباشرين)</label>
                        <select id="user_level_1" onchange="loadSubUsers(this.value, 2)">
                            <option value="all">الكل (أنا والجميع)</option>
                            <option value="<?php echo $current_user_id; ?>">إحصائياتي فقط</option>
                            <?php foreach($subordinates as $v) echo "<option value='{$v['id']}'>{$v['full_name']}</option>"; ?>
                        </select>
                    </div>
                    <div class="filter-item">
                        <label>المستوى الثاني</label>
                        <select id="user_level_2" onchange="loadSubUsers(this.value, 3)" disabled>
                            <option value="all">الكل</option>
                        </select>
                    </div>
                    <div class="filter-item">
                        <label>المستوى الثالث</label>
                        <select id="user_level_3" onchange="applyFilters()" disabled>
                            <option value="all">الكل</option>
                        </select>
                    </div>
                </div>
                <div class="filter-row" style="margin-top: 20px;">
                    <div class="filter-item">
                        <label>السنة الدراسية</label>
                        <select id="academic_year">
                            <option value="2025">2025</option>
                            <option value="2024">2024</option>
                            <option value="2023">2023</option>
                        </select>
                    </div>
                    <div class="filter-item">
                        <label>الفترة</label>
                        <select id="stat_period">
                            <option value="1">الفترة الأولى</option>
                            <option value="2">الفترة الثانية</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- الفلترة الهرمية للجداول -->
            <div class="filter-section">
                <h3><i class="fas fa-table"></i> فلترة حسب نوع الإحصائية</h3>
                <div class="filter-row">
                    <div class="filter-item">
                        <label>الإحصائية الرئيسية</label>
                        <select id="stat_level_1" onchange="loadSubStats(this.value, 2)">
                            <option value="">اختر الإحصائية...</option>
                        </select>
                    </div>
                    <div class="filter-item">
                        <label>الإحصائية الفرعية</label>
                        <select id="stat_level_2" onchange="loadSubStats(this.value, 3)" disabled>
                            <option value="">اختر الفرعية...</option>
                        </select>
                    </div>
                    <div class="filter-item">
                        <label>إحصائية التفاصيل</label>
                        <select id="stat_level_3" onchange="applyFilters()" disabled>
                            <option value="">اختر التفصيلية...</option>
                        </select>
                    </div>
                </div>
            </div>

            <div id="loader" class="loading">
                <i class="fas fa-spinner fa-spin fa-3x"></i>
                <p style="margin-top: 15px; color: var(--gray);">جاري تحميل البيانات ...</p>
            </div>
            <div id="resultsContainer" class="stat-container"></div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            loadRootStats();
        });

        function loadRootStats() {
            $.get('api/smart_filter.php', { action: 'get_root_stats' }, function(data) {
                let html = '<option value="">اختر الإحصائية...</option>';
                data.forEach(s => html += `<option value="${s.id}">${s.stat_name}</option>`);
                $('#stat_level_1').html(html);
            }).fail(function() {
                alert('فشل تحميل الإحصائيات الرئيسية');
            });
        }

        function loadSubStats(parentId, level) {
            if (!parentId) {
                resetStatLevels(level);
                applyFilters();
                return;
            }
            $.get('api/smart_filter.php', { action: 'get_child_stats', parent_id: parentId }, function(data) {
                let html = '<option value="">اختر...</option>';
                if (data.length > 0) {
                    data.forEach(s => html += `<option value="${s.id}">${s.stat_name}</option>`);
                    $(`#stat_level_${level}`).html(html).prop('disabled', false);
                } else {
                    $(`#stat_level_${level}`).html('<option value="">لا توجد فروع</option>').prop('disabled', true);
                }
                applyFilters();
            }).fail(function() {
                alert('فشل تحميل الإحصائيات الفرعية');
            });
        }

        function loadSubUsers(parentId, level) {
            if (parentId === 'all' || parentId === '<?php echo $current_user_id; ?>') {
                resetUserLevels(level);
                applyFilters();
                return;
            }
            $.get('api/smart_filter.php', { action: 'get_subordinates', parent_id: parentId }, function(data) {
                let html = '<option value="all">الكل</option>';
                if (data.length > 0) {
                    data.forEach(u => html += `<option value="${u.id}">${u.full_name}</option>`);
                    $(`#user_level_${level}`).html(html).prop('disabled', false);
                } else {
                    $(`#user_level_${level}`).html('<option value="all">لا يوجد تابعين</option>').prop('disabled', true);
                }
                applyFilters();
            }).fail(function() {
                alert('فشل تحميل التابعين');
            });
        }

        function resetStatLevels(level) {
            for (let i = level; i <= 3; i++) {
                $(`#stat_level_${i}`).html('<option value="">اختر...</option>').prop('disabled', true);
            }
        }

        function resetUserLevels(level) {
            for (let i = level; i <= 3; i++) {
                $(`#user_level_${i}`).html('<option value="all">الكل</option>').prop('disabled', true);
            }
        }

        function applyFilters() {
            const statId = $('#stat_level_3').val() || $('#stat_level_2').val() || $('#stat_level_1').val();
            let userId = null;
            if ($('#user_level_3').val() && $('#user_level_3').val() !== 'all') userId = $('#user_level_3').val();
            else if ($('#user_level_2').val() && $('#user_level_2').val() !== 'all') userId = $('#user_level_2').val();
            else if ($('#user_level_1').val() && $('#user_level_1').val() !== 'all') userId = $('#user_level_1').val();

            const year = $('#academic_year').val();
            const period = $('#stat_period').val();

            if (!statId) {
                $('#resultsContainer').html('<div class="filter-section" style="text-align:center; padding:40px;"><i class="fas fa-chart-pie fa-3x" style="color: #cbd5e1;"></i><p style="color: var(--gray); margin-top:15px;">يرجى اختيار إحصائية لعرض البيانات</p></div>');
                return;
            }

            $('#loader').show();
            $.get('api/smart_filter.php', { 
                action: 'get_stat_data_advanced', 
                stat_id: statId, 
                user_id: userId,
                year: year,
                period: period
            }, function(res) {
                renderResults(res, statId, userId, year, period);
                $('#loader').hide();
            }).fail(function(xhr, status, error) {
                $('#loader').hide();
                $('#resultsContainer').html('<div class="filter-section" style="text-align:center; padding:40px; color: var(--danger);"><i class="fas fa-exclamation-triangle fa-3x"></i><p style="margin-top:15px;">حدث خطأ أثناء جلب البيانات: ' + error + '</p></div>');
            });
        }

        function formatNumber(value, type) {
            if (value === null || value === undefined || value === '') return '-';
            // إذا كان رقمًا عشريًا نظهره بفاصلة عشرية، وإلا نعرضه كعدد صحيح
            let num = parseFloat(value);
            if (isNaN(num)) return value;
            
            if (Number.isInteger(num)) {
                return num.toString(); // عدد صحيح بدون فواصل
            } else {
                return num.toFixed(2); // عدد عشري بمنزلتين
            }
        }

        function renderResults(res, statId, userId, year, period) {
            if (!res.stat || !res.data) {
                $('#resultsContainer').html('<div class="filter-section" style="text-align:center; padding:40px;"><i class="fas fa-database fa-3x" style="color: #cbd5e1;"></i><p style="color: var(--gray); margin-top:15px;">لا توجد بيانات متاحة لهذه الإحصائية</p></div>');
                return;
            }
            const { stat, data, analysis } = res;
            
            if (data.length === 0) {
                $('#resultsContainer').html('<div class="filter-section" style="text-align:center; padding:40px;"><i class="fas fa-chart-line fa-3x" style="color: #cbd5e1;"></i><p style="color: var(--gray); margin-top:15px;">لا توجد بيانات مدخلة لهذه الإحصائية بعد</p></div>');
                return;
            }

            let html = `
                <div class="stat-card">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 15px;">
                        <h3><i class="fas fa-chart-bar"></i> ${stat.stat_name}</h3>
                        <div class="export-buttons">
                            <a href="export_report.php?stat_id=${statId}&user_id=${userId || ''}&year=${year}&period=${period}&format=pdf" target="_blank" class="export-btn btn-pdf"><i class="fas fa-file-pdf"></i> PDF</a>
                            <a href="export_report.php?stat_id=${statId}&user_id=${userId || ''}&year=${year}&period=${period}&format=word" target="_blank" class="export-btn btn-word"><i class="fas fa-file-word"></i> Word</a>
                            <a href="export_report.php?stat_id=${statId}&user_id=${userId || ''}&year=${year}&period=${period}&format=excel" target="_blank" class="export-btn btn-excel"><i class="fas fa-file-excel"></i> Excel</a>
                            <a href="export_report.php?stat_id=${statId}&user_id=${userId || ''}&year=${year}&period=${period}&format=csv" target="_blank" class="export-btn btn-csv"><i class="fas fa-file-csv"></i> CSV</a>
                        </div>
                    </div>
                    <div style="overflow-x: auto;">
                        <table class="stat-table">
                            <thead>
                                <tr>
                                    <th>المستخدم</th>
                                    ${stat.columns.map(c => `<th>${c.column_label}</th>`).join('')}
                                    <th>المجموع</th>
                                </tr>
                            </thead>
                            <tbody>
            `;

            let grandTotals = {};
            stat.columns.forEach(c => grandTotals[c.column_name] = 0);

            data.forEach((row, idx) => {
                let rowSum = 0;
                let rowHtml = '<tr>';
                rowHtml += `<td style="font-weight:600;">${row.full_name || 'غير معروف'}</td>`;
                
                stat.columns.forEach(c => {
                    const val = row[c.column_name];
                    const isNumeric = (c.data_type === 'number' || c.data_type === 'integer' || c.data_type === 'decimal');
                    let displayVal = formatNumber(val, c.data_type);
                    
                    if (isNumeric) {
                        let num = parseFloat(val) || 0;
                        rowSum += num;
                        grandTotals[c.column_name] += num;
                        displayVal = `<span class="value-number">${displayVal}</span>`;
                    } else if (c.data_type === 'boolean') {
                        displayVal = val ? 'نعم' : 'لا';
                    } else {
                        displayVal = displayVal !== '-' ? displayVal : '—';
                    }
                    
                    rowHtml += `<td>${displayVal}</td>`;
                });
                
                rowHtml += `<td style="background:#f0f9ff; font-weight:700;">${rowSum.toFixed(2)}</td>`;
                rowHtml += '</tr>';
                html += rowHtml;
            });

            html += `</tbody><tfoot><tr style="background:#eef2f6;">`;
            html += `<td style="font-weight:800;">المجموع الكلي</td>`;
            
            stat.columns.forEach(c => {
                const isNumeric = (c.data_type === 'number' || c.data_type === 'integer' || c.data_type === 'decimal');
                if (isNumeric) {
                    let total = grandTotals[c.column_name] || 0;
                    html += `<td style="font-weight:800; background:#dbeafe;">${total.toFixed(2)}</td>`;
                } else {
                    html += `<td>-</td>`;
                }
            });
            
            html += `<td style="background:#dbeafe; font-weight:800;">-</td>`;
            html += `</tr></tfoot></table></div></div>`;
            
            $('#resultsContainer').html(html);
        }
    </script>
</body>
</html>