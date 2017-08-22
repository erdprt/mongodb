
    alter table CATEGORY 
        drop constraint UNIQUE_SIBLINGS;

    alter table ADDRESS 
        drop constraint FK_ADDRESS_USERS_SHARED_PK;

    alter table BID 
        drop constraint FK_ITEM_ID;

    alter table BID 
        drop constraint FK_BIDDER_ID;

    alter table BILLING_ADDRESS 
        drop constraint FK_BILLING_ADDRESS;

    alter table BILLING_DETAILS 
        drop constraint FK_USER_ID;

    alter table CATEGORIZED_ITEM 
        drop constraint FK_CATEGORIZED_ITEM_ITEM_ID;

    alter table CATEGORIZED_ITEM 
        drop constraint FK_CATEGORIZED_ITEM_CATEGORY_ID;

    alter table CATEGORIZED_ITEM_COMPONENT 
        drop constraint FK_CATEGORIZED_ITEM_COMPONENT_ITEM_ID;

    alter table CATEGORIZED_ITEM_COMPONENT 
        drop constraint FK_CATEGORIZED_ITEM_COMPONENT_CATEGORY_ID;

    alter table CATEGORY 
        drop constraint FK_CATEGORY_PARENT_ID;

    alter table CATEGORY_ITEM 
        drop constraint FK_CATEGORY_ITEM_ITEM_ID;

    alter table CATEGORY_ITEM 
        drop constraint FK_CATEGORY_ITEM_CATEGORY_ID;

    alter table CATEGORY_ITEMS_BY_USER 
        drop constraint FK_CATEGORY_ITEMS_BY_USER_ITEM_ID;

    alter table CATEGORY_ITEMS_BY_USER 
        drop constraint FK_CATEGORY_ITEMS_BY_USER_CATEGORY_ID;

    alter table CATEGORY_ITEMS_BY_USER 
        drop constraint FK_CATEGORY_ITEMS_BY_USER_USER_ID;

    alter table COMMENT 
        drop constraint FK_ABOUT_ITEM_ID;

    alter table COMMENT 
        drop constraint FK_FROM_USER_ID;

    alter table CREDIT_CARD 
        drop constraint FK_CREDIT_CARD_SUPERCLASS;

    alter table DYNAMIC_ITEM_ENTITY 
        drop constraint FK76566A6FB4BB41BD;

    alter table ITEM 
        drop constraint FK_APPROVED_BY_USER_ID;

    alter table ITEM 
        drop constraint FK_SELLER_ID;

    alter table ITEM_BUYER 
        drop constraint FK_ITEM_BUYER_USER_ID;

    alter table ITEM_BUYER 
        drop constraint FK_ITEM_BUYER_ITEM_ID;

    alter table ITEM_IMAGES 
        drop constraint FK_ITEM_IMAGE_ITEM_ID;

    alter table ITEM_SHIPMENT 
        drop constraint FK_ITEM_SHIPMENT_SHIPMENT_ID;

    alter table ITEM_SHIPMENT 
        drop constraint FK_ITEM_SHIPMENT_ITEM_ID;

    alter table SHIPMENT 
        drop constraint FK_SHIPMENT_BUYER_ID;

    alter table SHIPMENT 
        drop constraint FK_DELIVERY_ADDRESS_ID;

    alter table SHIPMENT 
        drop constraint FK_SHIPMENT_SELLER_ID;

    alter table USERS 
        drop constraint FK_DEFAULT_BILLING_DETAILS_ID;

    drop table ADDRESS;

    drop table AUDIT_LOG;

    drop table BID;

    drop table BILLING_ADDRESS;

    drop table BILLING_DETAILS;

    drop table CATEGORIZED_ITEM;

    drop table CATEGORIZED_ITEM_COMPONENT;

    drop table CATEGORY;

    drop table CATEGORY_ITEM;

    drop table CATEGORY_ITEMS_BY_USER;

    drop table COMMENT;

    drop table CREDIT_CARD;

    drop table DYNAMIC_ITEM_ENTITY;

    drop table DYNAMIC_USER_ENTITY;

    drop table ITEM;

    drop table ITEM_BUYER;

    drop table ITEM_IMAGES;

    drop table ITEM_SHIPMENT;

    drop table SHIPMENT;

    drop table USERS;

    drop table hibernate_unique_key;

    create table ADDRESS (
        ADDRESS_ID bigint not null,
        OBJ_VERSION integer not null,
        STREET varchar(255),
        ZIPCODE varchar(16),
        CITY varchar(255),
        primary key (ADDRESS_ID)
    );

    create table AUDIT_LOG (
        AUDIT_LOG_ID bigint not null,
        MESSAGE varchar(255) not null,
        ENTITY_ID bigint not null,
        ENTITY_CLASS varchar(255) not null,
        USER_ID bigint not null,
        CREATED timestamp not null,
        primary key (AUDIT_LOG_ID)
    );

    create table BID (
        BID_ID bigint not null generated always as identity,
        BID_AMOUNT numeric(19,2) not null,
        BID_AMOUNT_CURRENCY varchar(3) not null,
        CREATED timestamp not null,
        IS_SUCCESSFUL char(1) not null,
        ITEM_ID bigint not null,
        BIDDER_ID bigint not null,
        BID_POSITION integer,
        primary key (BID_ID)
    );

    create table BILLING_ADDRESS (
        USER_ID bigint not null,
        STREET varchar(255),
        ZIPCODE varchar(16),
        CITY varchar(255),
        primary key (USER_ID)
    );

    create table BILLING_DETAILS (
        BILLING_DETAILS_ID bigint not null generated always as identity,
        BILLING_DETAILS_TYPE varchar(255) not null,
        OBJ_VERSION integer not null,
        OWNER varchar(255) not null,
        CREATED timestamp not null,
        USER_ID bigint,
        BA_ACCOUNT varchar(16),
        BA_BANKNAME varchar(255),
        BA_SWIFT varchar(15),
        primary key (BILLING_DETAILS_ID)
    );

    create table CATEGORIZED_ITEM (
        CATEGORY_ID bigint not null,
        ITEM_ID bigint not null,
        ADDED_BY_USER varchar(16) not null,
        ADDED_ON timestamp not null,
        primary key (CATEGORY_ID, ITEM_ID)
    );

    create table CATEGORIZED_ITEM_COMPONENT (
        CATEGORY_ID bigint not null,
        ITEM_ID bigint not null,
        ADDED_BY_USER varchar(255) not null,
        ADDED_ON timestamp not null,
        primary key (CATEGORY_ID, ITEM_ID, ADDED_BY_USER, ADDED_ON)
    );

    create table CATEGORY (
        CATEGORY_ID bigint not null generated always as identity,
        OBJ_VERSION integer not null,
        CATEGORY_NAME varchar(255) not null,
        CREATED timestamp not null,
        PARENT_CATEGORY_ID bigint,
        primary key (CATEGORY_ID)
    );

    create table CATEGORY_ITEM (
        CATEGORY_ID bigint not null,
        ITEM_ID bigint not null,
        DISPLAY_POSITION integer not null,
        primary key (CATEGORY_ID, DISPLAY_POSITION)
    );

    create table CATEGORY_ITEMS_BY_USER (
        CATEGORY_ID bigint not null,
        ADDED_BY_USER_ID bigint not null,
        ITEM_ID bigint not null,
        primary key (CATEGORY_ID, ITEM_ID)
    );

    create table COMMENT (
        COMMENT_ID bigint not null generated always as identity,
        OBJ_VERSION integer not null,
        RATING varchar(255) not null,
        COMMENT_TEXT varchar(4000),
        CREATED timestamp not null,
        FROM_USER_ID bigint not null,
        ABOUT_ITEM_ID bigint not null,
        primary key (COMMENT_ID)
    );

    create table CREDIT_CARD (
        CREDIT_CARD_ID bigint not null,
        CC_TYPE varchar(255) not null,
        CC_NUMBER varchar(16) not null,
        CC_EXP_MONTH varchar(2) not null,
        CC_EXP_YEAR varchar(4) not null,
        primary key (CREDIT_CARD_ID)
    );

    create table DYNAMIC_ITEM_ENTITY (
        ITEM_ID bigint not null generated always as identity,
        INIT_PRICE numeric(19,2),
        DESCRIPTION varchar(255),
        USER_ID bigint,
        primary key (ITEM_ID)
    );

    create table DYNAMIC_USER_ENTITY (
        USER_ID bigint not null generated always as identity,
        USERNAME varchar(255),
        primary key (USER_ID)
    );

    create table ITEM (
        ITEM_ID bigint not null generated always as identity,
        OBJ_VERSION integer not null,
        ITEM_NAME varchar(255) not null,
        DESCRIPTION varchar(4000) not null,
        INITIAL_PRICE numeric(19,2) not null,
        INITIAL_PRICE_CURRENCY varchar(3) not null,
        RESERVE_PRICE numeric(19,2) not null,
        RESERVE_PRICE_CURRENCY varchar(3) not null,
        START_DATE timestamp not null,
        END_DATE timestamp not null,
        ITEM_STATE varchar(255) not null,
        APPROVAL_DATETIME timestamp,
        CREATED timestamp not null,
        APPROVED_BY_USER_ID bigint,
        SELLER_ID bigint not null,
        primary key (ITEM_ID),
        check (START_DATE < END_DATE)
    );

    create table ITEM_BUYER (
        ITEM_ID bigint not null,
        USER_ID bigint,
        primary key (USER_ID, ITEM_ID)
    );

    create table ITEM_IMAGES (
        ITEM_ID bigint not null,
        FILENAME varchar(255),
        ITEM_IMAGE_ID integer not null generated always as identity,
        primary key (ITEM_IMAGE_ID)
    );

    create table ITEM_SHIPMENT (
        SHIPMENT_ID bigint not null,
        ITEM_ID bigint not null unique,
        primary key (SHIPMENT_ID)
    );

    create table SHIPMENT (
        SHIPMENT_ID bigint not null generated always as identity,
        OBJ_VERSION integer not null,
        INSPECTION_PERIOD_DAYS integer not null,
        SHIPMENT_STATE varchar(255) not null,
        CREATED timestamp not null,
        DELIVERY_ADDRESS_ID bigint not null,
        BUYER_ID bigint not null,
        SELLER_ID bigint not null,
        primary key (SHIPMENT_ID)
    );

    create table USERS (
        USER_ID bigint not null generated always as identity,
        OBJ_VERSION integer not null,
        FIRSTNAME varchar(255) not null,
        LASTNAME varchar(255) not null,
        USERNAME varchar(16) not null unique,
        "PASSWORD" varchar(12) not null,
        EMAIL varchar(255) not null,
        RANK integer not null,
        IS_ADMIN smallint not null,
        CREATED timestamp not null,
        DEFAULT_BILLING_DETAILS_ID bigint,
        HOME_STREET varchar(255),
        HOME_ZIPCODE varchar(16),
        HOME_CITY varchar(255),
        primary key (USER_ID)
    );

    alter table ADDRESS 
        add constraint FK_ADDRESS_USERS_SHARED_PK 
        foreign key (ADDRESS_ID) 
        references USERS;

    alter table BID 
        add constraint FK_ITEM_ID 
        foreign key (ITEM_ID) 
        references ITEM;

    alter table BID 
        add constraint FK_BIDDER_ID 
        foreign key (BIDDER_ID) 
        references USERS;

    alter table BILLING_ADDRESS 
        add constraint FK_BILLING_ADDRESS 
        foreign key (USER_ID) 
        references USERS;

    alter table BILLING_DETAILS 
        add constraint FK_USER_ID 
        foreign key (USER_ID) 
        references USERS;

    alter table CATEGORIZED_ITEM 
        add constraint FK_CATEGORIZED_ITEM_ITEM_ID 
        foreign key (ITEM_ID) 
        references ITEM;

    alter table CATEGORIZED_ITEM 
        add constraint FK_CATEGORIZED_ITEM_CATEGORY_ID 
        foreign key (CATEGORY_ID) 
        references CATEGORY;

    alter table CATEGORIZED_ITEM_COMPONENT 
        add constraint FK_CATEGORIZED_ITEM_COMPONENT_ITEM_ID 
        foreign key (ITEM_ID) 
        references ITEM;

    alter table CATEGORIZED_ITEM_COMPONENT 
        add constraint FK_CATEGORIZED_ITEM_COMPONENT_CATEGORY_ID 
        foreign key (CATEGORY_ID) 
        references CATEGORY;

    alter table CATEGORY 
        add constraint FK_CATEGORY_PARENT_ID 
        foreign key (PARENT_CATEGORY_ID) 
        references CATEGORY;

    alter table CATEGORY_ITEM 
        add constraint FK_CATEGORY_ITEM_ITEM_ID 
        foreign key (ITEM_ID) 
        references ITEM;

    alter table CATEGORY_ITEM 
        add constraint FK_CATEGORY_ITEM_CATEGORY_ID 
        foreign key (CATEGORY_ID) 
        references CATEGORY;

    alter table CATEGORY_ITEMS_BY_USER 
        add constraint FK_CATEGORY_ITEMS_BY_USER_ITEM_ID 
        foreign key (ITEM_ID) 
        references ITEM;

    alter table CATEGORY_ITEMS_BY_USER 
        add constraint FK_CATEGORY_ITEMS_BY_USER_CATEGORY_ID 
        foreign key (CATEGORY_ID) 
        references CATEGORY;

    alter table CATEGORY_ITEMS_BY_USER 
        add constraint FK_CATEGORY_ITEMS_BY_USER_USER_ID 
        foreign key (ADDED_BY_USER_ID) 
        references USERS;

    alter table COMMENT 
        add constraint FK_ABOUT_ITEM_ID 
        foreign key (ABOUT_ITEM_ID) 
        references ITEM;

    alter table COMMENT 
        add constraint FK_FROM_USER_ID 
        foreign key (FROM_USER_ID) 
        references USERS;

    alter table CREDIT_CARD 
        add constraint FK_CREDIT_CARD_SUPERCLASS 
        foreign key (CREDIT_CARD_ID) 
        references BILLING_DETAILS;

    alter table DYNAMIC_ITEM_ENTITY 
        add constraint FK76566A6FB4BB41BD 
        foreign key (USER_ID) 
        references DYNAMIC_USER_ENTITY;

    create index IDX_INITIAL_PRICE on ITEM (INITIAL_PRICE, INITIAL_PRICE_CURRENCY);

    create index IDX_END_DATE on ITEM (END_DATE);

    alter table ITEM 
        add constraint FK_APPROVED_BY_USER_ID 
        foreign key (APPROVED_BY_USER_ID) 
        references USERS;

    alter table ITEM 
        add constraint FK_SELLER_ID 
        foreign key (SELLER_ID) 
        references USERS;

    alter table ITEM_BUYER 
        add constraint FK_ITEM_BUYER_USER_ID 
        foreign key (USER_ID) 
        references USERS;

    alter table ITEM_BUYER 
        add constraint FK_ITEM_BUYER_ITEM_ID 
        foreign key (ITEM_ID) 
        references ITEM;

    alter table ITEM_IMAGES 
        add constraint FK_ITEM_IMAGE_ITEM_ID 
        foreign key (ITEM_ID) 
        references ITEM;

    alter table ITEM_SHIPMENT 
        add constraint FK_ITEM_SHIPMENT_SHIPMENT_ID 
        foreign key (SHIPMENT_ID) 
        references SHIPMENT;

    alter table ITEM_SHIPMENT 
        add constraint FK_ITEM_SHIPMENT_ITEM_ID 
        foreign key (ITEM_ID) 
        references ITEM;

    alter table SHIPMENT 
        add constraint FK_SHIPMENT_BUYER_ID 
        foreign key (BUYER_ID) 
        references USERS;

    alter table SHIPMENT 
        add constraint FK_DELIVERY_ADDRESS_ID 
        foreign key (DELIVERY_ADDRESS_ID) 
        references ADDRESS;

    alter table SHIPMENT 
        add constraint FK_SHIPMENT_SELLER_ID 
        foreign key (SELLER_ID) 
        references USERS;

    alter table USERS 
        add constraint FK_DEFAULT_BILLING_DETAILS_ID 
        foreign key (DEFAULT_BILLING_DETAILS_ID) 
        references BILLING_DETAILS;

    create table hibernate_unique_key (
         next_hi integer 
    );

    insert into hibernate_unique_key values ( 0 );

    alter table CATEGORY 
        add constraint UNIQUE_SIBLINGS unique (CATEGORY_NAME, PARENT_CATEGORY_ID);
