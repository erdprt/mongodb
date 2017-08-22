DROP INDEX db_order_item_id_index;
DROP INDEX db_order_item_order_id_index;
DROP INDEX db_order_item_product_ean_code_index;
ALTER TABLE db_order_item DROP CONSTRAINT db_order_item_order_id_db_order_id_fk;
ALTER TABLE db_order_item DROP CONSTRAINT db_order_item_product_ean_code_db_product_ean_code_fk;
ALTER TABLE db_order_item DROP CONSTRAINT db_order_item_pk;
DROP SEQUENCE db_order_item_id_sequence;

DROP INDEX db_order_id_index;
ALTER TABLE db_order DROP CONSTRAINT db_order_customer_id_db_customer_customer_id_fk;
ALTER TABLE db_order  DROP CONSTRAINT db_order_pk;
DROP SEQUENCE db_order_id_sequence;

DROP INDEX db_customer_id_index;
ALTER TABLE db_customer DROP CONSTRAINT db_customer_id_db_user_id_fk;
ALTER TABLE db_customer DROP CONSTRAINT db_customer_pk;

DROP INDEX db_user_id_index;
ALTER TABLE db_user DROP CONSTRAINT db_user_role_id_db_role_name_fk;
ALTER TABLE db_user DROP CONSTRAINT db_user_pk;
DROP SEQUENCE db_user_id_sequence; 

DROP INDEX db_role_name_index;
ALTER TABLE db_role DROP CONSTRAINT db_role_pk;

DROP INDEX db_product_ean_code_index;
DROP INDEX  db_product_category_id_index;
ALTER TABLE db_product DROP CONSTRAINT db_product_category_id_db_category_id_fk;
ALTER TABLE db_product DROP CONSTRAINT db_product_pk;

DROP INDEX db_category_id_index;
ALTER TABLE db_category DROP CONSTRAINT db_category_parent_id_db_category_id_fk;
ALTER TABLE db_category DROP CONSTRAINT db_category_pk;