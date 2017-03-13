CREATE DATABASE IF NOT EXISTS nakkikone_development;
CREATE DATABASE IF NOT EXISTS nakkikone_test;

CREATE USER 'nakki'@'%' IDENTIFIED BY 'nakki';
GRANT ALL ON nakkikone_development.* TO 'nakki'@'%';
GRANT ALL ON nakkikone_test.* TO 'nakki'@'%';
FLUSH PRIVILEGES;
