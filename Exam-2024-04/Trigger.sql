# Yêu cầu 4 ( Sử dụng lệnh SQL tạo Trigger )
# 1.Tạo trigger tr_Check_Price_Value sao cho khi thêm hoặc
# sửa phòng Room nếu nếu giá trị của cột Price > 5000000 thì
# tự động chuyển về 5000000 và in ra thông báo
# ‘Giá phòng lớn nhất 5 triệu’
# set @error = 0;
DELIMITER //
create trigger if not exists tr_Check_Price_Value
    before insert
    on quanlykhachsan.room
    for each row
begin
    if (new.price > 5000000)
    then
        set new.price = 5000000;
        #         set @error = 1;
        #Signal sqlstate sẽ return 1 warning, nhưng vì cả procedure là
        #1 khối lệnh thực hiện một lần nên sau khi thực hiện xong
        #warning trước đó sẽ bị overwrite bởi thông báo mới khi hoàn thành
        #procedure => Không sử dụng được cách call procedure
        # call print_error_message();
    end if;
end //

DELIMITER //
create trigger if not exists tr_Check_Price_Value_On_Update
    before update
    on quanlykhachsan.room
    for each row
begin
    if (new.price > 5000000)
    then
        set new.price = 5000000;
    end if;
end //

#Khi dữ liệu được insert vào bảng thì sẽ lưu vào bộ nhớ đệm
#khi ném signal thì sql sẽ rollback dữ liệu
#=> In ra được thông báo lỗi nhưng không thêm dữ liệu được
# DELIMITER
//
# create trigger tr_Warning_Price_Value
#     after insert
#     on quanlykhachsan.room
#     for each row
# begin
#     if(@error =1)
#         then
#             set @error = 0;
#             signal sqlstate '45000' set message_text  = 'Giá phòng lớn nhất 5 triệu';
#     end if ;
# end
//
# DELIMITER ;
# select @error;

insert into quanlykhachsan.room (name, status, price, saleprice, createddate, categoryId)
VALUES ('roomtrigger', 1, 60000000, 1000000, curdate(), 1);
update quanlykhachsan.room
set price = 60000000
where id = 43;
# 2.Tạo trigger tr_check_Room_NotAllow khi thực hiện đặt pòng,
# nếu ngày đến (StartDate) và ngày đi (EndDate) của đơn hiện tại mà
# phòng đã có người đặt rồi thì báo lỗi
# “Phòng này đã có người đặt trong thời gian này,
# vui lòng chọn thời gian khác”
DELIMITER //
create trigger tr_check_Room_NotAllow
    before insert
    on quanlykhachsan.bookingdetail
    for each row
begin
    if (new.startdate >= ANY (select startdate
                              from bookingdetail
                              where roomId = new.roomId)
        and new.startdate <= ANY (select enddate
                                  from bookingdetail
                                  where roomId = new.roomId))
    then
        signal sqlstate '45000'
        set message_text = 'Phòng này đã có người đặt trong thời gian này,
# vui lòng chọn thời gian khác';
    elseif(new.enddate >= ANY (select startdate
                                 from bookingdetail
                                 where roomId = new.roomId)
        and new.enddate <= ANY (select enddate
                                  from bookingdetail
                                  where roomId = new.roomId))
        then
            signal sqlstate '45000'
                set message_text = 'Phòng này đã có người đặt trong thời gian này,
# vui lòng chọn thời gian khác';
    end if;
end //
DELIMITER ;
insert into bookingdetail (bookingId, roomId, price, startdate, enddate)
VALUES (7,1, 200000, '2024-04-25', '2024-04-30');
insert into bookingdetail (bookingId, roomId, price, startdate, enddate)
VALUES (7,1, 200000, '2024-04-25', '2024-05-1');
insert into bookingdetail (bookingId, roomId, price, startdate, enddate)
VALUES (7,1, 200000, '2024-04-22', '2024-04-29');