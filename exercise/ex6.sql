-- exercise 6
-- INSERT DATA INTO TABLES
-- TABLE VATTU
INSERT INTO VATTU(MAVT, TENVT, DVT, GIAMUA, SLTON)
VALUES ('VT01', 'XI MANG', 'BAO', 50000, 5000),
      ('VT02', 'CAT', 'KHOI', 45000, 50000),
      ('VT03', 'GACH  ONG', 'VIEN', 120, 800000),
      ('VT04', 'GACH THE', 'VIEN', 110, 800000),
      ('VT05', 'DA LON', 'KHOI', 25000, 100000),
      ('VT06', 'DA NHO', 'KHOI', 33000, 100000),
      ('VT07', 'LAM GIO', 'CAI', 15000, 50000);

-- TABLE KHACHHANG
INSERT INTO KHACHHANG(MAKH, TENKH, DIACHI, DT, EMAIL)
VALUES ('KH01', 'NGUYEN THI BE', 'TAN BINH', '08457895', 'bnt@yahoo.com'),
      ('KH02', 'LE HOANG NAM', 'BINH CHANH', '09878987', 'namlehoang @abc.com.vn'),
      ('KH03', 'TRAN THI CHIEU', 'TAN BINH', '08457895', NULL),
      ('KH04', 'MAI THI QUE ANH', 'BINH CHANH', NULL, NULL),
      ('KH05', 'LE VAN SANG', 'QUAN 10', NULL, 'sanglv@hcm.vnn.vn'),
      ('KH06', 'TRAN HOANG KHAI', 'TAN BINH', '08457897', NULL);

-- table hoadon
-- set date
SET DATEFORMAT DMY;

INSERT INTO HOADON(MAHD, NGAY, MAKH)
VALUES ('HD001', '12/05/2000', 'KH01'),
       ('HD002', '25/05/2000', 'KH02'),
       ('HD003', '25/05/2000', 'KH01'),
       ('HD004', '25/05/2000', 'KH04'),
       ('HD005', '26/05/2000', 'KH04'),
       ('HD006', '02/06/2000', 'KH03'),
       ('HD007', '22/06/2000', 'KH04'),
       ('HD008', '25/06/2000', 'KH03'),
       ('HD009', '15/08/2000', 'KH04'),
       ('HD010', '30/09/2000', 'KH01'),
       ('HD011', '27/12/2000', 'KH06'),
       ('HD012', '27/12/2000', 'KH01');


-- table chitiethoadon

INSERT INTO CHITIETHOADON(MAHD, MAVT, SL, GIABAN)
VALUES ('HD001', 'VT01', 5, 52000),
      ('HD001', 'VT05', 10, 30000),
      ('HD002', 'VT03', 10000, 150),
      ('HD003', 'VT02', 20, 55000),
      ('HD004', 'VT03', 50000, 150),
      ('HD004', 'VT04', 20000, 120),
      ('HD005', 'VT05', 10, 30000),
      ('HD005', 'VT06', 15, 35000),
      ('HD005', 'VT07', 20, 17000),
      ('HD006', 'VT04', 10000, 120),
      ('HD007', 'VT04', 20000, 125),
      ('HD008', 'VT01', 100, 55000),
      ('HD008', 'VT02', 20, 47000),
      ('HD009', 'VT02', 25, 48000),
      ('HD010', 'VT01', 25, 57000),
      ('HD011', 'VT01', 20, 55000),
      ('HD011', 'VT02', 20, 45000),
      ('HD012', 'VT01', 20, 55000),
      ('HD012', 'VT02', 10, 48000),
      ('HD012', 'VT03', 10000, 150);
-- display tables
SELECT * FROM VATTU;
SELECT * FROM KHACHHANG;
SELECT * FROM HOADON;
SELECT * FROM CHITIETHOADON;