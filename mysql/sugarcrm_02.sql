CREATE DATABASE sugarcrm;
GRANT ALL ON sugarcrm.* TO 'sugaruser'@'localhost' IDENTIFIED BY 'sugarpass';
SET GLOBAL innodb_file_format=Barracuda;
SET GLOBAL innodb_large_prefix=1;
SET GLOBAL innodb_file_per_table=1;
