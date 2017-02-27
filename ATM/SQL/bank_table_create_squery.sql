create database [BankDB] on primary
(
	name = N'BankDB',
	filename = N'F:\BankDB\BankDB.mdf',
	size = 10MB,
	filegrowth = 15%
)
log on
(
	name = N'BankDBLog',
	filename = N'F:\BankDB\BankDBLog.ldf',
	size = 2MB,
	maxsize = 8MB,
	filegrowth = 2MB
)
go

use BankDB

if exists(select * from sysobjects where id = OBJECT_ID(N'bank_business_type'))
begin
	drop table bank_business_type
end

create table bank_business_type
(
	id int identity(1, 1) not null primary key,
	name char(32) not null,
	comment varchar(200) null
);
go

if exists(select * from sysobjects where id = OBJECT_ID(N'bank_customer'))
begin
	drop table bank_customer
end

create table bank_customer
(
	id int identity(1, 1) not null primary key,
	name varchar(32) not null,
	ic_no char(18) not null 
	check(left(ic_no, 17) like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' 
	and (right(ic_no, 1) like '[0-9]' or right(ic_no, 1) like 'X')),
	telphone varchar(20) not null 
	check(telphone like '1[358][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	address varchar(200)
);
go

if exists(select * from sysobjects where id = OBJECT_ID(N'bank_sales_network'))
begin
	drop table bank_sales_network
end

create table bank_sales_network
(
	id char(9) not null primary key
	check(id like '[0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9]'),
	name char(32) not null,
	address varchar(200)
)
go

if exists(select * from sysobjects where id = OBJECT_ID(N'bank_card'))
begin
	drop table bank_card
end

create table bank_card
(
	id char(19) not null primary key 
	check(id like '1010 3576 [0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9]'),
	--password_digest varchar(255) not null, 
	password char(6) not null default('888888'),
	currency char(32) default('RMB'),
	business_type_id int not null,
	created date not null default(getdate()),
	--open_amount money not null check(c_open_amount >= 1),
	report_less char(1) default('0'),
	customer_id int not null,
	sales_network_id char(9) not null,
	exist_balance money not null,
);
go

alter table bank_card
add constraint fk_card_business_type_id foreign key(business_type_id) references bank_business_type(id);
go

alter table bank_card
add constraint fk_card_customer_id foreign key(customer_id) references bank_customer(id);
go

alter table bank_card
add constraint fk_card_sales_network_id foreign key(sales_network_id) references bank_sales_network(id);
go

if exists(select * from sysobjects where id = OBJECT_ID(N'bank_deal_info'))
begin
	drop table bank_deal_info
end

create table bank_trade_info
(
	id int identity(1, 1) not null primary key,
	card_id char(19) not null,
	trade_date date not null default(getdate()),
	amount money not null check(amount > 0 and amount % 100 = 0),
	--1/2/3/4 分别表示存款，取款，转入和转出
	trade_type char(1) not null check(trade_type = '1' or trade_type = '2' or trade_type = '3' or trade_type = '4'),
	comment varchar(200)
);
go

alter table bank_trade_info
add constraint fk_trade_info_card_id foreign key(card_id) references bank_card(id);
go