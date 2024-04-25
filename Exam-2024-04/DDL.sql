create database if not exists quanlykhachsan;
use quanlykhachsan;
create table if not exists Category
(
    id     int primary key auto_increment,
    name   varchar(100) not null unique,
    status tinyint default 1 check ( status in (0, 1) )
);
create table if not exists Room
(
    id          int primary key auto_increment,
    name        varchar(150) not null,
    status      tinyint default 1 check ( status in (0, 1) ),
    price       float        not null check ( price >= 100000 ),
    saleprice   float   default 0,
    constraint check ( saleprice <= price ),
    createddate date    default (curdate()),
    categoryId  int          not null
);
create table if not exists Customer
(
    id          int primary key auto_increment,
    name        varchar(150) not null,
    email       varchar(150) not null unique check ( email regexp '^\\w+@\\w+[.]\\w+$'),
    phone       varchar(50)  not null unique,
    address     varchar(255),
    createdDate date default (curdate()),
    gender      tinyint      not null check ( gender in (0, 1, 2) ),
    birthday    date         not null
);
create table if not exists Booking
(
    id          int primary key auto_increment,
    customerId  int not null,
    status      tinyint  default 1 check ( status in (0, 1, 2, 3)),
    bookingdate datetime default (now())
);
create table if not exists BookingDetail
(
    bookingId int      not null,
    roomId    int      not null,
    price     float    not null,
    startdate datetime not null,
    enddate   datetime not null,
    constraint primary key (bookingId, roomId)
);
create index roomIndex on Room (name, price, createddate);
alter table Room
    add foreign key (categoryId) references Category (id);
alter table Booking
    add foreign key (customerId) references Customer (id);
alter table BookingDetail
    add foreign key (bookingId) references Booking (id),
    add foreign key (roomId) references Room (id);

Delimiter //
create trigger check_customer_date
    before insert
    on Customer
    for each row
begin
    if (new.createdDate) < curdate()
    then
        signal sqlstate '45000' set message_text =
                'Ngày tạo phải lớn hơn hoặc bằng ngày hiện tại';
    end if;
end //
Delimiter ;
