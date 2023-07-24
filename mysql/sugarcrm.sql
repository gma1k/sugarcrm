DROP DATABASE IF EXISTS $DBNAME;
CREATE DATABASE $DBNAME CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE $DBNAME;
SET GLOBAL innodb_log_file_size = 2048 * 1024 * 1024;
-- Add more commands to create tables, indexes, etc. for sugarcrm
