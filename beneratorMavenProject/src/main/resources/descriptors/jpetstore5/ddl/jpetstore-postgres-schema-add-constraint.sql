CREATE INDEX supplier_suppid_index ON supplier(suppid);
CREATE SEQUENCE supplier_suppid_sequence START 1 INCREMENT BY 1 OWNED BY supplier.suppid; 

CREATE INDEX signon_username_index ON signon(username);

CREATE INDEX account_userid_index ON account(userid);
ALTER TABLE account ADD CONSTRAINT account_userid_signon_username_fk FOREIGN KEY (userid) REFERENCES signon(username);
CREATE SEQUENCE account_userid_sequence START 1 INCREMENT BY 1 OWNED BY account.userid; 

CREATE INDEX profile_userid_index ON profile(userid);
ALTER TABLE profile ADD CONSTRAINT profile_userid_signon_username_fk FOREIGN KEY (userid) REFERENCES signon(username);

CREATE INDEX bannerdata_favcategory_index ON bannerdata(favcategory);
--ALTER TABLE bannerdata ADD CONSTRAINT bannerdata_favcategory_category_name_fk FOREIGN KEY (favcategory) REFERENCES category(name);

CREATE INDEX orders_orderid_index ON orders(orderid);
ALTER TABLE orders ADD CONSTRAINT orders_userid_signon_username_fk FOREIGN KEY (userid) REFERENCES signon(username);
CREATE SEQUENCE orders_orderid_sequence START 1 INCREMENT BY 1 OWNED BY orders.orderid;

CREATE INDEX orderstatus_orderid_index ON orderstatus(orderid);
ALTER TABLE orderstatus ADD CONSTRAINT orderstatus_orderid_orders_orderid_fk FOREIGN KEY (orderid) REFERENCES orders(orderid);

CREATE INDEX lineitem_orderid_linenum_index ON lineitem(orderid, linenum);
ALTER TABLE lineitem ADD CONSTRAINT lineitem_orderid_orders_orderid_fk FOREIGN KEY (orderid) REFERENCES orders(orderid);

CREATE INDEX category_catid_index ON category(catid);

CREATE INDEX product_productid_index ON product(productid);
--ALTER TABLE product ADD CONSTRAINT product_category_category_name_fk FOREIGN KEY (category) REFERENCES category(name);

CREATE INDEX item_itemid_index ON item(itemid);
ALTER TABLE item ADD CONSTRAINT item_productid_product_productid_fk FOREIGN KEY (productid) REFERENCES product(productid);
ALTER TABLE item ADD CONSTRAINT item_supplier_supplier_suppid_fk FOREIGN KEY (supplier) REFERENCES supplier(suppid);

CREATE INDEX inventory_itemid_index ON inventory(itemid);