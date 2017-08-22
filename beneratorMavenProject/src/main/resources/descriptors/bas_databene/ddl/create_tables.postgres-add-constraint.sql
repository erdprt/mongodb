CREATE INDEX db_category_id_index ON db_category(id);
ALTER TABLE db_category ADD CONSTRAINT db_category_pk PRIMARY KEY (id);
ALTER TABLE db_category ADD CONSTRAINT db_category_parent_id_db_category_id_fk FOREIGN KEY (parent_id) REFERENCES db_category(id);
 
CREATE INDEX db_product_ean_code_index ON db_product(ean_code);
CREATE INDEX db_product_category_id_index ON db_product(category_id);
ALTER TABLE db_product ADD CONSTRAINT db_product_pk PRIMARY KEY (ean_code);
ALTER TABLE db_product ADD CONSTRAINT db_product_category_id_db_category_id_fk FOREIGN KEY (category_id) REFERENCES db_category(id);

CREATE INDEX db_role_name_index ON db_role(name);
ALTER TABLE db_role ADD CONSTRAINT db_role_pk PRIMARY KEY (name);

CREATE INDEX db_user_id_index ON db_user(id);
ALTER TABLE db_user ADD CONSTRAINT db_user_pk PRIMARY KEY (id);
ALTER TABLE db_user ADD CONSTRAINT db_user_role_id_db_role_name_fk FOREIGN KEY (role_id) REFERENCES db_role(name);
CREATE SEQUENCE db_user_id_sequence START 1 INCREMENT BY 1 OWNED BY db_user.id; 

CREATE INDEX db_customer_id_index ON db_customer(id);
ALTER TABLE db_customer ADD CONSTRAINT db_customer_pk PRIMARY KEY (id);
ALTER TABLE db_customer ADD CONSTRAINT db_customer_id_db_user_id_fk FOREIGN KEY (id) REFERENCES db_user(id);
 
CREATE INDEX db_order_id_index ON db_order(id);
ALTER TABLE db_order ADD CONSTRAINT db_order_pk PRIMARY KEY (id);
ALTER TABLE db_order ADD CONSTRAINT db_order_customer_id_db_customer_customer_id_fk FOREIGN KEY (customer_id) REFERENCES db_customer(id);
CREATE SEQUENCE db_order_id_sequence START 1 INCREMENT BY 1 OWNED BY db_order.id;

CREATE INDEX db_order_item_id_index ON db_order_item(id);
ALTER TABLE db_order_item ADD CONSTRAINT db_order_item_pk PRIMARY KEY (id);
CREATE INDEX db_order_item_order_id_index ON db_order_item(order_id);
CREATE INDEX db_order_item_product_ean_code_index ON db_order_item(product_ean_code);
ALTER TABLE db_order_item ADD CONSTRAINT db_order_item_order_id_db_order_id_fk FOREIGN KEY (order_id) REFERENCES db_order(id);
ALTER TABLE db_order_item ADD CONSTRAINT db_order_item_product_ean_code_db_product_ean_code_fk FOREIGN KEY (product_ean_code) REFERENCES db_product(ean_code);
CREATE SEQUENCE db_order_item_id_sequence START 1 INCREMENT BY 1 OWNED BY db_order_item.id;

