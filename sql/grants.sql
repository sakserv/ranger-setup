GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY 'hadoop';
GRANT ALL ON *.* TO 'rangeradmin'@'localhost' IDENTIFIED BY 'hadoop';
GRANT ALL ON *.* TO 'rangerlogger'@'localhost' IDENTIFIED BY 'hadoop';
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'hadoop';
GRANT ALL ON *.* TO 'rangeradmin'@'%' IDENTIFIED BY 'hadoop';
GRANT ALL ON *.* TO 'rangerlogger'@'%' IDENTIFIED BY 'hadoop';
flush privileges;