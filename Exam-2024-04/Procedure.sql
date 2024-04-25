# Yêu cầu 3 ( Sử dụng lệnh SQL tạo thủ tục Stored Procedure )
# 1.Thủ tục addRoomInfo thực hiện thêm mới Room, khi gọi thủ tục
#truyền đầy đủ các giá trị của bảng Room ( Trừ cột tự động tăng )
DELIMITER //
create procedure addRoomInfo(in name_in varchar(150),
                             in status_in tinyint, in price_in float,
                             in salePrice_in float,
                             in date_in date, in cateId_in int)
begin
    insert into quanlykhachsan.room
        (name, status, price, saleprice, createddate, categoryId)
    VALUES (name_in, status_in, price_in, salePrice_in, date_in, cateId_in);
end //
DELIMITER ;
call addRoomInfo('roomProcedure', 1, 100000,
                 90000, curdate(), 2);
# 2.Thủ tục getBookingByCustomerId hiển thị danh sách phieus
# đặt phòng của khách hàng theo Id khách hàng gồm:
# Id, BookingDate, Status, TotalAmount
# (Trong đó cột Status nếu = 0 Chưa duyệt, = 1  Đã duyệt,,
# = 2 Đã thanh toán, = 3 Đã hủy),
# Khi gọi thủ tục truyền vào id cảu khách hàng
DELIMITER //
create procedure getBookingByCustomerId(customerId_in int)
begin
    select b.Id,
           b.BookingDate,
           b.Status,
           sum(bd.price) TotalAmount
    from booking b
             join bookingdetail bd
                  on b.id = bd.bookingId
    where b.customerId = customerId_in
    group by bd.bookingId;
end //
DELIMITER ;
call getBookingByCustomerId(2);
# 3.Thủ tục getRoomPaginate lấy ra danh sách phòng có phân trang gồm:
# Id, Name, Price, SalePrice, Khi gọi thủ tuc truyền vào limit và page
DELIMITER //
create procedure getRoomPaginate(page_in int, limit_in int)
begin
    declare offset int;
    set offset = (page_in - 1) * limit_in;
    select Id, Name, Price, SalePrice from room
        limit offset, limit_in;
end //
DELIMITER ;
call getRoomPaginate(2,3);