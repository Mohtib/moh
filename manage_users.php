<?php
session_start();
require_once 'config/db.php';
require_once 'includes/User.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role_level'] >= 4) {
    header("Location: dashboard.php");
    exit();
}

$userObj = new User($pdo);
$is_admin = ($_SESSION['role_level'] == 1);
$subordinates = $userObj->getSubordinates($_SESSION['user_id'], $is_admin);

$next_role = $_SESSION['role_level'] + 1;
$role_label = "";
switch($next_role) {
    case 2: $role_label = "نائب مدير / مسؤول مركزي"; break;
    case 3: $role_label = "عميد كلية / مدير"; break;
    case 4: $role_label = "رئيس قسم"; break;
}
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>إدارة المستخدمين | نظام الإحصائيات</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .modal { display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:2000; }
        .modal-content { background:white; width:450px; margin:100px auto; padding:30px; border-radius:15px; position: relative; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1); }
        .close-modal { position: absolute; top: 15px; left: 15px; cursor: pointer; font-size: 20px; color: #64748b; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 600; color: #1e293b; }
        .form-group input { width: 100%; padding: 12px; border: 1px solid #e2e8f0; border-radius: 8px; }
        .badge { padding: 4px 10px; border-radius: 20px; font-size: 0.75em; font-weight: bold; }
        .badge-1 { background: #fee2e2; color: #ef4444; }
        .badge-2 { background: #fef3c7; color: #d97706; }
        .badge-3 { background: #dcfce7; color: #16a34a; }
        .badge-4 { background: #dbeafe; color: #2563eb; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 12px; overflow: hidden; }
        th, td { padding: 15px; text-align: right; border-bottom: 1px solid #f1f5f9; }
        th { background: #f8fafc; color: #64748b; font-weight: 700; }
        .btn-action { padding: 6px 10px; border-radius: 6px; border: none; cursor: pointer; transition: 0.2s; }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <?php include 'includes/sidebar.php'; ?>

        <div class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
                <div>
                    <h2><i class="fas fa-users"></i> إدارة المستخدمين</h2>
                    <p style="color: #64748b;">إدارة الحسابات التابعة لك في الهيكل التنظيمي.</p>
                </div>
                <button class="btn" style="background: #2563eb; color: white; padding: 10px 20px; border-radius: 8px; border: none; cursor: pointer; font-weight: bold;" onclick="$('#addUserModal').show()">
                    <i class="fas fa-plus"></i> إضافة <?php echo $role_label; ?>
                </button>
            </div>

            <div class="card" style="margin-bottom: 20px; border-right: 4px solid #2563eb;">
                <div style="display: flex; gap: 15px; align-items: center;">
                    <div style="flex: 1;">
                        <label style="font-size: 0.85rem; font-weight: 600; color: #64748b;">بحث سريع عن مستخدم</label>
                        <div style="position: relative; margin-top: 5px;">
                            <i class="fas fa-search" style="position: absolute; right: 12px; top: 12px; color: #94a3b8;"></i>
                            <input type="text" id="userSearch" style="width: 100%; padding: 10px 35px 10px 10px; border: 1px solid #e2e8f0; border-radius: 8px;" placeholder="ابحث بالاسم أو اسم المستخدم...">
                        </div>
                    </div>
                    <div style="width: 200px;">
                        <label style="font-size: 0.85rem; font-weight: 600; color: #64748b;">تصفية حسب الرتبة</label>
                        <select id="roleFilter" style="width: 100%; padding: 10px; border: 1px solid #e2e8f0; border-radius: 8px; margin-top: 5px;">
                            <option value="">الكل</option>
                            <option value="2">مسؤول مركزي</option>
                            <option value="3">عميد كلية</option>
                            <option value="4">رئيس قسم</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="card" style="padding: 0; overflow: hidden; border: 1px solid #e2e8f0;">
                <table>
                    <thead>
                        <tr>
                            <th>الاسم الكامل</th>
                            <th>اسم المستخدم</th>
                            <th>الرتبة</th>
                            <th>الإجراءات</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if(empty($subordinates)): ?>
                            <tr>
                                <td colspan="4" style="text-align: center; padding: 40px; color: #94a3b8;">لا يوجد مستخدمون تابعون حالياً.</td>
                            </tr>
                        <?php else: ?>
                            <?php foreach ($subordinates as $sub): ?>
                            <tr class="user-row" data-name="<?php echo htmlspecialchars($sub['full_name']); ?>" data-username="<?php echo htmlspecialchars($sub['username']); ?>" data-role="<?php echo $sub['role_level']; ?>">
                                <td><strong><?php echo htmlspecialchars($sub['full_name']); ?></strong></td>
                                <td><code><?php echo htmlspecialchars($sub['username']); ?></code></td>
                                <td>
                                    <span class="badge badge-<?php echo $sub['role_level']; ?>">
                                        <?php 
                                            switch($sub['role_level']) {
                                                case 1: echo "مدير الجامعة"; break;
                                                case 2: echo "مسؤول مركزي"; break;
                                                case 3: echo "عميد كلية"; break;
                                                case 4: echo "رئيس قسم"; break;
                                            }
                                        ?>
                                    </span>
                                </td>
                                <td>
                                    <button class="btn-action" style="background: #eff6ff; color: #2563eb;" onclick="editUser(<?php echo htmlspecialchars(json_encode($sub)); ?>)" title="تعديل"><i class="fas fa-edit"></i></button>
                                    <button class="btn-action" style="background: #fffbeb; color: #d97706;" onclick="resetPass(<?php echo $sub['id']; ?>)" title="إعادة تعيين كلمة المرور"><i class="fas fa-key"></i></button>
                                    <button class="btn-action" style="background: #fef2f2; color: #ef4444;" onclick="deleteUser(<?php echo $sub['id']; ?>)" title="حذف"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add User Modal -->
    <div id="addUserModal" class="modal">
        <div class="modal-content">
            <span class="close-modal" onclick="$('#addUserModal').hide()">&times;</span>
            <h3 style="margin-bottom: 20px;">إضافة مستخدم جديد</h3>
            <form id="addUserForm">
                <input type="hidden" name="role_level" value="<?php echo $next_role; ?>">
                <input type="hidden" name="parent_id" value="<?php echo $_SESSION['user_id']; ?>">
                <div class="form-group">
                    <label>الاسم الكامل</label>
                    <input type="text" name="full_name" required placeholder="مثلاً: د. أحمد محمد">
                </div>
                <div class="form-group">
                    <label>اسم المستخدم</label>
                    <input type="text" name="username" required placeholder="اسم الدخول">
                </div>
                <div class="form-group">
                    <label>كلمة المرور</label>
                    <input type="password" name="password" required placeholder="********">
                </div>
                <button type="submit" class="btn" style="width:100%; background: #2563eb; color: white; padding: 12px; border: none; border-radius: 8px; font-weight: bold; cursor: pointer; margin-top: 10px;">حفظ البيانات</button>
            </form>
        </div>
    </div>

    <!-- Edit User Modal -->
    <div id="editUserModal" class="modal">
        <div class="modal-content">
            <span class="close-modal" onclick="$('#editUserModal').hide()">&times;</span>
            <h3 style="margin-bottom: 20px;">تعديل بيانات المستخدم</h3>
            <form id="editUserForm">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" id="edit_id">
                <div class="form-group">
                    <label>الاسم الكامل</label>
                    <input type="text" name="full_name" id="edit_full_name" required>
                </div>
                <div class="form-group">
                    <label>اسم المستخدم</label>
                    <input type="text" name="username" id="edit_username" required>
                </div>
                <button type="submit" class="btn" style="width:100%; background: #2563eb; color: white; padding: 12px; border: none; border-radius: 8px; font-weight: bold; cursor: pointer; margin-top: 10px;">تحديث البيانات</button>
            </form>
        </div>
    </div>

    <!-- Reset Password Modal -->
    <div id="resetPassModal" class="modal">
        <div class="modal-content">
            <span class="close-modal" onclick="$('#resetPassModal').hide()">&times;</span>
            <h3 style="margin-bottom: 20px;">إعادة تعيين كلمة المرور</h3>
            <form id="resetPassForm">
                <input type="hidden" name="action" value="reset_password">
                <input type="hidden" name="id" id="reset_id">
                <div class="form-group">
                    <label>كلمة المرور الجديدة</label>
                    <input type="password" name="password" required placeholder="أدخل كلمة المرور الجديدة">
                </div>
                <button type="submit" class="btn" style="width:100%; background: #d97706; color: white; padding: 12px; border: none; border-radius: 8px; font-weight: bold; cursor: pointer; margin-top: 10px;">تغيير كلمة المرور</button>
            </form>
        </div>
    </div>

    <script>
        $('#addUserForm').on('submit', function(e) {
            e.preventDefault();
            $.ajax({
                url: 'api/add_user.php',
                method: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    location.reload();
                }
            });
        });

        function editUser(user) {
            $('#edit_id').val(user.id);
            $('#edit_full_name').val(user.full_name);
            $('#edit_username').val(user.username);
            $('#editUserModal').show();
        }

        $('#editUserForm').on('submit', function(e) {
            e.preventDefault();
            $.ajax({
                url: 'api/user_actions.php',
                method: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    const res = JSON.parse(response);
                    if(res.success) location.reload();
                    else alert(res.message);
                }
            });
        });

        function resetPass(id) {
            $('#reset_id').val(id);
            $('#resetPassModal').show();
        }

        $('#resetPassForm').on('submit', function(e) {
            e.preventDefault();
            $.ajax({
                url: 'api/user_actions.php',
                method: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    const res = JSON.parse(response);
                    if(res.success) {
                        alert('تم تغيير كلمة المرور بنجاح');
                        $('#resetPassModal').hide();
                    } else alert(res.message);
                }
            });
        });

        function deleteUser(id) {
            if(confirm('هل أنت متأكد من حذف هذا المستخدم؟ لا يمكن التراجع عن هذا الإجراء.')) {
                $.ajax({
                    url: 'api/user_actions.php',
                    method: 'POST',
                    data: { action: 'delete', id: id },
                    success: function(response) {
                        const res = JSON.parse(response);
                        if(res.success) location.reload();
                        else alert(res.message);
                    }
                });
            }
        }

        // Search and Filter Logic
        $('#userSearch, #roleFilter').on('input change', function() {
            const searchVal = $('#userSearch').val().toLowerCase();
            const roleVal = $('#roleFilter').val();

            $('.user-row').each(function() {
                const name = $(this).data('name').toLowerCase();
                const username = $(this).data('username').toLowerCase();
                const role = $(this).data('role').toString();

                const matchesSearch = name.includes(searchVal) || username.includes(searchVal);
                const matchesRole = !roleVal || role === roleVal;

                $(this).toggle(matchesSearch && matchesRole);
            });
        });
    </script>
</body>
</html>
