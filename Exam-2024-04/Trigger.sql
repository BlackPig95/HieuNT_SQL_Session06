# Yêu cầu 4 ( Sử dụng lệnh SQL tạo Trigger )
# 1.Tạo trigger tr_Check_Price_Value sao cho khi thêm hoặc
# sửa phòng Room nếu nếu giá trị của cột Price > 5000000 thì
# tự động chuyển về 5000000 và in ra thông báo
# ‘Giá phòng lớn nhất 5 triệu’
DELIMITER //
create trigger if not exists tr_Check_Price_Value
    before insert
    on quanlykhachsan.room
    for each row
begin
    declare exit handler for sqlstate '45000'
        begin
        end ;
    if (new.price > 5000000)
    then
        set new.price = 5000000;
        call print_error_message();
    end if;
end //
create procedure print_error_message()
begin
    signal sqlstate '45000' set message_text  = 'Giá phòng lớn nhất 5 triệu';
end //
DELIMITER ;
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