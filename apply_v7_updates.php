<?php
require_once 'config/db.php';

$sql_file = 'update_v7_messages_stats.sql';
if (!file_exists($sql_file)) {
    die("SQL file not found.");
}

$sql = file_get_contents($sql_file);

try {
    // Split the SQL into individual queries
    $queries = explode(';', $sql);
    foreach ($queries as $query) {
        $query = trim($query);
        if (!empty($query)) {
            $pdo->exec($query);
            echo "Executed: " . substr($query, 0, 50) . "...\n";
        }
    }
    echo "Database updated successfully.\n";
} catch (PDOException $e) {
    echo "Error during update: " . $e->getMessage() . "\n";
}
?>
