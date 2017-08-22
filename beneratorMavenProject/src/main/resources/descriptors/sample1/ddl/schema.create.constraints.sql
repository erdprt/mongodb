-- intialisation pour creer les tables dans le schema désiré: en premiere position dans le cas present
SET search_path TO sample1,public;

ALTER TABLE customer ADD CONSTRAINT customer_customer_id_pkey PRIMARY KEY (customer_id);
CREATE SEQUENCE customer_customer_id_seq START 1 INCREMENT BY 1 OWNED BY customer.customer_id;

ALTER TABLE item ADD CONSTRAINT item_item_id_pkey PRIMARY KEY (item_id);
CREATE SEQUENCE item_item_id_seq START 1 INCREMENT BY 1 OWNED BY item.item_id;

ALTER TABLE orderinfo ADD CONSTRAINT orderinfo_orderinfo_id_pkey PRIMARY KEY (orderinfo_id);
ALTER TABLE orderinfo ADD CONSTRAINT orderinfo_customer_id_customer_id_fk FOREIGN KEY (customer_id) REFERENCES customer (customer_id);
CREATE SEQUENCE orderinfo_orderinfo_id_seq START 1 INCREMENT BY 1 OWNED BY orderinfo.orderinfo_id;

ALTER TABLE stock ADD CONSTRAINT stock_item_id_pkey PRIMARY KEY (item_id);
ALTER TABLE stock ADD CONSTRAINT stock_item_id_item_id_fk FOREIGN KEY (item_id) REFERENCES item (item_id);

ALTER TABLE orderline ADD CONSTRAINT orderline_orderinfo_id_item_id_pkey PRIMARY KEY (orderinfo_id, item_id);
ALTER TABLE orderline ADD CONSTRAINT orderline_orderinfo_id_orderinfo_id_fk FOREIGN KEY (orderinfo_id) REFERENCES orderinfo (orderinfo_id);
ALTER TABLE orderline ADD CONSTRAINT orderline_item_id_item_id_fk FOREIGN KEY (item_id) REFERENCES item (item_id);

ALTER TABLE barcode ADD CONSTRAINT barcode_barcode_ean_pkey PRIMARY KEY (barcode_ean);
ALTER TABLE barcode ADD CONSTRAINT barcode_item_id_item_id_fk FOREIGN KEY (item_id) REFERENCES item (item_id);