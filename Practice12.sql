-- Restaurant Ordering System
-- Mini Project - DBMS
-- Tool: MySQL Workbench

drop database if exists restaurant_db;
create database restaurant_db;
use restaurant_db;

-- table for food categories
create table categories(
category_id int primary key auto_increment,
category_name varchar(50) unique not null
);

-- menu items
create table menuitems(
item_id int primary key auto_increment,
item_name varchar(100) not null,
category_id int,
price decimal(8,2) not null,
is_available boolean default true,
foreign key(category_id) references categories(category_id)
);

create table customers(
customer_id int primary key auto_increment,
name varchar(100) not null,
phone varchar(15) unique,
email varchar(100)
);

create table diningtables(
table_id int primary key auto_increment,
table_number int unique not null,
capacity int not null,
status varchar(15) default 'AVAILABLE'
);

create table staff(
staff_id int primary key auto_increment,
name varchar(100) not null,
role varchar(20) not null,
phone varchar(15)
);

create table orders(
order_id int primary key auto_increment,
customer_id int,
table_id int,
staff_id int,
order_date datetime default current_timestamp,
status varchar(20) default 'PLACED',
total_amount decimal(10,2) default 0,
foreign key(customer_id) references customers(customer_id),
foreign key(table_id) references diningtables(table_id),
foreign key(staff_id) references staff(staff_id)
);

create table orderitems(
order_item_id int primary key auto_increment,
order_id int not null,
item_id int not null,
quantity int not null,
unit_price decimal(8,2) not null,
subtotal decimal(10,2) generated always as (quantity*unit_price) stored,
foreign key(order_id) references orders(order_id),
foreign key(item_id) references menuitems(item_id)
);

create table payments(
payment_id int primary key auto_increment,
order_id int unique not null,
payment_method varchar(10) not null,
amount_paid decimal(10,2) not null,
payment_date datetime default current_timestamp,
foreign key(order_id) references orders(order_id)
);

-- inserting sample data

insert into categories(category_name) values('Starters'),('Main Course'),('Beverages'),('Desserts');

insert into menuitems(item_name,category_id,price) values
('Paneer Tikka',1,220),
('Veg Spring Roll',1,180),
('Butter Chicken',2,320),
('Dal Makhani',2,250),
('Veg Biryani',2,260),
('Cold Coffee',3,120),
('Masala Lemonade',3,90),
('Gulab Jamun',4,100),
('Chocolate Brownie',4,150);

insert into customers(name,phone,email) values
('Harshal Deshmukh','9876543210','harshal@example.com'),
('Sneha Patil','9823456712','sneha@example.com'),
('Rohan Kulkarni','9765432109','rohan@example.com');

insert into diningtables(table_number,capacity) values (1,4),(2,2),(3,6);

insert into staff(name,role,phone) values
('Amit Sharma','Waiter','9000011111'),
('Priya Verma','Chef','9000022222'),
('Suresh Rao','Manager','9000033333'),
('Kavita Joshi','Cashier','9000044444');

-- placing order 1
insert into orders(customer_id,table_id,staff_id) values(1,1,1);
insert into orderitems(order_id,item_id,quantity,unit_price) values
(1,1,2,220),
(1,3,1,320),
(1,6,2,120);

-- placing order 2
insert into orders(customer_id,table_id,staff_id) values(2,2,1);
insert into orderitems(order_id,item_id,quantity,unit_price) values
(2,5,1,260),
(2,8,2,100);

-- trigger to keep order total updated automatically
delimiter //
create trigger update_total after insert on orderitems
for each row
begin
update orders set total_amount = (select sum(subtotal) from orderitems where order_id=new.order_id) where order_id=new.order_id;
end //
delimiter ;

-- run once so old orders also get correct totals
SET SQL_SAFE_UPDATES = 0;
update orders o set total_amount = (select sum(subtotal) from orderitems where order_id=o.order_id);
SET SQL_SAFE_UPDATES = 1;

-- procedure to place a new order
delimiter //
create procedure place_order(in cid int, in tid int, in sid int, in iid int, in qty int, out oid int)
begin
declare p decimal(8,2);
insert into orders(customer_id,table_id,staff_id) values(cid,tid,sid);
set oid = last_insert_id();
select price into p from menuitems where item_id=iid;
insert into orderitems(order_id,item_id,quantity,unit_price) values(oid,iid,qty,p);
end //
delimiter ;

-- procedure for billing
delimiter //
create procedure make_payment(in oid int, in method varchar(10))
begin
declare amt decimal(10,2);
select total_amount into amt from orders where order_id=oid;
insert into payments(order_id,payment_method,amount_paid) values(oid,method,amt);
update orders set status='PAID' where order_id=oid;
end //
delimiter ;

-- ================== QUERIES USED FOR OUTPUT ==================

-- 1. view all orders with customer, table and waiter info
select o.order_id, c.name as customer, t.table_number, s.name as waiter, o.status, o.total_amount
from orders o
join customers c on o.customer_id=c.customer_id
join diningtables t on o.table_id=t.table_id
join staff s on o.staff_id=s.staff_id;

-- 2. most ordered items
select m.item_name, sum(oi.quantity) as qty_sold, sum(oi.subtotal) as revenue
from orderitems oi join menuitems m on oi.item_id=m.item_id
group by m.item_name
order by qty_sold desc;

-- 3. total revenue per day
select date(order_date) as day, sum(total_amount) as revenue
from orders
group by date(order_date);

-- 4. order history of a customer
select order_id, order_date, status, total_amount
from orders
where customer_id=1;

-- 5. bill for one order
select m.item_name, oi.quantity, oi.unit_price, oi.subtotal
from orderitems oi join menuitems m on oi.item_id=m.item_id
where oi.order_id=1;

-- 6. call procedure to place new order
-- call place_order(3,3,1,4,1,@oid);
-- select @oid;

-- 7. call procedure to make payment
-- call make_payment(1,'UPI');