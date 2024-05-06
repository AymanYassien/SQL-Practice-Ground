use db2;

create table customers
(
    ID         int         ,
    First_name NVARCHAR(50),
    last_name  NVARCHAR(50),
    age        BINARY      ,
    country    VARCHAR(50) ,
    PRIMARY KEY (ID)
);

CREATE TABLE orders
(
    order_id     int                          ,
    product      NVARCHAR(50)                 ,
    total        SMALLMONEY                   ,
    customer_id  int REFERENCES customers(id) ,
    PRIMARY key(order_id)
)
-- -----------------------------------------------------------------
create table customers2
(
    ID         int         ,
    First_name NVARCHAR(50),
    last_name  NVARCHAR(50),
    age        BINARY      ,
    country    VARCHAR(50) ,
    PRIMARY KEY (ID)
);

CREATE TABLE orders2
(
    order_id     int             ,
    product      NVARCHAR(50)    ,
    total        SMALLMONEY      ,
    customer_id  int             ,
    PRIMARY key(order_id)
)

alter table orders2
ADD FOREIGN KEY (order_id) REFERENCES customers2(id)





select * from orders, customers, orders2, customers2;