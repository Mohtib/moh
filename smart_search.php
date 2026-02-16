<?php
session_start();
require_once 'config/db.php';
require_once 'includes/Stat.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$query = $_GET['q'] ?? '';
$results = [];

if ($query) {
    $statObj = new Stat($pdo);
    // 1. البحث في تعريفات الإحصائيات
    $stmt = $pdo->prepare("SELECT * FROM stat_definitions WHERE stat_name LIKE ?");
    $stmt->execute(['%' . $query . '%']);
    $results['stats'] = $stmt->fetchAll();

    // 2. البحث في المستخدمين (للمدراء)
    if ($_SESSION['role_level'] <= 2) {
        $stmtU = $pdo->prepare("SELECT id, full_name, email FROM users WHERE full_name LIKE ? OR email LIKE ?");
        $stmtU->execute(['%' . $query . '%', '%' . $query . '%']);
        $results['users'] = $stmtU->fetchAll();
    }
}

?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>البحث الذكي | جامعة ميلة</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .search-box { width: 100%; padding: 20px; font-size: 1.2rem; border-radius: 15px; border: 2px solid #e2e8f0; margin-bottom: 30px; transition: all 0.3s; }
        .search-box:focus { border-color: #2563eb; outline: none; box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1); }
        .result-section { margin-bottom: 40px; }
        .result-item { background: white; padding: 15px; border-radius: 10px; margin-bottom: 10px; display: flex; align-items: center; gap: 15px; border: 1px solid #f1f5f9; transition: transform 0.2s; text-decoration: none; color: inherit; }
        .result-item:hover { transform: translateX(-5px); border-color: #2563eb; }
        .icon-circle { width: 40px; height: 40px; border-radius: 50%; background: #f1f5f9; display: flex; align-items: center; justify-content: center; color: #2563eb; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        <div class="main-content">
            <form method="GET">
                <input type="text" name="q" value="<?php echo htmlspecialchars($query); ?>" class="search-box" placeholder="ابحث عن إحصائية، مستخدم، أو ملف..." autofocus>
            </form>

            <?php if (!$query): ?>
                <div style="text-align: center; padding: 100px 0; color: #94a3b8;">
                    <i class="fas fa-search fa-4x" style="margin-bottom: 20px;"></i>
                    <h3>ابدأ الكتابة للبحث في كافة أرجاء النظام</h3>
                </div>
            <?php else: ?>
                <div class="results-container">
                    <?php if (!empty($results['stats'])): ?>
                        <div class="result-section">
                            <h3><i class="fas fa-table"></i> الإحصائيات (<?php echo count($results['stats']); ?>)</h3>
                            <?php foreach ($results['stats'] as $s): ?>
                                <a href="fill_stat.php?id=<?php echo $s['id']; ?>" class="result-item">
                                    <div class="icon-circle"><i class="fas fa-file-alt"></i></div>
                                    <div>
                                        <div style="font-weight: bold;"><?php echo htmlspecialchars($s['stat_name']); ?></div>
                                        <div style="font-size: 0.8rem; color: #64748b;">نوع: <?php echo $s['stat_type']; ?> | أنشئت في: <?php echo $s['created_at']; ?></div>
                                    </div>
                                </a>
                            <?php endforeach; ?>
                        </div>
                    <?php endif; ?>

                    <?php if (!empty($results['users'])): ?>
                        <div class="result-section">
                            <h3><i class="fas fa-users"></i> المستخدمين (<?php echo count($results['users']); ?>)</h3>
                            <?php foreach ($results['users'] as $u): ?>
                                <a href="manage_users.php?search=<?php echo $u['id']; ?>" class="result-item">
                                    <div class="icon-circle"><i class="fas fa-user"></i></div>
                                    <div>
                                        <div style="font-weight: bold;"><?php echo htmlspecialchars($u['full_name']); ?></div>
                                        <div style="font-size: 0.8rem; color: #64748b;"><?php echo htmlspecialchars($u['email']); ?></div>
                                    </div>
                                </a>
                            <?php endforeach; ?>
                        </div>
                    <?php endif; ?>

                    <?php if (empty($results['stats']) && empty($results['users'])): ?>
                        <div style="text-align: center; padding: 50px; color: #94a3b8;">
                            <p>لا توجد نتائج تطابق "<?php echo htmlspecialchars($query); ?>"</p>
                        </div>
                    <?php endif; ?>
                </div>
            <?php endif; ?>
        </div>
    </div>
</body>
</html>
