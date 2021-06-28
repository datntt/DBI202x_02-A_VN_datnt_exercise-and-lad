-- exercise 8

-- 1. Lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại.
SELECT MAHD, NGAY, TENKH, DIACHI, DT
FROM HOADON, KHACHHANG
WHERE HOADON.MAKH = KHACHHANG.MAKH;

-- 2. Lấy ra các thông tin gồm Mã hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của ngày 25/5/2000.
SELECT MAHD, TENKH, DIACHI, DT
FROM HOADON, KHACHHANG
WHERE HOADON.MAKH = KHACHHANG.MAKH AND HOADON.NGAY = DATEFROMPARTS(2000, 5, 25);

-- 3. Lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của những hoá đơn trong tháng 6/2000.
SELECT MAHD, NGAY, TENKH, DIACHI, DT
FROM HOADON, KHACHHANG
WHERE HOADON.MAKH = KHACHHANG.MAKH AND
		YEAR(HOADON.NGAY) = 2000 AND
		MONTH(HOADON.NGAY) = 6;

-- 4. Lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại.
SELECT MAHD, NGAY, TENKH, DIACHI, DT
FROM HOADON, KHACHHANG
WHERE HOADON.MAKH = KHACHHANG.MAKH;

-- 5. Lấy ra danh sách những khách hàng (tên khách hàng, địa chỉ, số điện thoại) đã mua hàng trong tháng 6/2000.
SELECT TENKH, DIACHI, DT
FROM HOADON INNER JOIN KHACHHANG
ON HOADON.MAKH = KHACHHANG.MAKH
WHERE YEAR(HOADON.NGAY) = 2000 AND MONTH(HOADON.NGAY) = 6;

-- 6. Lấy ra danh sách các mặt hàng được bán từ ngày 1/1/2000 đến ngày 1/7/2000. Thông tin gồm: mã vật tư, tên vật tư.
SELECT RESULT.MAVT, TENVT
FROM (
	SELECT DISTINCT CTHD.MAVT
	FROM HOADON AS HD INNER JOIN CHITIETHOADON AS CTHD
	ON HD.MAHD = CTHD.MAHD
	WHERE HD.NGAY BETWEEN DATEFROMPARTS(2000, 1, 1) AND DATEFROMPARTS(2000, 7, 1)
) AS RESULT 
INNER JOIN VATTU
ON VATTU.MAVT = RESULT.MAVT;

--7. Lấy ra danh sách các vật tư được bán từ ngày 1/1/2000 đến ngày 1/7/2000.
-- Thông tin gồm: mã vật tư, tên vật tư, tên khách hàng đã mua, ngày mua, số lượng mua.

SELECT VT.MAVT, VT.TENVT, KH.TENKH, HD.NGAY, CTHD.SL --,CTHD.GIABAN
FROM HOADON AS HD
	INNER JOIN KHACHHANG AS KH ON HD.MAKH = KH.MAKH
	INNER JOIN CHITIETHOADON AS CTHD ON HD.MAHD = CTHD.MAHD
	INNER JOIN VATTU AS VT ON CTHD.MAVT = VT.MAVT
WHERE HD.NGAY BETWEEN DATEFROMPARTS(2000, 1, 1) AND DATEFROMPARTS(2000, 7, 1);

-- 8. Lấy ra danh sách các vật tư được mua bởi những khách hàng ở Tân Bình, trong năm 2000.
-- Thông tin lấy ra gồm: mã vật tư, tên vật tư, tên khách hàng, ngày mua, số lượng mua.

SELECT VT.MAVT, VT.TENVT, KH.TENKH, HD.NGAY, CTHD.SL
FROM HOADON AS HD
	INNER JOIN KHACHHANG AS KH ON HD.MAKH = KH.MAKH
	INNER JOIN CHITIETHOADON AS CTHD ON HD.MAHD = CTHD.MAHD
	INNER JOIN VATTU AS VT ON CTHD.MAVT = VT.MAVT
WHERE YEAR(HD.NGAY) = 2000 AND KH.DIACHI = 'TAN BINH';

-- 9. Lấy ra danh sách các vật tư được mua bởi những khách hàng ở Tân Bình, trong năm 2000.
-- Thông tin lấy ra gồm: mã vật tư, tên vật tư.
SELECT DISTINCT VT.MAVT, VT.TENVT --, KH.TENKH, HD.NGAY, CTHD.SL
FROM HOADON AS HD
	INNER JOIN KHACHHANG AS KH ON HD.MAKH = KH.MAKH
	INNER JOIN CHITIETHOADON AS CTHD ON HD.MAHD = CTHD.MAHD
	INNER JOIN VATTU AS VT ON CTHD.MAVT = VT.MAVT
WHERE YEAR(HD.NGAY) = 2000 AND KH.DIACHI = 'TAN BINH';

-- 10. Lấy ra danh sách những khách hàng KHÔNG mua hàng trong tháng 6/2000
-- gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
-- except khachhang mua hang trong thang 6/2000.
SELECT TENKH, DIACHI, DT, MAKH
FROM  KHACHHANG
EXCEPT
SELECT DISTINCT KH.TENKH, KH.DIACHI, KH.DT, KH.MAKH
FROM HOADON AS HD
JOIN KHACHHANG AS KH ON HD.MAKH = KH.MAKH
WHERE YEAR(HD.NGAY) = 2000 AND MONTH(HD.NGAY) = 6;