    alter table caveatemptor.CATEGORY 
        drop constraint UNIQUE_SIBLINGS;

    alter table caveatemptor.ADDRESS 
        drop constraint FK_ADDRESS_USERS_SHARED_PK;

    alter table caveatemptor.BID 
        drop constraint FK_ITEM_ID;

    alter table caveatemptor.BID 
        drop constraint FK_BIDDER_ID;

    alter table caveatemptor.BILLING_ADDRESS 
        drop constraint FK_BILLING_ADDRESS;

    alter table caveatemptor.BILLING_DETAILS 
        drop constraint FK_USER_ID;

    alter table caveatemptor.CATEGORIZED_ITEM 
        drop constraint FK_CATEGORIZED_ITEM_ITEM_ID;

    alter table caveatemptor.CATEGORIZED_ITEM 
        drop constraint FK_CATEGORIZED_ITEM_CATEGORY_ID;

    alter table caveatemptor.CATEGORIZED_ITEM_COMPONENT 
        drop constraint FK_CATEGORIZED_ITEM_COMPONENT_ITEM_ID;

    alter table caveatemptor.CATEGORIZED_ITEM_COMPONENT 
        drop constraint FK_CATEGORIZED_ITEM_COMPONENT_CATEGORY_ID;

    alter table caveatemptor.CATEGORY 
        drop constraint FK_CATEGORY_PARENT_ID;

    alter table caveatemptor.CATEGORY_ITEM 
        drop constraint FK_CATEGORY_ITEM_ITEM_ID;

    alter table caveatemptor.CATEGORY_ITEM 
        drop constraint FK_CATEGORY_ITEM_CATEGORY_ID;

    alter table caveatemptor.CATEGORY_ITEMS_BY_USER 
        drop constraint FK_CATEGORY_ITEMS_BY_USER_ITEM_ID;

    alter table caveatemptor.CATEGORY_ITEMS_BY_USER 
        drop constraint FK_CATEGORY_ITEMS_BY_USER_CATEGORY_ID;

    alter table caveatemptor.CATEGORY_ITEMS_BY_USER 
        drop constraint FK_CATEGORY_ITEMS_BY_USER_USER_ID;

    alter table caveatemptor.COMMENT 
        drop constraint FK_ABOUT_ITEM_ID;

    alter table caveatemptor.COMMENT 
        drop constraint FK_FROM_USER_ID;

    alter table caveatemptor.CREDIT_CARD 
        drop constraint FK_CREDIT_CARD_SUPERCLASS;

    alter table caveatemptor.DYNAMIC_ITEM_ENTITY 
        drop constraint FK76566A6FB4BB41BD;

    alter table caveatemptor.ITEM 
        drop constraint FK_APPROVED_BY_USER_ID;

    alter table caveatemptor.ITEM 
        drop constraint FK_SELLER_ID;

    alter table caveatemptor.ITEM_BUYER 
        drop constraint FK_ITEM_BUYER_USER_ID;

    alter table caveatemptor.ITEM_BUYER 
        drop constraint FK_ITEM_BUYER_ITEM_ID;

    alter table caveatemptor.ITEM_IMAGES 
        drop constraint FK_ITEM_IMAGE_ITEM_ID;

    alter table caveatemptor.ITEM_SHIPMENT 
        drop constraint FK_ITEM_SHIPMENT_SHIPMENT_ID;

    alter table caveatemptor.ITEM_SHIPMENT 
        drop constraint FK_ITEM_SHIPMENT_ITEM_ID;

    alter table caveatemptor.SHIPMENT 
        drop constraint FK_SHIPMENT_BUYER_ID;

    alter table caveatemptor.SHIPMENT 
        drop constraint FK_DELIVERY_ADDRESS_ID;

    alter table caveatemptor.SHIPMENT 
        drop constraint FK_SHIPMENT_SELLER_ID;

    alter table caveatemptor.USERS 
        drop constraint FK_DEFAULT_BILLING_DETAILS_ID;

    drop table caveatemptor.ADDRESS;

    drop table caveatemptor.AUDIT_LOG;

    drop table caveatemptor.BID;

    drop table caveatemptor.BILLING_ADDRESS;

    drop table caveatemptor.BILLING_DETAILS;

    drop table caveatemptor.CATEGORIZED_ITEM;

    drop table caveatemptor.CATEGORIZED_ITEM_COMPONENT;

    drop table caveatemptor.CATEGORY;

    drop table caveatemptor.CATEGORY_ITEM;

    drop table caveatemptor.CATEGORY_ITEMS_BY_USER;

    drop table caveatemptor.COMMENT;

    drop table caveatemptor.CREDIT_CARD;

    drop table caveatemptor.DYNAMIC_ITEM_ENTITY;

    drop table caveatemptor.DYNAMIC_USER_ENTITY;

    drop table caveatemptor.ITEM;

    drop table caveatemptor.ITEM_BUYER;

    drop table caveatemptor.ITEM_IMAGES;

    drop table caveatemptor.ITEM_SHIPMENT;

    drop table caveatemptor.SHIPMENT;

    drop table caveatemptor.USERS;

    drop sequence caveatemptor.hibernate_sequence;

    drop schema caveatemptor CASCADE;
    
    create schema caveatemptor;    

    create table caveatemptor.ADDRESS (
        ADDRESS_ID int8 not null,
        OBJ_VERSION int4 not null,
        STREET varchar(255),
        ZIPCODE varchar(16),
        CITY varchar(255),
        primary key (ADDRESS_ID)
    );

    create table caveatemptor.AUDIT_LOG (
        AUDIT_LOG_ID int8 not null,
        MESSAGE varchar(255) not null,
        ENTITY_ID int8 not null,
        ENTITY_CLASS varchar(255) not null,
        USER_ID int8 not null,
        CREATED timestamp not null,
        primary key (AUDIT_LOG_ID)
    );

    create table caveatemptor.BID (
        BID_ID  bigserial not null,
        BID_AMOUNT numeric(19, 2) not null,
        BID_AMOUNT_CURRENCY varchar(3) not null,
        CREATED timestamp not null,
        IS_SUCCESSFUL char(1) not null,
        ITEM_ID int8 not null,
        BIDDER_ID int8 not null,
        BID_POSITION int4,
        primary key (BID_ID)
    );

    create table caveatemptor.BILLING_ADDRESS (
        USER_ID int8 not null,
        STREET varchar(255),
        ZIPCODE varchar(16),
        CITY varchar(255),
        primary key (USER_ID)
    );

    create table caveatemptor.BILLING_DETAILS (
        BILLING_DETAILS_ID  bigserial not null,
        BILLING_DETAILS_TYPE varchar(255) not null,
        OBJ_VERSION int4 not null,
        OWNER varchar(255) not null,
        CREATED timestamp not null,
        USER_ID int8,
        BA_ACCOUNT varchar(16),
        BA_BANKNAME varchar(255),
        BA_SWIFT varchar(15),
        primary key (BILLING_DETAILS_ID)
    );

    create table caveatemptor.CATEGORIZED_ITEM (
        CATEGORY_ID int8 not null,
        ITEM_ID int8 not null,
        ADDED_BY_USER varchar(16) not null,
        ADDED_ON timestamp not null,
        primary key (CATEGORY_ID, ITEM_ID)
    );

    create table caveatemptor.CATEGORIZED_ITEM_COMPONENT (
        CATEGORY_ID int8 not null,
        ITEM_ID int8 not null,
        ADDED_BY_USER varchar(255) not null,
        ADDED_ON timestamp not null,
        primary key (CATEGORY_ID, ITEM_ID, ADDED_BY_USER, ADDED_ON)
    );

    create table caveatemptor.CATEGORY (
        CATEGORY_ID  bigserial not null,
        OBJ_VERSION int4 not null,
        CATEGORY_NAME varchar(255) not null,
        CREATED timestamp not null,
        PARENT_CATEGORY_ID int8,
        primary key (CATEGORY_ID)
    );

    create table caveatemptor.CATEGORY_ITEM (
        CATEGORY_ID int8 not null,
        ITEM_ID int8 not null,
        DISPLAY_POSITION int4 not null,
        primary key (CATEGORY_ID, DISPLAY_POSITION)
    );

    create table caveatemptor.CATEGORY_ITEMS_BY_USER (
        CATEGORY_ID int8 not null,
        ADDED_BY_USER_ID int8 not null,
        ITEM_ID int8 not null,
        primary key (CATEGORY_ID, ITEM_ID)
    );

    create table caveatemptor.COMMENT (
        COMMENT_ID  bigserial not null,
        OBJ_VERSION int4 not null,
        RATING varchar(255) not null,
        COMMENT_TEXT varchar(4000),
        CREATED timestamp not null,
        FROM_USER_ID int8 not null,
        ABOUT_ITEM_ID int8 not null,
        primary key (COMMENT_ID)
    );

    create table caveatemptor.CREDIT_CARD (
        CREDIT_CARD_ID int8 not null,
        CC_TYPE varchar(255) not null,
        CC_NUMBER varchar(16) not null,
        CC_EXP_MONTH varchar(2) not null,
        CC_EXP_YEAR varchar(4) not null,
        primary key (CREDIT_CARD_ID)
    );

    create table caveatemptor.DYNAMIC_ITEM_ENTITY (
        ITEM_ID  bigserial not null,
        INIT_PRICE numeric(19, 2),
        DESCRIPTION varchar(255),
        USER_ID int8,
        primary key (ITEM_ID)
    );

    create table caveatemptor.DYNAMIC_USER_ENTITY (
        USER_ID  bigserial not null,
        USERNAME varchar(255),
        primary key (USER_ID)
    );

    create table caveatemptor.ITEM (
        ITEM_ID  bigserial not null,
        OBJ_VERSION int4 not null,
        ITEM_NAME varchar(255) not null,
        DESCRIPTION varchar(4000) not null,
        INITIAL_PRICE numeric(19, 2) not null,
        INITIAL_PRICE_CURRENCY varchar(3) not null,
        RESERVE_PRICE numeric(19, 2) not null,
        RESERVE_PRICE_CURRENCY varchar(3) not null,
        START_DATE timestamp not null,
        END_DATE timestamp not null,
        ITEM_STATE varchar(255) not null,
        APPROVAL_DATETIME timestamp,
        CREATED timestamp not null,
        APPROVED_BY_USER_ID int8,
        SELLER_ID int8 not null,
        primary key (ITEM_ID),
        check (START_DATE < END_DATE)
    );

    create table caveatemptor.ITEM_BUYER (
        ITEM_ID int8 not null,
        USER_ID int8,
        primary key (USER_ID, ITEM_ID)
    );

    create table caveatemptor.ITEM_IMAGES (
        ITEM_ID int8 not null,
        FILENAME varchar(255),
        ITEM_IMAGE_ID  serial not null,
        primary key (ITEM_IMAGE_ID)
    );

    create table caveatemptor.ITEM_SHIPMENT (
        SHIPMENT_ID int8 not null,
        ITEM_ID int8 not null unique,
        primary key (SHIPMENT_ID)
    );

    create table caveatemptor.SHIPMENT (
        SHIPMENT_ID  bigserial not null,
        OBJ_VERSION int4 not null,
        INSPECTION_PERIOD_DAYS int4 not null,
        SHIPMENT_STATE varchar(255) not null,
        CREATED timestamp not null,
        DELIVERY_ADDRESS_ID int8 not null,
        BUYER_ID int8 not null,
        SELLER_ID int8 not null,
        primary key (SHIPMENT_ID)
    );

    create table caveatemptor.USERS (
        USER_ID  bigserial not null,
        OBJ_VERSION int4 not null,
        FIRSTNAME varchar(255) not null,
        LASTNAME varchar(255) not null,
        USERNAME varchar(255) not null unique,
        PASSWORD varchar(12) not null,
        EMAIL varchar(255) not null,
        RANK int4 not null,
        IS_ADMIN bool not null,
        CREATED timestamp not null,
        DEFAULT_BILLING_DETAILS_ID int8,
        HOME_STREET varchar(255),
        HOME_ZIPCODE varchar(16),
        HOME_CITY varchar(255),
        primary key (USER_ID)
    );

    alter table caveatemptor.ADDRESS 
        add constraint FK_ADDRESS_USERS_SHARED_PK 
        foreign key (ADDRESS_ID) 
        references caveatemptor.USERS;

    alter table caveatemptor.BID 
        add constraint FK_ITEM_ID 
        foreign key (ITEM_ID) 
        references caveatemptor.ITEM;

    alter table caveatemptor.BID 
        add constraint FK_BIDDER_ID 
        foreign key (BIDDER_ID) 
        references caveatemptor.USERS;

    alter table caveatemptor.BILLING_ADDRESS 
        add constraint FK_BILLING_ADDRESS 
        foreign key (USER_ID) 
        references caveatemptor.USERS;

    alter table caveatemptor.BILLING_DETAILS 
        add constraint FK_USER_ID 
        foreign key (USER_ID) 
        references caveatemptor.USERS;

    alter table caveatemptor.CATEGORIZED_ITEM 
        add constraint FK_CATEGORIZED_ITEM_ITEM_ID 
        foreign key (ITEM_ID) 
        references caveatemptor.ITEM;

    alter table caveatemptor.CATEGORIZED_ITEM 
        add constraint FK_CATEGORIZED_ITEM_CATEGORY_ID 
        foreign key (CATEGORY_ID) 
        references caveatemptor.CATEGORY;

    alter table caveatemptor.CATEGORIZED_ITEM_COMPONENT 
        add constraint FK_CATEGORIZED_ITEM_COMPONENT_ITEM_ID 
        foreign key (ITEM_ID) 
        references caveatemptor.ITEM;

    alter table caveatemptor.CATEGORIZED_ITEM_COMPONENT 
        add constraint FK_CATEGORIZED_ITEM_COMPONENT_CATEGORY_ID 
        foreign key (CATEGORY_ID) 
        references caveatemptor.CATEGORY;

    alter table caveatemptor.CATEGORY 
        add constraint FK_CATEGORY_PARENT_ID 
        foreign key (PARENT_CATEGORY_ID) 
        references caveatemptor.CATEGORY;

    alter table caveatemptor.CATEGORY_ITEM 
        add constraint FK_CATEGORY_ITEM_ITEM_ID 
        foreign key (ITEM_ID) 
        references caveatemptor.ITEM;

    alter table caveatemptor.CATEGORY_ITEM 
        add constraint FK_CATEGORY_ITEM_CATEGORY_ID 
        foreign key (CATEGORY_ID) 
        references caveatemptor.CATEGORY;

    alter table caveatemptor.CATEGORY_ITEMS_BY_USER 
        add constraint FK_CATEGORY_ITEMS_BY_USER_ITEM_ID 
        foreign key (ITEM_ID) 
        references caveatemptor.ITEM;

    alter table caveatemptor.CATEGORY_ITEMS_BY_USER 
        add constraint FK_CATEGORY_ITEMS_BY_USER_CATEGORY_ID 
        foreign key (CATEGORY_ID) 
        references caveatemptor.CATEGORY;

    alter table caveatemptor.CATEGORY_ITEMS_BY_USER 
        add constraint FK_CATEGORY_ITEMS_BY_USER_USER_ID 
        foreign key (ADDED_BY_USER_ID) 
        references caveatemptor.USERS;

    alter table caveatemptor.COMMENT 
        add constraint FK_ABOUT_ITEM_ID 
        foreign key (ABOUT_ITEM_ID) 
        references caveatemptor.ITEM;

    alter table caveatemptor.COMMENT 
        add constraint FK_FROM_USER_ID 
        foreign key (FROM_USER_ID) 
        references caveatemptor.USERS;

    alter table caveatemptor.CREDIT_CARD 
        add constraint FK_CREDIT_CARD_SUPERCLASS 
        foreign key (CREDIT_CARD_ID) 
        references caveatemptor.BILLING_DETAILS;

    alter table caveatemptor.DYNAMIC_ITEM_ENTITY 
        add constraint FK76566A6FB4BB41BD 
        foreign key (USER_ID) 
        references caveatemptor.DYNAMIC_USER_ENTITY;

    create index IDX_INITIAL_PRICE on caveatemptor.ITEM (INITIAL_PRICE, INITIAL_PRICE_CURRENCY);

    create index IDX_END_DATE on caveatemptor.ITEM (END_DATE);

    alter table caveatemptor.ITEM 
        add constraint FK_APPROVED_BY_USER_ID 
        foreign key (APPROVED_BY_USER_ID) 
        references caveatemptor.USERS;

    alter table caveatemptor.ITEM 
        add constraint FK_SELLER_ID 
        foreign key (SELLER_ID) 
        references caveatemptor.USERS;

    alter table caveatemptor.ITEM_BUYER 
        add constraint FK_ITEM_BUYER_USER_ID 
        foreign key (USER_ID) 
        references caveatemptor.USERS;

    alter table caveatemptor.ITEM_BUYER 
        add constraint FK_ITEM_BUYER_ITEM_ID 
        foreign key (ITEM_ID) 
        references caveatemptor.ITEM;

    alter table caveatemptor.ITEM_IMAGES 
        add constraint FK_ITEM_IMAGE_ITEM_ID 
        foreign key (ITEM_ID) 
        references caveatemptor.ITEM;

    alter table caveatemptor.ITEM_SHIPMENT 
        add constraint FK_ITEM_SHIPMENT_SHIPMENT_ID 
        foreign key (SHIPMENT_ID) 
        references caveatemptor.SHIPMENT;

    alter table caveatemptor.ITEM_SHIPMENT 
        add constraint FK_ITEM_SHIPMENT_ITEM_ID 
        foreign key (ITEM_ID) 
        references caveatemptor.ITEM;

    alter table caveatemptor.SHIPMENT 
        add constraint FK_SHIPMENT_BUYER_ID 
        foreign key (BUYER_ID) 
        references caveatemptor.USERS;

    alter table caveatemptor.SHIPMENT 
        add constraint FK_DELIVERY_ADDRESS_ID 
        foreign key (DELIVERY_ADDRESS_ID) 
        references caveatemptor.ADDRESS;

    alter table caveatemptor.SHIPMENT 
        add constraint FK_SHIPMENT_SELLER_ID 
        foreign key (SELLER_ID) 
        references caveatemptor.USERS;

    alter table caveatemptor.USERS 
        add constraint FK_DEFAULT_BILLING_DETAILS_ID 
        foreign key (DEFAULT_BILLING_DETAILS_ID) 
        references caveatemptor.BILLING_DETAILS;

    create sequence caveatemptor.hibernate_sequence;

    alter table caveatemptor.CATEGORY 
        add constraint UNIQUE_SIBLINGS unique (CATEGORY_NAME, PARENT_CATEGORY_ID);
