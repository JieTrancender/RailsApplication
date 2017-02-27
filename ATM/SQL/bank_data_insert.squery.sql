use BankDB

set identity_insert bank_business_type on
insert into bank_business_type(id, name, comment) values
('1', N'活期', N'无固定存期，可随时存取，存取金额不限的一种比较灵活的存款'),
('2', N'定活两便', N'事先不约定存期，一次性存入，一次性支取的存款'),
('3', N'通知', N'支取时通知银行'),
('4', N'整存整取1年', N'整笔存入，到期支付本息'),
('5', N'整存整取2年', N'整笔存入，到期支付本息'),
('6', N'整存整取3年', N'整笔存入，到期支付本息'),
('7', N'零存存整取1年', N'逐月存入，到期支付本息'),
('8', N'零存存整取2年', N'逐月存入，到期支付本息'),
('9', N'零存存整取3年', N'逐月存入，到期支付本息'),
('10', N'自助转账', N'银行ATM存取款机上办理银行卡之间互相划转')
set identity_insert bank_business_type off
go

insert into bank_sales_network(id, name, address) values
('1710 3861', N'沙河支行', N'包头市九原区G65包茂高速辅路'),
('1213 5894', N'包头西友谊大街支行', N'包头市昆都仑区友谊大街'),
('1512 5334', N'包头鹿城支行', N'包头市昆都仑区阿尔丁大街1号神华亿佰蓝天购物中心'),
('1310 9300', N'文化路支行', N'包头市青山区文化路72号时代财富广场'),
('1618 2840', N'包头新都支行', N'包头市九原区建华南路与纬五路交汇处南'),
('1411 3260', N'包头东河支行', N'包头市东河区巴彦塔拉大街41号华鹿大厦'),
('1714 0044', N'包头九原支行', N'包头市九原区沙河镇沙河街18号'),
('1531 4429', N'包头建业支行', N'包头市昆都仑区民族西路188号友谊蔬菜市场对面'),
('1232 0051', N'白云南路支行', N'包头市昆都仑区昆区友谊19#三区商网行白云南路支行'),
('1313 5845', N'包头青山支行', N'包头市青山区文化路96号'),
('1211 7752', N'包头昆都仑支行', N'包头市昆都仑区团结大街19号街坊1号底店'),
('1361 4140', N'包头临园道支行', N'包头市青山区文化路38-10号')
go

declare @name varchar(32), @card_id char(18), @telphone varchar(20), @address varchar(200)
declare cursor_customer cursor for select BCName, BCICNo, BCTel, BCAddr from [BankTemp].[dbo].[BankCustomer]

open cursor_customer
fetch next from cursor_customer 
into @name, @card_id, @telphone, @address
while @@FETCH_STATUS = 0
begin
	insert into bank_customer(name, ic_no, telphone, address) values(@name, @card_id, @telphone, @address)
	fetch next from cursor_customer into @name, @card_id, @telphone, @address
end

close cursor_customer
deallocate cursor_customer
go

--向bank_card表中添加测试数据
begin transaction trans_insertCardInfo
	declare @count int = 0, @date, @card_id char(19), @amount money
	
	while @count < 200000
	begin
		exec proc_randCardId @card_id output
		set @diff = -1 * (convert(int, rand() * 10000) % (365 * 3))
		set @date =  dateadd(day, @diff, getdate())
		set @amount = 100 + (convert(int, rand() * 100) % 20) * 100

		insert into bank_card(id, created, exist_balance) 
		values(@card_id, @date, @amount)
	end
foreign
	if (@amount < 200000)
	begin
		print('Failed to insert date')
		rollback transaction
	end
	else
	begin
		print('Succeed to insert date')
		commit transaction
	end
go

insert into bank_card(id, created, exist_balance) values()

declare @myCardId1 char(19), @diff int, @date date

exec proc_randCardId @myCardId1 output
set @diff = -1 * (convert(int, rand() * 10000) % (365 * 3))
set @date =  dateadd(day, @diff, getdate())

declare @amount int
set @amount = 100 + (convert(int, rand() * 100) % 20) * 100

select @amount

exec sp_help bank_card

select BCName, BCICNo, BCTel, BCAddr from [BankTemp].[dbo].[BankCustomer]

--print '产生随机卡号为'+@myCardId1

select convert(int, rand() * 10000) % (365 * 3)

declare @diff int
set @diff = -1 * (convert(int, rand() * 10000) % (365 * 3))

select @diff

select dateadd(day, @diff, getdate())



select * from bank_customer where ic_no = '140106198210010515'

select * from bank_sales_network
exec sp_help bank_sales_network

select * from BankTemp.BankCustomer









use BankDB;

select * from BankBusinessType;

insert into bank_business_type(bt_name, bt_comment)(select  bt_name, bt_comment from BankBusinessType);

select * from bank_business_type;

select * from BankCustomer;
select BCId from BankCustomer;

select * from bank_customer;

insert into bank_customer(c_name, c_ic_no, c_tel, c_addr) select BCName, BCICNo, BCTel, BCAddr from BankCustomer;

select * from bank_card;
select * from BankCard;

select * from bank_card;

insert into bank_card select * from BankCard;

select * from bank_customer;
select * from bank_card;
select * from BankCard;

drop table bank_card;

insert into bank_card(c_no, c_pwd, c_currency, c_bt_id, c_created, c_open_amount, c_report_less, c_c_id, c_exist_balance)
select BCNo, BCPwd, BCCurrency, BCBBTId, BCOpenDate, BCOpenAmount, BCRegLoss, BCBCId, BCExistBalance from BankCard;


select * from bank_trade_info;
select * from BankDealInfo;

insert into bank_trade_info(ti_c_no, ti_date, ti_amount, ti_type, ti_comment)
select BDBCNo, BDDealDate, BDDealAcount, BDDealType, BDDealComment from BankDealInfo;
