ALTER TABLE supplier DROP CONSTRAINT supplier_suppid_index;
ALTER TABLE supplier DROP CONSTRAINT supplier_suppid_signon_username_fk;
DROP SEQUENCE supplier_suppid_sequence IF EXISTS; 

ALTER TABLE signon DROP CONSTRAINT signon_username_index;

ALTER TABLE account DROP CONSTRAINT account_userid_index;
ALTER TABLE account DROP CONSTRAINT account_userid_signon_username_fk;

ALTER TABLE profile DROP CONSTRAINT profile_userid_index;
ALTER TABLE profile DROP CONSTRAINT profile_userid_signon_username_fk;

ALTER TABLE bannerdata DROP CONSTRAINT bannerdata_favcategory_index;
ALTER TABLE bannerdata DROP CONSTRAINT bannerdata_favcategory_category_catid_fk;

ALTER TABLE orders DROP CONSTRAINT orders_orderid_index;
ALTER TABLE orders DROP CONSTRAINT orders_userid_signon_username_fk;
DROP SEQUENCE orders_orderid_sequence IF EXISTS;

ALTER TABLE orderstatus DROP CONSTRAINT orderstatus_orderid_index;
ALTER TABLE orderstatus DROP CONSTRAINT orderstatus_orderid_orders_orderid_fk;

ALTER TABLE lineitem DROP CONSTRAINT lineitem_orderid_linenum_index;
ALTER TABLE lineitem DROP CONSTRAINT lineitem_orderid_orders_orderid_fk;

ALTER TABLE category DROP CONSTRAINT category_catid_index;

ALTER TABLE product DROP CONSTRAINT product_productid_index;
ALTER TABLE product DROP CONSTRAINT product_category_category_catid_fk;

ALTER TABLE item DROP CONSTRAINT item_itemid_index;
ALTER TABLE item DROP CONSTRAINT item_productid_product_productid_fk;
ALTER TABLE item DROP CONSTRAINT item_suppliersupplier_suppid_fk;

ALTER TABLE inventory DROP CONSTRAINT inventory_itemid_index;