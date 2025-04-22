-- --------------------------------------------------
--  mws & marketing
-- --------------------------------------------------
ALTER TABLE merchants ADD COLUMN bucket_name VARCHAR(255) NOT NULL COMMENT 'S3存储桶名称';

update merchants set bucket_name = 'unionftech-dev' where merchants_num = 10;
update merchants set bucket_name = 'unionftech-test' where merchants_num = 1;
update merchants set bucket_name = 'unionftech-test2' where merchants_num = 11;
update merchants set bucket_name = 'unionftech-test3' where merchants_num = 12;

