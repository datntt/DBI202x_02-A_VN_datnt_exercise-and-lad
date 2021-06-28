CREATE TABLE KHACHKHANG (
	MAKH Nvarchar (5),
	TENKH Nvarchar (30),
	DIACHI Nvarchar (50),
	DT Nvarchar (10),
	EMAIL Nvarchar (30),
	PRIMARY KEY (MAKH)
	)

CREATE TABLE VATTU (
	MAVT Nvarchar (5),
	TENVT Nvarchar (30),
	DVT Nvarchar (20),
	GIAMUA int,
	SLTON int,
	PRIMARY KEY (MAVT)
	)

CREATE TABLE HOADON (
	 MAHD Nvarchar (10),
	 NGAY DateTime,
	 MAKH Nvarchar (5),
	 TONGTG int,
	 PRIMARY KEY (MAHD)
	 )

CREATE TABLE CHITIETHOADON (
	MAHD Nvarchar (10),
	MAVT Nvarchar (5),
	SL int,
	KHUYENMAI int,
	GIABAN int,
	PRIMARY KEY (MAHD, MAVT)
	)  