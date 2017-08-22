-- intialisation pour creer les tables dans le schema d�sir�: en premiere position dans le cas present
SET search_path TO ejb3inaction,public;

ALTER TABLE BILLING_DETAILS ADD CONSTRAINT BILLING_DETAILS_BILLING_ID_PKEY PRIMARY KEY (BILLING_ID);

ALTER TABLE USERS ADD CONSTRAINT USERS_USER_ID_PKEY PRIMARY KEY (USER_ID);
ALTER TABLE USERS ADD CONSTRAINT USERS_USER_BILLING_ID_BILLING_DETAILS_BILLING_ID_FK FOREIGN KEY (USER_BILLING_ID) REFERENCES BILLING_DETAILS (BILLING_ID);

ALTER TABLE CATEGORIES ADD CONSTRAINT CATEGORIES_CATEGORY_ID_PKEY PRIMARY KEY (CATEGORY_ID);
ALTER TABLE CATEGORIES ADD CONSTRAINT CATEGORIES_CREATED_BY_USERS_USER_ID_FK FOREIGN KEY (CREATED_BY) REFERENCES USERS (USER_ID);
ALTER TABLE CATEGORIES ADD CONSTRAINT CATEGORIES_PARENT_ID_CATEGORIES_CATEGORY_ID_FK FOREIGN KEY (PARENT_ID) REFERENCES CATEGORIES (CATEGORY_ID);

ALTER TABLE ITEMS ADD CONSTRAINT ITEMS_ITEM_ID_PKEY PRIMARY KEY (ITEM_ID);
ALTER TABLE ITEMS ADD CONSTRAINT ITEMS_SELLER_ID_USERS_USER_ID_FK FOREIGN KEY (SELLER_ID) REFERENCES USERS (USER_ID);

ALTER TABLE CATEGORIES_ITEMS ADD CONSTRAINT CATEGORIES_ITEMS_ITEM_ID_PKEY PRIMARY KEY (ITEM_ID);
ALTER TABLE CATEGORIES_ITEMS ADD CONSTRAINT CATEGORIES_ITEMS_CATEGORY_ID_CATEGORIES_CATEGORY_ID_FK FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORIES (CATEGORY_ID);
ALTER TABLE CATEGORIES_ITEMS ADD CONSTRAINT CATEGORIES_ITEMS_ITEM_ID_ITEMS_ITEM_ID_FK FOREIGN KEY (ITEM_ID) REFERENCES ITEMS (ITEM_ID);