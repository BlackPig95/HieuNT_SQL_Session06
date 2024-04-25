# Yêu cầu 4 ( Sử dụng lệnh SQL tạo Trigger )
# 1.Tạo trigger tr_Check_Price_Value sao cho khi thêm hoặc
# sửa phòng Room nếu nếu giá trị của cột Price > 5000000 thì
# tự động chuyển về 5000000 và in ra thông báo
# ‘Giá phòng lớn nhất 5 triệu’
set @error = 0;
DELIMITER //
create trigger if not exists tr_Check_Price_Value
    before insert
    on quanlykhachsan.room
    for each row
begin
    if (new.price > 5000000)
    then
        set new.price = 5000000;
        set @error = 1;
        #Signal sqlstate sẽ return 1 warning, nhưng vì cả procedure là
        #1 khối lệnh thực hiện một lần nên sau khi thực hiện xong
        #warning trước đó sẽ bị overwrite bởi thông báo mới khi hoàn thành
        #procedure => Không sử dụng được cách call procedure
        # call print_error_message();
    end if;
end //

DELIMITER //
create trigger tr_Warning_Price_Value
    after insert
    on quanlykhachsan.room
    for each row
begin
    if(@error =1)
        then
            set @error = 0;
            signal sqlstate '45000' set message_text  = 'Giá phòng lớn nhất 5 triệu';
    end if ;
end //
DELIMITER ;
select @error;

insert into quanlykhachsan.room (name, status, price, saleprice, createddate, categoryId)
VALUES ('roomtrigger', 1, 60000000, 1000000, curdate(), 1);


# 2.Tạo trigger tr_check_Room_NotAllow khi thực hiện đặt pòng,
# nếu ngày đến (StartDate) và ngày đi (EndDate) của đơn hiện tại mà
# phòng đã có người đặt rồi thì báo lỗi
# “Phòng này đã có người đặt trong thời gian này,
# vui lòng chọn thời gian khác”
DELIMITER //
create trigger tr_check_Room_NotAllow
    before insert
    on quanlykhachsan.room
    for each row
begin

end //
DELIMITER ;