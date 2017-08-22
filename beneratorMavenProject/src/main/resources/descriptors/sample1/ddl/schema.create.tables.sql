-- intialisation pour creer les tables dans le schema désiré: en premiere position dans le cas present
SET search_path TO sample1,public;

create table customer (
    customer_id                     integer                       ,
    title                           char(4)                       ,
    fname                           varchar(32)                   ,
    lname                           varchar(32)           not null,
    addressline                     varchar(64)                   ,
    town                            varchar(32)                   ,
    zipcode                         char(10)              not null,
    phone                           varchar(16)
);
create table item (
    item_id                         integer                       ,
    description                     varchar(64)           not null,
    cost_price                      numeric(7,2)                  ,
    sell_price                      numeric(7,2)
);
create table orderinfo (
    orderinfo_id                    integer                       ,
    customer_id                     integer               not null,
    date_placed                     date                  not null,
    date_shipped                    date                          ,
    shipping                        numeric(7,2)
);
create table stock (
    item_id                         integer               not null,
    quantity                        integer               not null
);
create table orderline (
    orderinfo_id                    integer               not null,
    item_id                         integer               not null,
    quantity                        integer               not null
);
create table barcode (
    barcode_ean                     char(13)              not null,
    item_id                         integer               not null
);