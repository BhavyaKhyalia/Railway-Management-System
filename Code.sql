create database railway_DB;
use railway_DB;

create table Train (Train_id int not null,
Train_name varchar(50) not null,
Train_type varchar(50) not null,
primary key(Train_ID));

INSERT INTO train
(Train_id ,Train_name ,Train_type) VALUES
( 01001 ,'JANTA EXPRESS' ,'PASSANGER') ,
( 01002 ,'RAJDHANI EXPRESS' ,'PASSANGER') ,
( 01003 ,'BHARAT EXPRESS' ,'PASSANGER') ,
( 02001 ,'MAHARAJA EXPRESS' ,'PREMIUM') ,
( 02002 ,'MAHARANI EXPRESS' ,'PREMIUM') ,
( 00702 ,'FNF EXPRESS' ,'FAST TRAIN') ,
( 00701 ,'NFS EXPRESS' ,'FAST TRAIN') ;

SELECT * FROM Train;

create table Train_status (Train_id int not null,
Query_id int not null,
Available_date date not null,
Booked_seats int null,
Waiting_seats int null,
Available_seats int null,
primary key (Query_id),
foreign key(Train_id) references Train(Train_id) on update cascade on delete cascade);

INSERT INTO Train_status
(Train_id ,Query_id ,Available_Date ,Booked_seats ,Waiting_seats ,Available_seats) VALUES
(01001 ,166 ,'23-05-02' ,156 ,48 ,196),
(01002 ,203 ,'23-05-04' ,178 ,50 ,162),
(01003 ,148 ,'23-05-03' ,204 ,26 ,175),
(02001 ,56 ,'23-05-01' ,230 ,30 ,90),
(02002 ,62 ,'23-05-03' ,134 ,86 ,80),
(00701 ,121 ,'23-05-04' ,24 ,66 ,150),
(00702 ,221 ,'23-05-03' , 122,12 ,86);

SELECT * FROM Train_status;


create table Train_class (T_id int not null,
First_AC int not null,
AC_class int not null,
sleeper int not null,
Unreserved int not null,
primary key (T_id),
foreign key(T_id) references Train(Train_id) );

INSERT INTO Train_class
(T_id ,First_AC ,AC_class ,sleeper ,unreserved) VALUES
(02001 ,70 ,65 ,60 ,45),
(02002 ,105 ,95 ,55 ,45),
(01001 ,100 ,100 ,150 ,50),
(01002 ,100 ,100 ,140 ,50),
(01003 ,100 ,85 ,100 ,100),
(00701 ,60 ,60 ,80 ,40),
(00702 ,60 ,60 ,80 ,20);

SELECT * FROM Train_class;

create table Route (Route_id int not null,
Train_id int not null,
Source_distance int not null,
Departure_time datetime,
Arrival_time datetime,
primary key(Route_id),
foreign key(Train_id) references Train(Train_id) on update cascade on delete cascade );  

INSERT INTO Route
(Route_id ,Train_id ,Source_distance ,Departure_time ,Arrival_time) VALUES
(110039, 01001 ,250 ,'23-05-02 9:00:00' ,'23-05-03 10:00:00'),
(120050, 01002 ,350 ,'23-05-04 9:00:00' ,'23-05-06 10:00:00'),
(150012, 01003 ,370 ,'23-05-03 9:00:00' ,'23-05-04 09:00:00'),
(130039, 02001 ,150 ,'23-05-01 9:00:00' ,'23-05-02 10:00:00'),
(100022, 02002 ,170 ,'23-05-03 9:00:00' ,'23-05-04 10:00:00'),
(180036, 00701 ,550 ,'23-05-04 3:00:00' ,'23-05-04 9:00:00'),
(140028, 00702 ,470 ,'23-05-03 1:00:00' ,'23-05-03 8:00:00');

SELECT * FROM Route;

 
create table Station (Station_id int not null,
Station_name varchar(20) not null,
Route_id int not null,
primary key(Station_id, Route_id),
foreign key (Route_id) references Route(Route_id));

	INSERT INTO Station
	(Route_id ,Station_name ,Station_id) VALUES
	(110039 , 'MURADABAD UP' ,101),
	(120050 , 'HOWRAH JNCTN MUMBAI' ,911),
	(150012 , 'BIHAR JNCTN' ,102),
	(130039 , 'AGRA CITY UP' ,211),
	(100022 , 'ARNETHA RJ' ,142),
	(180036 , 'BADLI DELHI' ,233),
	(140028 ,'ADAS GUJRAT' ,343);
    
    SELECT * FROM Station;

create table Passenger (PNR varchar(20) not null,
Pname varchar(20),
Reservation_status varchar(20),
Seat_number int null,
T_id int null,
primary key (PNR),
foreign key (T_id) references Train(Train_id) on update cascade on delete cascade);

INSERT INTO Passenger (PNR, Pname, Reservation_status, Seat_number, T_id) VALUES
('ABC123', 'John Doe', 'Confirmed', 10, 01001),
('DEF456', 'Jane Doe', 'Confirmed', 11, 01001),
('GHI789', 'Bob Smith', 'Waiting', NULL, 01002),
('JKL012', 'Alice Johnson', 'Waiting', NULL, 00702),
('MNO345', 'Samuel Lee', 'Confirmed', 12, 00701),
('PQR678', 'Karen Davis', 'Confirmed', 13, 02002),
('STU901', 'David Kim', 'Confirmed', 14, 02001),
('VWX234', 'Mary Jones', 'Confirmed', 15, 00701),
('YZA567', 'Tom Brown', 'Confirmed', 16, 01003);

SELECT * FROM Passenger;


create table operator(Full_name varchar(20) not null,
Email_id varchar(30) not null,
Mobile int not null,
Gender varchar(10) not null,
Password varchar(20) not null,
Age int not null,
City varchar(20) not null,
primary key (Email_id));

INSERT INTO operator (Full_name, Email_id, Mobile, Gender, Password, Age, City)
VALUES
('John Smith', 'john@example.com', 97890, 'Male', 'password', 30, 'New York'),
('Sarah Johnson', 'sarah@example.com',78901, 'Female', 'password', 25, 'Chicago'),
('Robert Lee', 'robert@example.com', 92110, 'Male', 'password', 35, 'San Francisco');

select * from operator ;

create table Books (Booking_id int not null,
Status varchar(20) not null,
Booking_date date,
PNR varchar(20) not null,
Query_id int not null,
Email_id varchar(30) not null,
primary key(Booking_id),
foreign key (PNR) references Passenger(PNR),
foreign key (Query_id) references Train_status(Query_id),
foreign key (Email_id) references operator(Email_id)
);

INSERT INTO Books (Booking_id, Status, Booking_date, PNR, Query_id, Email_id)
VALUES
(1, 'Confirmed', '2023-04-16', 'ABC123', 166, 'john@example.com'),
(2, 'Confirmed', '2023-04-16', 'DEF456', 203, 'john@example.com'),
(3, 'Waiting', '2023-04-16', 'GHI789', 148, 'sarah@example.com'),
(4, 'Waiting', '2023-04-16', 'JKL012', 56, 'robert@example.com'),
(5, 'Confirmed', '2023-04-16', 'MNO345', 62, 'sarah@example.com'),
(6, 'Confirmed', '2023-04-16', 'PQR678', 121, 'sarah@example.com'),
(7, 'Confirmed', '2023-04-16', 'STU901', 221, 'robert@example.com');

SELECT * FROM Books;

create table Consists_of(Station_id int not null,
Train_id int not null,
Stop_no int not null,
primary key (Stop_no),
foreign key (Station_id) references Station(Station_id),
foreign key (Train_id) references Train(Train_id) on update cascade on delete cascade);


select T.Train_id, T.Train_name, T.Train_type
from Train as T,Train_status as S
where T.Train_id=S.Train_id AND S.Booked_seats=max(S.Booked_seats);


select Train_type, count(*)
from Train
group by Train_type;

select * 
from Route AS R, Train AS T
where R.Train_id=T.Train_id and R.Source_distance=max(R.Source_distance);

select Reservation_status, count(*)
from Passenger
group by Reservation_status;

select count(*)
from Passenger
where T_id="1001";

select B.Booking_id, B.Status, B.Booking_date, B.PNR, B.Query_id
from operator AS O, Books AS B
where O.Email_id=B.Email_id and O.Full_name='John Smith';
