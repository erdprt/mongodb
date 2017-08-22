--
-- db_category
--
CREATE TABLE db_category (
  id        varchar(12)  NOT NULL,
  name      varchar(30) NOT NULL,
  parent_id varchar(9)  default NULL
);
--
-- db_product
--
CREATE TABLE db_product (
  ean_code     varchar(13)  NOT NULL,
  name         varchar(30)  NOT NULL,
  category_id  varchar(12)   NOT NULL,
  price        decimal(8,2) NOT NULL,
  manufacturer varchar(30)  NOT NULL,
  notes        varchar(256)     NULL,
  description  text             NULL
--  image        bytea            NULL, TODO support bytea type
);
--
-- db_role
--
CREATE TABLE db_role (
  name varchar(16) NOT NULL
);
--
-- db_user
--
CREATE TABLE db_user (
  id       integer     NOT NULL,
  name     varchar(30) NOT NULL,
  email    varchar(50) NOT NULL,
  password varchar(16) NOT NULL,
  role_id  varchar(16) NOT NULL,
  active   smallint    NOT NULL default 1
);
--
-- db_customer
--
CREATE TABLE db_customer (
  id         integer      NOT NULL default 0,
  category   char(1)      NOT NULL,
  salutation varchar(10),
  first_name varchar(30)  NOT NULL,
  last_name  varchar(30)  NOT NULL,
  birth_date date
);
--
-- db_order
--
CREATE TABLE db_order (
  id          integer   NOT NULL,
  customer_id integer   NOT NULL,
  total_price     decimal(8,2) NOT NULL,
  created_at  timestamp NOT NULL
);
--
-- db_order_item
--
CREATE TABLE db_order_item (
  id              integer      NOT NULL,
  order_id        integer      NOT NULL,
  number_of_items integer      NOT NULL default 1,
  product_ean_code      varchar(13)  NOT NULL,
  total_price     decimal(8,2) NOT NULL
);