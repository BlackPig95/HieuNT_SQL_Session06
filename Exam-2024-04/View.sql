# Yêu cầu 2 ( Sử dụng lệnh SQL tạo View )
# 1.	View v_getRoomInfo Lấy ra danh sách của 10 phòng có giá cao nhất
create view v_getRoomInfo
as
select *
from room
order by price desc
limit 10;
select *
from v_getRoomInfo;
# 2.	View v_getBookingList hiển thị danh sách phiếu đặt hàng gồm:
# Id, BookingDate, Status, CusName, Email, Phone,TotalAmount
# ( Trong đó cột Status nếu = 0 Chưa duyệt, = 1  Đã duyệt,
# = 2 Đã thanh toán, = 3 Đã hủy )
create view v_getBookingList
as
select b.Id,
       b.BookingDate,
       case b.Status
           when 0 then 'Chưa duyệt'
           when 1 then 'Đã duyệt'
           when 2 then 'Đã thanh toán'
           when 3 then 'Đã hủy'
           end,
       c.name        CusName,
       c.email,
       c.Phone,
       sum(bd.price) TotalAmount
from booking b
         join bookingdetail bd
              on b.id = bd.bookingId
         join customer c on b.customerId = c.id
group by bd.bookingId;
select *
from v_getBookingList;
