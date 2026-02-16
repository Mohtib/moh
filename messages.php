<?php
session_start();
require_once 'config/db.php';
require_once 'includes/User.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$user_id = $_SESSION['user_id'];
$role_level = (int)$_SESSION['role_level'];
$folder = $_GET['folder'] ?? 'inbox';

// جلب جهات الاتصال (الرئيس، التابعين، المدير، الزملاء)
$stmt = $pdo->prepare("
    SELECT id, full_name, role_level 
    FROM users 
    WHERE (parent_id = (SELECT parent_id FROM users WHERE id = ?) AND id != ?) -- الزملاء
    OR id = (SELECT parent_id FROM users WHERE id = ?) -- الرئيس
    OR parent_id = ? -- المرؤوسين المباشرين
    OR role_level = 1 -- المدير العام
    OR id = 1 -- المدير العام دائما متاح
");
$stmt->execute([$user_id, $user_id, $user_id, $user_id]);
$contacts = $stmt->fetchAll();

// استخراج قائمة المعرفات المسموح بها للمستلمين (للتحقق)
$allowed_ids = array_column($contacts, 'id');

// معالجة إرسال رسالة
$success_msg = "";
$error_msg = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['send_message'])) {
    $receiver_id = (int)$_POST['receiver_id'];
    $subject = trim($_POST['subject']);
    $message_text = trim($_POST['message']);
    
    // التحقق من أن المستقبل ضمن جهات الاتصال المسموحة
    if (!in_array($receiver_id, $allowed_ids)) {
        $error_msg = "المستلم غير مسموح به.";
    } elseif (empty($subject) || empty($message_text)) {
        $error_msg = "يرجى ملء جميع الحقول المطلوبة.";
    } else {
        $pdo->beginTransaction();
        try {
            $stmt = $pdo->prepare("INSERT INTO messages (sender_id, receiver_id, subject, message) VALUES (?, ?, ?, ?)");
            $stmt->execute([$user_id, $receiver_id, $subject, $message_text]);
            $message_id = $pdo->lastInsertId();

            if (!empty($_FILES['attachments']['name'][0])) {
                $upload_dir = 'uploads/messages/';
                if (!is_dir($upload_dir)) mkdir($upload_dir, 0777, true);

                $allowed_exts = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'jpg', 'jpeg', 'png', 'gif'];
                $allowed_mimes = [
                    'application/pdf',
                    'application/msword',
                    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                    'application/vnd.ms-excel',
                    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                    'image/jpeg',
                    'image/png',
                    'image/gif'
                ];

                foreach ($_FILES['attachments']['name'] as $key => $name) {
                    if ($_FILES['attachments']['error'][$key] !== UPLOAD_ERR_OK) continue;
                    
                    $tmp_name = $_FILES['attachments']['tmp_name'][$key];
                    $ext = strtolower(pathinfo($name, PATHINFO_EXTENSION));
                    $mime = mime_content_type($tmp_name);
                    
                    if (!in_array($ext, $allowed_exts) || !in_array($mime, $allowed_mimes)) {
                        continue; // تجاهل الملف غير المسموح
                    }
                    
                    $file_name = time() . '_' . rand(100,999) . '_' . preg_replace("/[^a-zA-Z0-9.]/", "_", $name);
                    $file_path = $upload_dir . $file_name;
                    
                    if (move_uploaded_file($tmp_name, $file_path)) {
                        $stmtAtt = $pdo->prepare("INSERT INTO message_attachments (message_id, file_path, file_name) VALUES (?, ?, ?)");
                        $stmtAtt->execute([$message_id, $file_path, $name]);
                    }
                }
            }
            
            $pdo->commit();
            $success_msg = "تم إرسال الرسالة بنجاح.";
        } catch (Exception $e) {
            $pdo->rollBack();
            $error_msg = "خطأ في الإرسال: " . $e->getMessage();
        }
    }
}

// جلب الرسائل بناءً على المجلد
if ($folder == 'sent') {
    $stmt = $pdo->prepare("
        SELECT m.*, u.full_name as other_name 
        FROM messages m 
        JOIN users u ON m.receiver_id = u.id 
        WHERE m.sender_id = ? 
        ORDER BY m.created_at DESC
    ");
} else {
    $stmt = $pdo->prepare("
        SELECT m.*, u.full_name as other_name 
        FROM messages m 
        JOIN users u ON m.sender_id = u.id 
        WHERE m.receiver_id = ? 
        ORDER BY m.created_at DESC
    ");
}
$stmt->execute([$user_id]);
$messages = $stmt->fetchAll();

// جلب تفاصيل رسالة عبر AJAX (محاكاة هنا للتبسيط)
if (isset($_GET['ajax_view_id'])) {
    $msg_id = $_GET['ajax_view_id'];
    
    // تحديث كـ مقروءة
    $pdo->prepare("UPDATE messages SET is_read = 1 WHERE id = ? AND receiver_id = ?")->execute([$msg_id, $user_id]);
    
    $stmt = $pdo->prepare("SELECT m.*, u.full_name as sender_name FROM messages m JOIN users u ON m.sender_id = u.id WHERE m.id = ?");
    $stmt->execute([$msg_id]);
    $msg = $stmt->fetch();
    
    $stmtAtt = $pdo->prepare("SELECT * FROM message_attachments WHERE message_id = ?");
    $stmtAtt->execute([$msg_id]);
    $attachments = $stmtAtt->fetchAll();
    
    echo json_encode(['message' => $msg, 'attachments' => $attachments]);
    exit;
}
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>المراسلات | جامعة ميلة</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .messages-layout { display: grid; grid-template-columns: 350px 1fr; gap: 20px; margin-top: 20px; height: calc(100vh - 150px); }
        .card-list { overflow-y: auto; padding: 0; }
        .message-item { padding: 15px; border-bottom: 1px solid #f1f5f9; cursor: pointer; transition: background 0.2s; }
        .message-item:hover { background: #f8fafc; }
        .message-item.active { background: #eff6ff; border-right: 4px solid #2563eb; }
        .message-item.unread { font-weight: bold; background: #fff; }
        .message-detail-view { padding: 30px; display: none; }
        .attachment-item { display: flex; align-items: center; gap: 10px; padding: 10px; background: #f8fafc; border-radius: 8px; margin-top: 10px; text-decoration: none; color: #1e293b; border: 1px solid #e2e8f0; }
        .attachment-item:hover { background: #f1f5f9; }
        .btn-compose { width: 100%; padding: 12px; background: #2563eb; color: white; border: none; border-radius: 8px; font-weight: bold; cursor: pointer; margin-bottom: 15px; }
        .alert-success { background: #d1fae5; color: #065f46; padding: 15px; border-radius: 8px; margin-bottom: 20px; border-right: 4px solid #10b981; }
        .alert-danger { background: #fee2e2; color: #991b1b; padding: 15px; border-radius: 8px; margin-bottom: 20px; border-right: 4px solid #ef4444; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>
        <div class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div style="display: flex; gap: 10px; align-items: center;">
                    <a href="messages.php?folder=inbox" class="btn <?php echo $folder == 'inbox' ? 'btn-primary' : ''; ?>" style="background: <?php echo $folder == 'inbox' ? '#2563eb' : '#94a3b8'; ?>; color: white; text-decoration: none;">
                        <i class="fas fa-inbox"></i> الرسائل الواردة
                    </a>
                    <a href="messages.php?folder=sent" class="btn <?php echo $folder == 'sent' ? 'btn-primary' : ''; ?>" style="background: <?php echo $folder == 'sent' ? '#2563eb' : '#94a3b8'; ?>; color: white; text-decoration: none;">
                        <i class="fas fa-paper-plane"></i> الرسائل الصادرة
                    </a>
                </div>
                <button class="btn" style="background: #10b981; color: white;" onclick="$('#composeModal').fadeIn()">+ إنشاء رسالة</button>
            </div>

            <?php if($success_msg): ?>
                <div class="alert-success" style="margin-top: 15px;"><?php echo $success_msg; ?></div>
            <?php endif; ?>
            <?php if($error_msg): ?>
                <div class="alert-danger" style="margin-top: 15px;"><?php echo $error_msg; ?></div>
            <?php endif; ?>

            <div class="messages-layout">
                <div class="card card-list">
                    <?php if(empty($messages)): ?>
                        <p style="text-align: center; padding: 40px; color: #94a3b8;">لا توجد رسائل.</p>
                    <?php else: ?>
                        <?php foreach($messages as $msg): ?>
                            <div class="message-item <?php echo ($msg['is_read'] == 0 && $folder == 'inbox') ? 'unread' : ''; ?>" onclick="viewMessage(<?php echo $msg['id']; ?>, this)">
                                <div style="display: flex; justify-content: space-between; margin-bottom: 5px;">
                                    <strong><?php echo htmlspecialchars($msg['other_name']); ?></strong>
                                    <small style="color: #94a3b8;"><?php echo date('m/d', strtotime($msg['created_at'])); ?></small>
                                </div>
                                <div style="font-size: 0.9rem; color: #475569; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                    <?php echo htmlspecialchars($msg['subject']); ?>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </div>
                <div class="card" id="message-detail-container" style="padding: 0;">
                    <div id="no-selection" style="text-align: center; padding: 100px; color: #94a3b8;">
                        <i class="fas fa-envelope-open fa-4x" style="margin-bottom: 20px; opacity: 0.3;"></i>
                        <p>اختر رسالة من القائمة لعرض تفاصيلها</p>
                    </div>
                    <div class="message-detail-view" id="message-view">
                        <div style="display: flex; justify-content: space-between; border-bottom: 1px solid #f1f5f9; padding-bottom: 20px; margin-bottom: 20px;">
                            <div>
                                <h3 id="view-subject" style="margin-bottom: 10px;"></h3>
                                <div style="color: #64748b;">
                                    من: <span id="view-sender" style="font-weight: bold; color: #1e293b;"></span>
                                    <span style="margin: 0 10px;">|</span>
                                    التاريخ: <span id="view-date"></span>
                                </div>
                            </div>
                        </div>
                        <div id="view-body" style="line-height: 1.8; color: #334155; min-height: 200px; white-space: pre-wrap;"></div>
                        
                        <div id="view-attachments" style="margin-top: 30px; border-top: 1px solid #f1f5f9; padding-top: 20px;">
                            <h4 style="margin-bottom: 15px;"><i class="fas fa-paperclip"></i> المرفقات</h4>
                            <div id="attachments-list"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Compose Modal -->
    <div id="composeModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:2000;">
        <div class="card" style="width:600px; margin:50px auto; padding:30px;">
            <div style="display:flex; justify-content:space-between; margin-bottom:20px;">
                <h3>إنشاء رسالة جديدة</h3>
                <button onclick="$('#composeModal').fadeOut()" style="background:none; border:none; font-size:1.5rem; cursor:pointer;">&times;</button>
            </div>
            <form method="POST" enctype="multipart/form-data">
                <div style="margin-bottom:15px;">
                    <label>المرسل إليه:</label>
                    <select name="receiver_id" class="card" style="width:100%; padding:10px;" required>
                        <option value="">اختر المستخدم...</option>
                        <?php foreach($contacts as $c): ?>
                            <option value="<?php echo $c['id']; ?>"><?php echo htmlspecialchars($c['full_name']); ?> (<?php echo $c['role_level']; ?>)</option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div style="margin-bottom:15px;">
                    <label>الموضوع:</label>
                    <input type="text" name="subject" class="card" style="width:100%; padding:10px;" required>
                </div>
                <div style="margin-bottom:15px;">
                    <label>نص الرسالة:</label>
                    <textarea name="message" class="card" style="width:100%; padding:10px;" rows="6" required></textarea>
                </div>
                <div style="margin-bottom:20px;">
                    <label>المرفقات:</label>
                    <input type="file" name="attachments[]" multiple class="card" style="width:100%; padding:10px;">
                </div>
                <button type="submit" name="send_message" class="btn" style="width:100%; background:#2563eb; color:white; padding:12px; display: block !important; visibility: visible !important;">إرسال الرسالة</button>
            </form>
        </div>
    </div>

    <script>
        function viewMessage(id, element) {
            $('.message-item').removeClass('active');
            $(element).addClass('active').removeClass('unread');
            
            $.getJSON('messages.php?ajax_view_id=' + id, function(data) {
                $('#no-selection').hide();
                $('#message-view').fadeIn();
                
                $('#view-subject').text(data.message.subject);
                $('#view-sender').text(data.message.sender_name);
                $('#view-date').text(data.message.created_at);
                $('#view-body').text(data.message.message);
                
                $('#attachments-list').empty();
                if (data.attachments.length > 0) {
                    $('#view-attachments').show();
                    data.attachments.forEach(function(att) {
                        $('#attachments-list').append(`
                            <a href="${att.file_path}" target="_blank" class="attachment-item">
                                <i class="fas fa-file-alt fa-2x" style="color: #2563eb;"></i>
                                <div>
                                    <div style="font-weight: bold;">${att.file_name}</div>
                                    <small style="color: #64748b;">اضغط للعرض أو التحميل</small>
                                </div>
                            </a>
                        `);
                    });
                } else {
                    $('#view-attachments').hide();
                }
            });
        }
    </script>
</body>
</html>