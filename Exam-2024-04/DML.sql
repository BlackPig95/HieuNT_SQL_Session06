# Yêu cầu dữ liệu mẫu ( Sử dụng lệnh SQL để thêm mới ):
use quanlykhachsan;
# 1.	Bảng Category ít nhất là 5 bản ghi dữ liệu phù hợp
insert into category (name, status)
VALUES ('VIP', 1),
       ('Double', 1),
       ('Twin', 1),
       ('Single', 1),
       ('Family', 0);
# 2.	Bảng Room Ít nhất 15 bản ghi dữ liệu phù hợp
    insert into room (name, status, price, saleprice, createddate, categoryId)
    VALUES ('Room1', 1, 200000, 190000, curdate(), 1),
           ('Room2', 1, 150000, 145000, curdate(), 2),
           ('Room3', 1, 140000, 130000, curdate(), 3),
           ('Room4', 1, 100000, 90000, curdate(), 4),
           ('Room5', 1, 200000, 180000, curdate(), 5),
           ('Room6', 1, 220000, 200000, curdate(), 1),
           ('Room7', 1, 222000, 190000, '2024-1-1', 1),
           ('Room8', 1, 140000, 130000, curdate(), 2),
           ('Room9', 1, 100000, 90000, curdate(), 4),
           ('Room10', 1, 100000, 80000, '2024-2-2', 4),
           ('Room11', 1, 110000, 90000, '2024-3-1', 4),
           ('Room12', 1, 130000, 110000, curdate(), 2),
           ('Room13', 1, 130000, 120000, curdate(), 2),
           ('Room14', 1, 125000, 100000, curdate(), 3),
           ('Room15', 1, 210000, 190000, curdate(), 5);
# 3.	Bảng Customer ít nhất 3 bản ghi dữ liệu phù hợp
    insert into customer (name, email, phone, address, gender, birthday)
    VALUES ('John Smith', 'email1@gmail.com','phone1','add1',0,'1990-1-1'),
           ('Hitler', 'email2@gmail.com','phone2','add2',2,'1989-9-8'),
           ('Franky', 'email3@gmail.com','phone3','add3',1,'1998-8-8'),
           ('Gol D. Roger', 'email4@gmail.com','phone4','add4',1,'1992-12-1'),
           ('Songoku', 'email5@gmail.com','phone5','add5',0,'1995-3-6');
# 4.	Bảng Booking ít nhất 3 bản ghi dữ liệu phù hợp,
# mỗi hóa đơn đặt ít nhất 2 phòng khác nhau
insert into booking (customerId, status, bookingdate)
VALUES  (1, 1, curdate()),
        (1, 2, curdate()),
        (2, 3, curdate()),
        (2, 0, curdate()),
        (3, 1, curdate()),
        (3, 3, curdate()),
        (5, 1, curdate());
insert into bookingdetail (bookingId, roomId, price, startdate, enddate)
VALUES (1, 1,200000, curdate(), date_add(curdate(), interval 5 day)),
       (1, 2,150000, curdate(), date_add(curdate(), interval 5 day)),
       (2, 3,140000, curdate(), date_add(curdate(), interval 3 day)),
       (2, 4,90000, curdate(), date_add(curdate(), interval 3 day)),
       (3, 5,180000, curdate(), date_add(curdate(), interval 2 day)),
       (3, 6,200000, curdate(), date_add(curdate(), interval 2 day)),
       (4, 7,222000, curdate(), date_add(curdate(), interval 3 day)),
       (4, 8,130000, curdate(), date_add(curdate(), interval 3 day)),
       (5, 9,90000, curdate(), date_add(curdate(), interval 6 day)),
       (5, 10,80000, curdate(), date_add(curdate(), interval 6 day)),
       (5, 11, 90000, curdate(), date_add(curdate(), interval 6 day));
