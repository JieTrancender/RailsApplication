use BankDB

if (object_id('tr_insert_trade_info', 'tr') is not null)
begin
	drop trigger tr_insert_trade_info
end
go

create trigger tr_insert_trade_info on bank_trade_info
after insert
as
	declare @type char(1), @amount money, @card_id char(19);
	declare cursor_trade_info cursor for select trade_type, amount, card_id from inserted

	open cursor_trade_info
	fetch next from cursor_trade_info into @type, @amount, @card_id
	while @@FETCH_STATUS = 0
	begin
		if (@type = '1')  --存款
		begin
			update bank_card set exist_balance = exist_balance + @amount where @card_id = id
		end
		else if (@type = '2')  --取款
		begin
			update bank_card set exist_balance = exist_balance - @amount where @card_id = id
		end
		else if (@type = '3') --转入
		begin
			update bank_card set exist_balance = exist_balance + @amount where @card_id = id
		end
		else if (@type = '4') --转出
		begin
			update bank_card set exist_balance = exist_balance - @amount where @card_id = id
		end
	end

	close cursor_trade_info
	deallocate cursor_trade_info
go

if (OBJECT_ID(N'tr_delete_trade_info', 'tr') is not null)
begin
	drop trigger tr_delete_trade_info
end
go

create trigger tr_delete_trade_info on bank_trade_info
after delete
as
	declare @type char(1), @amount money, @card_id char(19);
	declare cursor_trade_info cursor for select trade_type, amount, card_id from deleted

	open cursor_trade_info
	fetch next from cursor_trade_info into @type, @amount, @card_id
	while @@FETCH_STATUS = 0
	begin
		if (@type = '1')  --存款
		begin
			update bank_card set exist_balance = exist_balance - @amount where @card_id = id
		end
		else if (@type = '2')  --取款
		begin
			update bank_card set exist_balance = exist_balance + @amount where @card_id = id
		end
		else if (@type = '3') --转入
		begin
			update bank_card set exist_balance = exist_balance - @amount where @card_id = id
		end
		else if (@type = '4') --转出
		begin
			update bank_card set exist_balance = exist_balance + @amount where @card_id = id
		end
	end

	close cursor_trade_info
	deallocate cursor_trade_info
go

if (OBJECT_ID(N'tr_update_trade_info', 'tr') is not null)
begin
	drop trigger tr_update_trade_info
end
go

create trigger tr_update_trade_info on bank_trade_info
after update
as
	declare @type char(1), @amount money, @card_id char(19);
	declare cursor_trade_info cursor for select trade_type, amount, card_id from deleted

	open cursor_trade_info
	fetch next from cursor_trade_info into @type, @amount, @card_id
	while @@FETCH_STATUS = 0
	begin
		if (@type = '1')  --存款
		begin
			update bank_card set exist_balance = exist_balance - @amount where @card_id = id
		end
		else if (@type = '2')  --取款
		begin
			update bank_card set exist_balance = exist_balance + @amount where @card_id = id
		end
		else if (@type = '3') --转入
		begin
			update bank_card set exist_balance = exist_balance - @amount where @card_id = id
		end
		else if (@type = '4') --转出
		begin
			update bank_card set exist_balance = exist_balance + @amount where @card_id = id
		end
	end

	declare cursor_trade_info cursor for select trade_type, amount, card_id from deleted

	open cursor_trade_info
	fetch next from cursor_trade_info into @type, @amount, @card_id
	while @@FETCH_STATUS = 0
	begin
		if (@type = '1')  --存款
		begin
			update bank_card set exist_balance = exist_balance + @amount where @card_id = id
		end
		else if (@type = '2')  --取款
		begin
			update bank_card set exist_balance = exist_balance - @amount where @card_id = id
		end
		else if (@type = '3') --转入
		begin
			update bank_card set exist_balance = exist_balance + @amount where @card_id = id
		end
		else if (@type = '4') --转出
		begin
			update bank_card set exist_balance = exist_balance - @amount where @card_id = id
		end
	end

	close cursor_trade_info
	deallocate cursor_trade_info
go

create procedure proc_randCardId @card_id char(19) output
as
	declare @pre_id char(9), @random numeric(10,8), @card_temp char(10)
	
	set @pre_id = (select top 1 id from bank_sales_network)
	set @random = rand(datepart(day, getdate()) + datepart(minute, getdate()) + datepart(second, getdate()))
	set @card_temp = convert(char(10), @random)
	set @card_id = @pre_id + ' ' + substring(@card_temp, 3, 4) + ' ' + substring(@card_temp, 7, 4)
go

declare @myCardId1 char(19)
exec proc_randCardId @myCardId1 output
print '产生随机卡号为'+@myCardId1