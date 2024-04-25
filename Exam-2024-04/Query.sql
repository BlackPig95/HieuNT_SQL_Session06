# Yêu cầu truy vấn dữ liệu
# Yêu cầu 1 ( Sử dụng lệnh SQL để truy vấn cơ bản ):
# 1.	Lấy ra danh phòng có sắp xếp giảm dần theo Price gồm các cột
# sau: Id, Name, Price, SalePrice, Status, CategoryName, CreatedDate
select r.Id, r.Name, r.Price, r.SalePrice, r.Status, c.name categoryname, r.CreatedDate
from room r
         join category c on r.categoryId = c.id
order by price desc;
# 2.	Lấy ra danh sách Category gồm: Id, Name, TotalRoom, Status
# (Trong đó cột Status nếu = 0, Ẩn, = 1 là Hiển thị )
select c.Id,
       c.Name,
       count(r.categoryId) TotalRoom,
       if(c.status, 'Hoạt động', 'Không hoạt động')
from category c
         join room r
              on c.id = r.categoryId
where c.status = 1
group by c.id;
# 3.	Truy vấn danh sách Customer gồm:
# Id, Name, Email, Phone, Address, CreatedDate, Gender, BirthDay, Age
# (Age là cột suy ra từ BirthDay, Gender nếu = 0 là Nam, 1 là Nữ,
# 2 là khác )
select Id,
       Name,
       Email,
       Phone,
       Address,
       CreatedDate,
       case Gender
           when 0 then 'Nam'
           when 1 then 'Nữ'
           else 'Khác'
           end,
       BirthDay,
       (curdate() - c.birthday) Age
from customer c;
# 4.	Truy vấn xóa các sản phẩm chưa được bán
delete from room where id not in (select bd.roomId from bookingdetail bd);
# 5.	Cập nhật Cột SalePrice tăng thêm 10% cho tất cả các phòng có
# Price >= 250000
insert into room (name, status, price, saleprice, createddate, categoryId)
VALUES ('RoomTest',1,260000,250000,curdate(),1);
update room
set price = price + (price*0.1)
where price>=250000;
