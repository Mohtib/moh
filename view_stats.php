<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';
require_once 'includes/User.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$user_id = $_SESSION['user_id'];
$role_level = (int)$_SESSION['role_level'];
$filter = $_GET['filter'] ?? 'all';
$selected_id = $_GET['id'] ?? null;

$statObj = new Stat($pdo);
$userObj = new User($pdo);
$subordinates = $userObj->getSubordinates($user_id);

$stats = $statObj->getAvailableStats($user_id, $role_level);

// منطق الفلترة للإحصائيات بانتظار الملء أو التي تم ملؤها
if ($role_level >= 3) {
    $filtered_stats = [];
    foreach ($stats as $stat) {
        $has_data = false;
        try {
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM `{$stat['table_name']}` WHERE user_id = ?");
            $stmt->execute([$user_id]);
            $has_data = ($stmt->fetchColumn() > 0);
        } catch (PDOException $e) { $has_data = false; }

        if ($filter == 'pending' && !$has_data) $filtered_stats[] = $stat;
        elseif ($filter == 'completed' && $has_data) $filtered_stats[] = $stat;
        elseif ($filter == 'all') $filtered_stats[] = $stat;
    }
    $stats = $filtered_stats;
}

// إذا تم اختيار إحصائية معينة، نضعها في البداية
if ($selected_id) {
    $selected_stat = null;
    foreach ($stats as $key => $s) {
        if ($s['id'] == $selected_id) {
            $selected_stat = $s;
            unset($stats[$key]);
            break;
        }
    }
    if ($selected_stat) array_unshift($stats, $selected_stat);
}
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>عرض الإحصائيات | نظام الإحصائيات</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .filter-section { background: white; padding: 20px; border-radius: 15px; margin-bottom: 25px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .filter-row { display: flex; gap: 15px; margin-bottom: 15px; flex-wrap: wrap; }
        .filter-item { flex: 1; min-width: 200px; }
        .filter-item label { display: block; margin-bottom: 8px; font-weight: bold; color: #1e293b; }
        .filter-item select, .filter-item input { width: 100%; padding: 10px; border: 1px solid #e2e8f0; border-radius: 8px; }
        .stat-card { transition: transform 0.3s; border: 1px solid #e2e8f0; display: flex; flex-direction: column; justify-content: space-between; height: 100%; position: relative; }
        .stat-card:hover { transform: translateY(-5px); border-color: #2563eb; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1); }
        .stat-card.selected { border: 2px solid #2563eb; background: #f0f7ff; }
        .badge-type { padding: 4px 10px; border-radius: 20px; font-size: 0.8em; font-weight: bold; }
        .type-monthly { background: #dbeafe; color: #1e40af; }
        .type-six_months { background: #fef3c7; color: #92400e; }
        .type-yearly { background: #d1fae5; color: #065f46; }
        .type-file_exchange { background: #f3e8ff; color: #6b21a8; }
        .pending-badge { background: #fee2e2; color: #991b1b; padding: 2px 8px; border-radius: 4px; font-size: 0.75em; margin-top: 5px; display: inline-block; }
        .completed-badge { background: #d1fae5; color: #065f46; padding: 2px 8px; border-radius: 4px; font-size: 0.75em; margin-top: 5px; display: inline-block; }
        .action-btns { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-top: 15px; padding-top: 15px; border-top: 1px solid #f1f5f9; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>

        <div class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
                <h2><i class="fas fa-chart-bar"></i> استكشاف الإحصائيات والبيانات</h2>
                <div style="display: flex; gap: 10px;">
                    <a href="view_stats.php?filter=pending" class="btn" style="background: <?php echo $filter=='pending'?'#ef4444':'#f8fafc'; ?>; color: <?php echo $filter=='pending'?'white':'#64748b'; ?>; text-decoration: none; padding: 8px 15px; border-radius: 8px; border: 1px solid #e2e8f0;">بانتظار الملء</a>
                    <a href="view_stats.php?filter=completed" class="btn" style="background: <?php echo $filter=='completed'?'#10b981':'#f8fafc'; ?>; color: <?php echo $filter=='completed'?'white':'#64748b'; ?>; text-decoration: none; padding: 8px 15px; border-radius: 8px; border: 1px solid #e2e8f0;">تم الملء</a>
                    <a href="view_stats.php?filter=all" class="btn" style="background: <?php echo $filter=='all'?'#2563eb':'#f8fafc'; ?>; color: <?php echo $filter=='all'?'white':'#64748b'; ?>; text-decoration: none; padding: 8px 15px; border-radius: 8px; border: 1px solid #e2e8f0;">الكل</a>
                </div>
            </div>

            <!-- نظام الفلترة الهرمي المطور -->
            <div class="filter-section">
                <h3><i class="fas fa-filter"></i> نظام البحث والفلترة المتقدم</h3>
                <div class="filter-row">
                    <div class="filter-item">
                        <label>بحث بالاسم</label>
                        <input type="text" id="statSearch" placeholder="ابحث عن إحصائية..." onkeyup="applyFilters()">
                    </div>
                    <div class="filter-item">
                        <label>نوع الإحصائية</label>
                        <select id="typeFilter" onchange="applyFilters()">
                            <option value="all">الكل</option>
                            <option value="monthly">شهري</option>
                            <option value="six_months">سداسي</option>
                            <option value="yearly">سنوي</option>
                            <option value="file_exchange">تبادل ملفات</option>
                        </select>
                    </div>
                </div>
                
                <div class="filter-row">
                    <div class="filter-item">
                        <label>الإحصائية الرئيسية</label>
                        <select id="stat_level_1" onchange="loadSubStats(this.value, 2)">
                            <option value="">الكل</option>
                        </select>
                    </div>
                    <div class="filter-item">
                        <label>الإحصائية الفرعية</label>
                        <select id="stat_level_2" onchange="loadSubStats(this.value, 3)" disabled>
                            <option value="">الكل</option>
                        </select>
                    </div>
                    <div class="filter-item">
                        <label>إحصائية التفاصيل</label>
                        <select id="stat_level_3" onchange="applyFilters()" disabled>
                            <option value="">الكل</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="stat-grid" id="statsList" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px;">
                <?php if(empty($stats)): ?>
                    <div class="card" style="grid-column: 1/-1; text-align: center; padding: 50px;">
                        <i class="fas fa-clipboard-check fa-4x" style="color: #e2e8f0; margin-bottom: 20px;"></i>
                        <p style="color: #94a3b8;">لا توجد إحصائيات تطابق خيارات البحث.</p>
                    </div>
                <?php else: ?>
                    <?php foreach ($stats as $stat): 
                        $is_done = false;
                        try {
                            $stmt = $pdo->prepare("SELECT COUNT(*) FROM `{$stat['table_name']}` WHERE user_id = ?");
                            $stmt->execute([$user_id]);
                            $is_done = ($stmt->fetchColumn() > 0);
                        } catch (PDOException $e) { $is_done = false; }
                        
                        $isSelected = ($selected_id == $stat['id']);
                    ?>
                    <div class="card stat-card <?php echo $isSelected ? 'selected' : ''; ?>" 
                         data-type="<?php echo $stat['stat_type']; ?>" 
                         data-id="<?php echo $stat['id']; ?>"
                         data-parent="<?php echo $stat['parent_stat_id'] ?? '0'; ?>">
                        <div>
                            <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                                <i class="fas <?php echo $stat['stat_type'] == 'file_exchange' ? 'fa-folder-open' : 'fa-table'; ?> fa-2x" style="color: #2563eb;"></i>
                                <span class="badge-type type-<?php echo $stat['stat_type']; ?>">
                                    <?php 
                                        if($stat['stat_type'] == 'monthly') echo 'شهري';
                                        elseif($stat['stat_type'] == 'six_months') echo 'سداسي';
                                        elseif($stat['stat_type'] == 'yearly') echo 'سنوي';
                                        else echo 'تبادل ملفات';
                                    ?>
                                </span>
                            </div>
                            <h3 style="margin: 15px 0 5px 0;"><?php echo htmlspecialchars($stat['stat_name']); ?></h3>
                            <?php if($is_done): ?>
                                <span class="completed-badge"><i class="fas fa-check-circle"></i> تم الإرسال</span>
                            <?php else: ?>
                                <span class="pending-badge"><i class="fas fa-clock"></i> بانتظار الملء</span>
                            <?php endif; ?>
                            <p style="color: #64748b; font-size: 0.85em; margin-top: 10px;">بواسطة: <?php echo htmlspecialchars($stat['creator_name']); ?></p>
                        </div>
                        
                        <div class="action-btns">
                            <?php if($stat['stat_type'] == 'file_exchange'): ?>
                                <a href="file_stats.php" class="btn btn-sm" style="background: #2563eb; color: white; text-align: center; text-decoration: none; border-radius: 5px; padding: 8px; grid-column: 1/-1;"><i class="fas fa-upload"></i> دخول لتبادل الملفات</a>
                            <?php else: ?>
                                <?php if($role_level >= 3): ?>
                                    <a href="fill_stat.php?id=<?php echo $stat['id']; ?>" class="btn btn-sm" style="background: <?php echo $is_done?'#10b981':'#2563eb'; ?>; color: white; text-align: center; text-decoration: none; border-radius: 5px; padding: 8px;"><i class="fas fa-edit"></i> <?php echo $is_done?'تعديل':'تعبئة'; ?></a>
                                <?php endif; ?>
                                <a href="view_stat_data.php?id=<?php echo $stat['id']; ?>" class="btn btn-sm" style="background: #e2e8f0; color: #475569; text-align: center; text-decoration: none; border-radius: 5px; padding: 8px; <?php echo ($role_level < 3)?'grid-column: 1/-1':''; ?>"><i class="fas fa-eye"></i> عرض البيانات</a>
                            <?php endif; ?>
                        </div>
                    </div>
                    <?php endforeach; ?>
                <?php endif; ?>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            loadRootStats();
        });

        function loadRootStats() {
            $.get('api/smart_filter.php', { action: 'get_root_stats' }, function(data) {
                let html = '<option value="">الكل</option>';
                data.forEach(s => html += `<option value="${s.id}">${s.stat_name}</option>`);
                $('#stat_level_1').html(html);
            });
        }

        function loadSubStats(parentId, level) {
            if (!parentId) {
                resetStatLevels(level);
                applyFilters();
                return;
            }
            $.get('api/smart_filter.php', { action: 'get_child_stats', parent_id: parentId }, function(data) {
                let html = '<option value="">الكل</option>';
                if (data.length > 0) {
                    data.forEach(s => html += `<option value="${s.id}">${s.stat_name}</option>`);
                    $(`#stat_level_${level}`).html(html).prop('disabled', false);
                } else {
                    $(`#stat_level_${level}`).html('<option value="">لا توجد فروع</option>').prop('disabled', true);
                }
                applyFilters();
            });
        }

        function resetStatLevels(level) {
            for (let i = level; i <= 3; i++) {
                $(`#stat_level_${i}`).html('<option value="">الكل</option>').prop('disabled', true);
            }
        }

        function applyFilters() {
            const search = $('#statSearch').val().toLowerCase();
            const type = $('#typeFilter').val();
            const statId1 = $('#stat_level_1').val();
            const statId2 = $('#stat_level_2').val();
            const statId3 = $('#stat_level_3').val();
            
            const activeStatId = statId3 || statId2 || statId1;

            $('.stat-card').each(function() {
                const title = $(this).find('h3').text().toLowerCase();
                const statType = $(this).data('type');
                const currentId = $(this).data('id');
                const parentId = $(this).data('parent');

                const matchesSearch = title.includes(search);
                const matchesType = (type === 'all' || statType === type);
                
                let matchesHierarchy = true;
                if (activeStatId) {
                    // إذا تم اختيار إحصائية هرمية، نظهرها هي وأبناءها
                    // للتبسيط في العرض، سنظهر الإحصائية المختارة فقط أو التي تنتمي لهذا الفرع
                    matchesHierarchy = (currentId == activeStatId || parentId == activeStatId);
                }

                if (matchesSearch && matchesType && matchesHierarchy) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
    </script>
</body>
</html>
