-- exercise 9
-- 1.Hiển danh sách các khách hàng có điện thoại là 8457895 gồm mã khách hàng,
-- tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
SELECT * 
FROM KHACHHANG
WHERE DT = 8457895;

--2. Hiển danh sách các vật tư là “DA” (bao gồm các loại đá)
-- có giá mua dưới 30000 gồm mã vật tư, tên vật tư, đơn vị tính và giá mua .
SELECT *
FROM VATTU
WHERE TENVT LIKE '%DA%' AND GIAMUA < 30000;
-- 3. Tạo query để lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại,
-- sắp xếp theo thứ tự ngày tạo hóa đơn giảm dần
SELECT HD.MAHD, HD.NGAY, TENKH, DIACHI, DT
FROM HOADON AS HD
INNER JOIN KHACHHANG AS KH
ON HD.MAKH = KH.MAKH
ORDER BY HD.NGAY DESC;
-- 4. Lấy ra danh sách những khách hàng mua hàng trong tháng 6/2000
-- gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
SELECT DISTINCT TENKH, DIACHI, DT
FROM HOADON AS HD
INNER JOIN KHACHHANG AS KH
ON HD.MAKH = KH.MAKH
WHERE YEAR(HD.NGAY) = 2000 AND MONTH(HD.NGAY) = 6;

-- 5.Tạo query để lấy ra các chi tiết hoá đơn gồm các thông tin mã hóa đơn,mã vật tư, tên vật tư, giá bán, giá mua, số lượng ,
-- trị giá mua (giá mua * số lượng), trị giá bán , (giá bán * số lượng),
-- tiền lời (trị giá bán – trị giá mua) mà có giá bán lớn hơn hoặc bằng giá mua.
SELECT HD.MAHD, CTHD.MAVT, VT.TENVT, GIABAN, GIAMUA, SL,
	   (GIAMUA * SL) AS TriGiaMua, (GIABAN * SL) AS TriGiaBan,
	   ((GIABAN - GIAMUA) * SL) AS TienLoi
FROM HOADON AS HD
INNER JOIN CHITIETHOADON AS CTHD
ON HD.MAHD = CTHD.MAHD
INNER JOIN VATTU AS VT
ON CTHD.MAVT = VT.MAVT
WHERE GIABAN >= GIAMUA;

-- 6.Lấy ra hoá đơn có tổng trị giá nhỏ nhất trong số các hóa đơn năm 2000,
-- gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hoá đơn.

WITH tblTONGGIATRI AS (
	SELECT HD.MAHD, HD.NGAY, KH.TENKH, KH.DIACHI, SUM(GIABAN * SL) AS TongGiaTri
	FROM HOADON AS HD
	INNER JOIN KHACHHANG AS KH ON HD.MAKH = KH.MAKH
	INNER JOIN CHITIETHOADON AS CTHD ON HD.MAHD = CTHD.MAHD
	WHERE YEAR(HD.NGAY) = 2000
	GROUP BY HD.MAHD, HD.NGAY, KH.TENKH, KH.DIACHI
)
SELECT MAHD, NGAY, TENKH, DIACHI, TongGiaTri
FROM tblTONGGIATRI
WHERE TongGiaTri = (SELECT MIN(TongGiaTri) FROM tblTONGGIATRI);

-- 7. Lấy ra các thông tin về các khách hàng mua ít loại mặt hàng nhất.
WITH tblSLMH AS (
	SELECT KH.MAKH, ISNULL(COUNT(DISTINCT MAVT), 0) AS SLMH
	FROM KHACHHANG AS KH
	LEFT JOIN HOADON AS HD ON KH.MAKH = HD.MAKH
	LEFT JOIN CHITIETHOADON AS CTHD ON HD.MAHD = CTHD.MAHD
	GROUP BY KH.MAKH
)
SELECT KH.*
FROM KHACHHANG AS KH
LEFT JOIN tblSLMH ON KH.MAKH = tblSLMH.MAKH
WHERE tblSLMH.SLMH = (SELECT MIN(SLMH) FROM tblSLMH);

--8. Lấy ra vật tư có giá mua thấp nhất
SELECT *
FROM VATTU
WHERE GIAMUA = (SELECT MIN(GIAMUA) FROM VATTU);
-- 9. Lấy ra vật tư có giá bán cao nhất trong số các vật tư được bán trong năm 2000.
SELECT VT.*, CTHD.GIABAN
FROM VATTU AS VT
INNER JOIN CHITIETHOADON AS CTHD ON VT.MAVT = CTHD.MAVT
WHERE CTHD.GIABAN = (SELECT MAX(GIABAN) FROM CHITIETHOADON);
-- 10.  Cho biết mỗi vật tư đã được bán tổng số bao nhiêu đơn vị (chiếc, cái,… )
-- Chú ý: Có thể có những vật tư chưa bán được đơn vị nào, khi đó cần hiển thị là đã bán 0 đơn vị.
SELECT VATTU.MAVT, VATTU.TENVT, isnull(sl.TongSL, 0) AS 'Tong so don vi da ban'
FROM VATTU
LEFT JOIN (
	SELECT MAVT, SUM(SL) AS TongSL
	FROM CHITIETHOADON
	GROUP BY MAVT
) AS SL
ON VATTU.MAVT = SL.MAVT