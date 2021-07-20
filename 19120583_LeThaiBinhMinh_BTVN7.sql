--19120583
USE master
GO
IF DB_ID('QLCB') IS NOT NULL 
	DROP DATABASE QLCB
GO
CREATE DATABASE QLCB
GO
USE QLCB
GO

CREATE TABLE KHACHHANG
(
MAKH CHAR(15),
TEN CHAR(15),
DIACHI CHAR(50),
DTHOAI CHAR(12)

CONSTRAINT PK_KH
PRIMARY KEY (MAKH)
)
GO

CREATE TABLE NHANVIEN
(
MANV CHAR(15),
TEN CHAR(15),
DIACHI CHAR(50),
DTHOAI CHAR(12),
LUONG FLOAT,
LOAINV BIT

CONSTRAINT PK_NV
PRIMARY KEY (MANV)
)
GO

CREATE TABLE LOAIMB
(
MALOAI CHAR(15),
HANGSX CHAR(15)

CONSTRAINT PK_LOAIMB
PRIMARY KEY (MALOAI)
)
GO

CREATE TABLE MAYBAY
(
SOHIEU INT,
MALOAI CHAR(15)

CONSTRAINT PK_MB
PRIMARY KEY (SOHIEU,MALOAI)
)
GO

CREATE TABLE CHUYENBAY
(
MACB CHAR(4),
SBDI CHAR(3),
SBDEN CHAR(3),
GIODI TIME,
GIODEN TIME

CONSTRAINT PK_CB
PRIMARY KEY (MACB)
)
GO

CREATE TABLE LICHBAY
(
NGAYDI DATE,
MACB CHAR(4),
SOHIEU INT,
MALOAI CHAR(15)

CONSTRAINT PK_LB
PRIMARY KEY (NGAYDI,MACB)
)
GO

CREATE TABLE DATCHO
(
MAKH CHAR(15),
NGAYDI DATE,
MACB CHAR(4)

CONSTRAINT PK_DC
PRIMARY KEY (MAKH,NGAYDI,MACB)
)
GO

CREATE TABLE KHANANG
(
MANV CHAR(15),
MALOAI CHAR(15)

CONSTRAINT PK_KN
PRIMARY KEY (MANV,MALOAI)
)
GO

CREATE TABLE PHANCONG
(
MANV CHAR(15),
NGAYDI DATE,
MACB CHAR(4)

CONSTRAINT PK_PC
PRIMARY KEY (MANV,NGAYDI,MACB)
)
GO

ALTER TABLE DATCHO
ADD
	CONSTRAINT FK_DC_KH
	FOREIGN KEY(MAKH)
	REFERENCES KHACHHANG(MAKH),

	CONSTRAINT FK_DC_LB
	FOREIGN KEY(NGAYDI,MACB)
	REFERENCES LICHBAY(NGAYDI,MACB)
GO

ALTER TABLE MAYBAY
ADD
	CONSTRAINT FK_MB_LMB
	FOREIGN KEY(MALOAI)
	REFERENCES LOAIMB
GO

ALTER TABLE KHANANG
ADD
	CONSTRAINT FK_KN_LMB
	FOREIGN KEY(MALOAI)
	REFERENCES LOAIMB,

	CONSTRAINT FK_KN_NV
	FOREIGN KEY(MANV)
	REFERENCES NHANVIEN
 GO

 ALTER TABLE PHANCONG
 ADD
	CONSTRAINT FK_PC_NV
	FOREIGN KEY(MANV)
	REFERENCES NHANVIEN,

	CONSTRAINT FK_PC_LB
	FOREIGN KEY(NGAYDI,MACB)
	REFERENCES LICHBAY
GO

ALTER TABLE LICHBAY
ADD
	CONSTRAINT FK_LB_CB
	FOREIGN KEY(MACB)
	REFERENCES CHUYENBAY,

	CONSTRAINT FK_LB_MB
	FOREIGN KEY(SOHIEU,MALOAI)
	REFERENCES MAYBAY
GO

INSERT INTO NHANVIEN(MANV,TEN,DIACHI,DTHOAI,LUONG,LOAINV)
VALUES
('1006','Chi','12/6 Nguyen Kiem','8120012',150000,0),
('1005','Giao','65 Nguyen Thai Son','8324467',500000,0),
('1001','Huong','8 Dien Bien Phu','8330733',500000,1),
('1002','Phong','1 Ly Thuong Kiet','8308117',450000,1),
('1004','Phuong','351 Lac Long Quan','8308155',250000,0),
('1003','Quang','78 Truong Dinh','8324461',350000,1),
('1007','Tam','36 Nguyen Van Cu','8458188',500000,0)
GO

INSERT INTO KHACHHANG(MAKH,TEN,DIACHI,DTHOAI)
VALUES
('0009','Nga','223 Nguyen Trai','8932320'),
('0101','Anh','567 Tran Phu','8826729'),
('0045','Thu','285 Le Loi','8932203'),
('0012','Ha','435 Quang Trung','8933232'),
('0238','Hung','456 Pasteur','9812101'),
('0397','Thanh','234 Le Van Si','8952943'),
('0582','Mai','789 Nguyen Du',NULL),
('0934','Minh','678 Le Lai',NULL),
('0091','Hai','345 Hung Vuong','8893223'),
('0314','Phuong','395 Vo Van Tan', '8232320'),
('0613','Vu','348 CMT8','8343232'),
('0586','Son','123 Bach Dang','8556223'),
('0422','Tien','75 Nguyen Thong','8332222')
GO

INSERT INTO LOAIMB(HANGSX,MALOAI)
VALUES
('Airbus','A310'),
('Airbus','A320'),
('Airbus','A330'),
('Airbus','A340'),
('Boeing','B727'),
('Boeing','B747'),
('Boeing','B757'),
('MD','DC10'),
('MD','DC9')
GO

INSERT INTO KHANANG(MANV,MALOAI)
VALUES
('1001','B727'),
('1001','B747'),
('1001','DC10'),
('1001','DC9'),
('1002','A320'),
('1002','A340'),
('1002','B757'),
('1002','DC9'),
('1003','A310'),
('1003','DC9')
GO

INSERT INTO CHUYENBAY(MACB,SBDI,SBDEN,GIODI,GIODEN)
VALUES
('100','SLC','BOS','08:00','17:50'),
('112','DCA','DEN','14:00','18:07'),
('121','STL','SLC','07:00','09:13'),
('122','STL','YYV','08:30','10:19'),
('206','DFW','STL','09:00','11:40'),
('330','JFK','YYV','16:00','18:53'),
('334','ORD','MIA','12:00','14:14'),
('335','MIA','ORD','15:00','17:14'),
('336','ORD','MIA','18:00','20:14'),
('337','MIA','ORD','20:30','23:53'),
('394','DFW','MIA','19:00','21:30'),
('395','MIA','DFW','21:00','23:43'),
('449','CDG','DEN','10:00','19:29'),
('930','YYV','DCA','13:00','16:10'),
('931','DCA','YYV','17:00','18:10'),
('932','DCA','YYV','18:00','19:10'),
('991','BOS','ORD','17:00','18:22')
GO

INSERT INTO MAYBAY(SOHIEU,MALOAI)
VALUES
(10,'B747'),
(11,'B727'),
(13,'B727'),
(13,'B747'),
(21,'DC10'),
(21,'DC9'),
(22,'B757'),
(22,'DC9'),
(23,'DC9'),
(24,'DC9'),
(70,'A310'),
(80,'A310'),
(93,'B757')
GO

INSERT INTO LICHBAY(NGAYDI,MACB,SOHIEU,MALOAI)
VALUES
('2000-11-1','100',80,'A310'),
('2000-11-1','112',21,'DC10'),
('2000-11-1','206',22,'DC9'),
('2000-11-1','334',10,'B747'),
('2000-11-1','395',23,'DC9'),
('2000-11-1','991',22,'B757'),
('2000-11-01','337',10,'B747'),
('2000-10-31','100',11,'B727'),
('2000-10-31','112',11,'B727'),
('2000-10-31','206',13,'B727'),
('2000-10-31','334',10,'B747'),
('2000-10-31','335',10,'B747'),
('2000-10-31','337',24,'DC9'),
('2000-10-31','449',70,'A310')
GO

INSERT INTO PHANCONG(MANV,NGAYDI,MACB)
VALUES
('1001','2000-11-01','100'),
('1001','2000-10-31','100'),
('1002','2000-11-01','100'),
('1002','2000-10-31','100'),
('1003','2000-10-31','100'),
('1003','2000-10-31','337'),
('1004','2000-10-31','100'),
('1004','2000-10-31','337'),
('1005','2000-10-31','337'),
('1006','2000-11-01','991'),
('1006','2000-10-31','337'),
('1007','2000-11-01','112'),
('1007','2000-11-01','991'),
('1007','2000-10-31','206')
GO

INSERT INTO DATCHO(MAKH,NGAYDI,MACB)
VALUES
('0009','2000-11-01','100'),
('0009','2000-10-31','449'),
('0045','2000-11-01','991'),
('0012','2000-10-31','206'),
('0238','2000-10-31','334'),
('0582','2000-11-01','991'),
('0091','2000-11-01','100'),
('0314','2000-10-31','449'),
('0613','2000-11-01','100'),
('0586','2000-11-01','991'),
('0586','2000-10-31','100'),
('0422','2000-10-31','449')
GO

--TRUY VẤN

--Q1: Cho biết mã số, tên phi công, địa chỉ, điện thoại của các phi công đã từng lái máy bay loại B747.
SELECT
NV.MANV, NV.TEN, NV.DIACHI, NV.DTHOAI
FROM NHANVIEN NV JOIN KHANANG KN ON NV.MANV = KN.MANV
WHERE KN.MALOAI = 'B747'
GO

--Q2: Cho biết mã số và ngày đi của các chuyến bay xuất phát từ sân bay DCA trong khoảng thời gian từ 14 giờ đến 18 giờ.
SELECT
LB.MACB, LB.NGAYDI
FROM LICHBAY LB, CHUYENBAY CB 
WHERE LB.MACB = CB.MACB 
AND CB.SBDI = 'DCA' AND CB.GIODI BETWEEN '14:00:00' AND '18:00:00'
GO

--Q3:Cho biết tên những NV được phân công trên chuyến bay có mã số 100 xuất phát tại sân bay SLC.
----Các dòng dữ liệu xuất ra ko được phép trùng lặp
SELECT 
DISTINCT NV.TEN
FROM NHANVIEN NV JOIN PHANCONG PC ON NV.MANV = PC.MANV
JOIN CHUYENBAY CB ON PC.MACB = CB.MACB
WHERE PC.MACB = '100' AND CB.SBDI = 'SLC'

--Q4: Cho biết mã loại và số hiệu máy bay đã từng xuất phát từ sân bay MIA
SELECT
DISTINCT LB.MALOAI, LB.SOHIEU
FROM LICHBAY LB JOIN CHUYENBAY CB ON LB.MACB = CB.MACB AND CB.SBDI = 'MIA'
GO

--Q5:Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại của tất cả các hành khách đi trên chuyên bay đó
----Sắp xếp theo thứ tự tăng dần của mã chuyến bay và theo ngày đi giảm dần
SELECT 
DISTINCT DC.MACB, DC.NGAYDI, KH.TEN, KH.DIACHI, KH.DTHOAI
FROM KHACHHANG KH JOIN DATCHO DC ON KH.MAKH = DC.MAKH
ORDER BY DC.MACB ASC, DC.NGAYDI DESC
GO

--Q6: Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại của tất cả những nhân viên được phân công trong chuyến bay đó.
----Sắp xếp theo thứ tự tăng dần của mã chuyến bay và theo ngày đi giảm dần
SELECT
DISTINCT PC.MACB,PC.NGAYDI,NV.TEN, NV.DIACHI, NV.DTHOAI
FROM NHANVIEN NV JOIN PHANCONG PC ON NV.MANV = PC.MANV
ORDER BY PC.MACB ASC, PC.NGAYDI DESC
GO

--Q7: Cho biết mã chuyến bay, ngày đi, mã số và tên của những phi công 
--được phân công vào chuyến bay hạ cánh xuống sân bay QRD
SELECT 
DISTINCT PC.MACB, PC.NGAYDI, NV.MANV, NV.TEN
FROM PHANCONG PC JOIN NHANVIEN NV ON PC.MANV=NV.MANV AND NV.LOAINV = 1
JOIN CHUYENBAY CB ON PC.MACB = CB.MACB AND CB.SBDEN = 'ORD'
GO

--Q8: Cho biết các chuyến bay (Mã số chuyến bay, ngày đi và tên của phi công)
--trong đó phi công có mã 1001 được phân công lái
SELECT 
DISTINCT LB.MACB,LB.NGAYDI, NV.TEN
FROM LICHBAY LB JOIN PHANCONG PC ON PC.MACB = LB.MACB AND PC.MANV = '1001'
JOIN NHANVIEN NV ON NV.MANV = PC.MANV
GO

--Q9: Cho biết thông tin (Mã chuyến bay, sân bay đi, giờ đi, giờ đến, ngày đi) 
--của những chuyến bay hạ cánh xuống DEN.Các chuyến bay được liệt kê theo 
--ngày đi giảm dần và sân bay xuất phát (SBDI) tăng dần
SELECT
CB.MACB, CB.SBDI, CB.GIODI, CB.GIODEN, LB.NGAYDI
FROM CHUYENBAY CB JOIN LICHBAY LB ON CB.MACB = LB.MACB
AND CB.SBDEN = 'DEN'
ORDER BY LB.NGAYDI DESC, CB.SBDI ASC
GO

--Q10: Với mỗi phi công, cho biết hãng SX và mã loại máy bay mà phi công này có
--khả năng bay được. Xuất ra tên phi công, hãng sản xuất và mã loại máy bay.
SELECT 
DISTINCT NV.*,LMB.HANGSX,LMB.MALOAI
FROM KHANANG KN, NHANVIEN NV, LOAIMB LMB
WHERE KN.MANV = NV.MANV
AND NV.LOAINV = 1
AND KN.MALOAI = LMB.MALOAI
GO

--Q11: Cho biết mã phi công, tên phi công đã lái máy bay trong chuyến bay mã số 100 vào ngày 11/01/2000
SELECT 
NV.MANV, NV.TEN
FROM NHANVIEN NV, PHANCONG PC
WHERE PC.MACB = '100' AND PC.NGAYDI = '11-01-2000' AND NV.LOAINV = 1
AND NV.MANV = PC.MANV 
GO

--Q12: Cho biết mã chuyến bay, mã nhân viên, tên nhân viên được phân công vào
--chuyến bay xuất phát ngày 10/31/2000 tại sân bay MIA vào lúc 20:30
SELECT 
CB.MACB, NV.MANV, NV.TEN
FROM NHANVIEN NV, CHUYENBAY CB, PHANCONG PC
WHERE PC.NGAYDI = '10-31-2000' 
AND CB.SBDI = 'MIA'
AND CB.GIODI = '20:30:00'
AND NV.MANV = PC.MANV 
AND PC.MACB = CB.MACB
GO

--Q13: Cho biết thông tin về chuyến bay (mã chuyến bay, số hiệu, mã loại, hãng 
--sản xuất) mà phi công "Quang" đã lái
SELECT 
PC.MACB, LB.SOHIEU, LB.MALOAI, LMB.HANGSX
FROM NHANVIEN NV, PHANCONG PC, LICHBAY LB, LOAIMB LMB
WHERE NV.TEN = 'Quang' 
AND NV.LOAINV = 1
AND NV.MANV = PC.MANV 
AND PC.MACB = LB.MACB
AND LMB.MALOAI = LB.MALOAI
GO

--Q14: Cho biết tên của những phi công chưa được phân công lái máy bay nào
SELECT
DISTINCT NV.TEN
FROM NHANVIEN NV
WHERE NV.MANV NOT IN (SELECT MANV FROM PHANCONG)
AND NV.LOAINV = 1 
GO

--Q15: Cho biết tên khách hàng đã đi chuyến bay trên máy bay của hãng "Boeing"
SELECT 
DISTINCT KH.TEN
FROM KHACHHANG KH, LICHBAY LB, DATCHO DC, LOAIMB LMB
WHERE LMB.HANGSX = 'Boeing' 
AND KH.MAKH = DC.MAKH
AND DC.MACB = LB.MACB 
AND LMB.MALOAI = LB.MALOAI
GO

--Q16:Cho biết mã các chuyến bay chỉ bay với máy bay số hiệu 10 và mã loại B747
SELECT LB.MACB
FROM LICHBAY LB
WHERE LB.SOHIEU = 10 AND LB.MALOAI = 'B747'

--Q17: Với mỗi sân bay (SBDEN), cho biết số lượng chuyến bay hạ cánh xuống sân bay đó.
--Kết quả được sắp xếp theo thứ tự tăng dần của sân bay đến.
SELECT 
CB.SBDEN, COUNT(*) AS N'SỐ LƯỢNG HẠ CÁNH'
FROM CHUYENBAY CB
GROUP BY SBDEN
ORDER BY SBDEN ASC
GO

--Q18: Cau Q18: Vời mỗi sân bay (SBDI), cho biết số lượng chuyến bay xuất phát từ sân bay đó,
----sắp xếp theo thứ tăng dần của sân bay xuất phát.
SELECT 
CB.SBDI, COUNT(*) AS N'SỐ LƯỢNG CẤT CÁNH'
FROM CHUYENBAY CB
GROUP BY SBDI
ORDER BY SBDI ASC
GO

--Q19: Với mỗi sân bay (SBDI), cho biết số lượng chuyến bay xuất phát theo từng ngày.
----Xuất ra mã sân bay đi, ngày và số lượng.
SELECT
CB.SBDI,LB.NGAYDI, COUNT(SBDI) AS N'SỐ LƯỢNG'
FROM CHUYENBAY CB JOIN LICHBAY LB ON CB.MACB = LB.MACB
GROUP BY CB.SBDI, LB.NGAYDI
GO

--Q20: Với mỗi sân bay (SBDEN), cho biết số lượng chuyến bay hạ cánh theo từng ngày.
--Xuất ra mã sân bay đến, ngày và số lượng.
SELECT
CB.SBDEN,LB.NGAYDI, COUNT(SBDEN) AS N'SỐ LƯỢNG'
FROM CHUYENBAY CB JOIN LICHBAY LB ON CB.MACB = LB.MACB
GROUP BY CB.SBDEN, LB.NGAYDI
GO

--Q21: Với mỗi lịch bay, cho biết mã chuyến bay, ngày đi cùng với số lượng nhân viên không
-- phải là phi công của chuyến bay đó.	
SELECT
LB.MACB,LB.NGAYDI, COUNT(PC.MANV) AS 'SL'
FROM LICHBAY LB JOIN PHANCONG PC ON LB.MACB = PC.MACB JOIN NHANVIEN NV ON PC.MANV = NV.MANV
WHERE NV.LOAINV != 1
GROUP BY LB.MACB,LB.NGAYDI
GO

--Q22: Số lượng chuyến bay xuất phát từ sân bay MIA vào ngày 11/01/2000
SELECT
COUNT(SBDI) AS N'SỐ LƯỢNG'
FROM CHUYENBAY CB JOIN LICHBAY LB ON CB.MACB = LB.MACB AND LB.NGAYDI = '2000-11-01' AND CB.SBDI = 'MIA'
GROUP BY CB.SBDI
GO

--Q23: Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, số lượng nhân viên được phân công
--trên chuyến bay đó, sắp theo thứ tự giảm dần của số lượng.
SELECT
PC.MACB,PC.NGAYDI, COUNT(PC.MANV) AS 'SL'
FROM PHANCONG PC 
GROUP BY PC.MACB,PC.NGAYDI
ORDER BY SL DESC
GO

--Q24: Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, cùng với số lượng hành khách đã đặt chỗ
--của chuyến bay đó, sắp theo thứ tự giảm dần của số lượng.
SELECT
DC.MACB,DC.NGAYDI, COUNT(DC.MAKH) AS 'SL'
FROM DATCHO DC
GROUP BY DC.MACB,DC.NGAYDI
ORDER BY SL DESC
GO

--Q25: Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, tổng lương của phi hành đoàn (các nhân viên được
--phân công trong chuyến bay), sắp xếp theo thứ tự tăng dần của tổng lương
SELECT
PC.MACB,PC.NGAYDI, SUM(NV.LUONG) AS 'TL'
FROM PHANCONG PC JOIN NHANVIEN NV ON PC.MANV = NV.MANV
GROUP BY PC.MACB,PC.NGAYDI
ORDER BY TL ASC
GO

--Q26: Cho biết lương trung bình của các nhân viên không phải là phi công.
SELECT AVG(NV.LUONG) AS LUONG_TB
FROM NHANVIEN NV
WHERE NV.LOAINV = 0
GO

--Q27: Cho biết mức lương trung bình của các phi công
SELECT AVG(LUONG) AS LUONG_TB
FROM NHANVIEN
WHERE LOAINV = 1
GO

--Q28: Với mỗi loại máy bay, cho biết số lượng chuyến bay đã bay trên loại máy bay
--đó hạ cánh xuống sân bay QRD. Xuất ra mã loại máy bay, số lượng chuyến bay.
SELECT 
LB.MALOAI, COUNT(LB.MACB) AS 'SL'
FROM LICHBAY LB JOIN CHUYENBAY CB ON CB.MACB = LB.MACB AND CB.SBDEN = 'QRD'
GROUP BY LB.MALOAI
GO

--Q29: Cho biết sân bay (SBDI) và số lượng chuyến bay có nhiều hơn 2 chuyến bay
--xuất phát trong khoảng 10 giờ đến 22 giờ
SELECT SBDI, COUNT(*) AS SL_CB
FROM CHUYENBAY
WHERE GIODI BETWEEN '10:00:00' AND '22:00:00'
GROUP BY SBDI
HAVING COUNT(*) > 2
GO

--Q30: Cho biết tên phi công được phân công vào ít nhất 2 chuyến bay trong cùng một ngày.
SELECT
NV.TEN,PC.NGAYDI
FROM NHANVIEN NV JOIN PHANCONG PC ON NV.MANV = PC.MANV 
GROUP BY NV.TEN, PC.NGAYDI
HAVING COUNT(PC.MACB) >= 2
GO

--Q31: Cho biết mã chuyến bay và ngày đi của những chuyến bay có ít hơn 3 hành khách đặt chỗ.
SELECT
LB.MACB,LB.NGAYDI
FROM LICHBAY LB JOIN DATCHO DC ON LB.MACB = DC.MACB
GROUP BY LB.MACB,LB.NGAYDI
HAVING COUNT(DC.MACB) < 3
GO

--Q32: Cho biết số hiệu máy bay và loại máy bay mà phi công có mã 1001 được phân công lái trên 2 lần.
SELECT LB.SOHIEU, LB.MALOAI, COUNT(*) AS 'SL_LAI'
FROM PHANCONG PC JOIN LICHBAY LB ON PC.MACB = LB.MACB 
AND PC.NGAYDI = LB.NGAYDI
AND PC.MANV = '1001'
GROUP BY LB.SOHIEU, LB.MALOAI
HAVING COUNT(*) > 2
GO

--Q33: Với mỗi hãng sản xuất, cho biết số lượng loại máy bay mà hãng đó đã sản xuất. 
--Xuất ra hãng sản xuất và số lượng.
SELECT
LMB.HANGSX, COUNT(LMB.MALOAI) AS 'SL'
FROM LOAIMB LMB 
GROUP BY LMB.HANGSX
GO

--Q34: Cho biết hãng sản xuất, mã loại và số hiệu của máy bay đã được sử dụng nhiều nhất.
SELECT LMB.HANGSX, LMB.MALOAI, MB.SOHIEU
FROM MAYBAY MB JOIN LOAIMB LMB ON MB.MALOAI = LMB.MALOAI JOIN LICHBAY LB ON LB.SOHIEU = MB.SOHIEU
GROUP BY LMB.HANGSX, LMB.MALOAI, MB.SOHIEU
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
				FROM MAYBAY MB JOIN LOAIMB LMB ON MB.MALOAI = LMB.MALOAI JOIN LICHBAY LB ON LB.SOHIEU = MB.SOHIEU
				GROUP BY LMB.HANGSX, LMB.MALOAI,MB.SOHIEU)
GO

--Q35: Cho biết tên nhân viên được phân công đi nhiều chuyến bay nhất.
SELECT NV.TEN AS N'NHÂN VIÊN ĐƯỢC PHÂN CÔNG ĐI NHIỀU CHUYẾN BAY NHẤT'
FROM NHANVIEN NV JOIN PHANCONG PC ON NV.MANV = PC.MANV
GROUP BY NV.TEN
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
						FROM NHANVIEN NV JOIN PHANCONG PC ON NV.MANV = PC.MANV
						GROUP BY NV.TEN)
GO

--Q36: Cho biết thông tin của phi công (tên, địachỉ, điệnthoại) lái nhiều chuyến bay nhất.
SELECT NV.TEN, NV.DIACHI, NV.DTHOAI AS N'PHI CÔNG LÁI NHIỀU CHUYẾN BAY NHẤT'
FROM NHANVIEN NV JOIN PHANCONG PC ON NV.MANV = PC.MANV AND NV.LOAINV = 1
GROUP BY NV.TEN, NV.DIACHI, NV.DTHOAI
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
						FROM NHANVIEN NV1 JOIN PHANCONG PC1 ON NV1.MANV = PC1.MANV AND NV1.LOAINV = 1
						GROUP BY NV1.TEN, NV1.DIACHI, NV1.DTHOAI)
GO

--Q37: Cho biết sân bay (SBDEN) và số lượng chuyến bay của sân bay có ít chuyến bay đáp xuống nhất.
SELECT CB.SBDEN, COUNT(CB.MACB) AS 'SL_CHUYENBAY'
FROM CHUYENBAY CB 
GROUP BY CB.SBDEN
HAVING COUNT(*) <= ALL(SELECT COUNT(*)
						FROM CHUYENBAY CB 
						GROUP BY CB.SBDEN)
GO

--Q38: Cho biết sân bay (SBDI) và số lượng chuyến bay của sân bay có nhiều chuyến bay xuất phát nhất.
SELECT CB.SBDI, COUNT(CB.MACB) AS 'SL_CHUYENBAY'
FROM CHUYENBAY CB 
GROUP BY CB.SBDI
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
						FROM CHUYENBAY CB 
						GROUP BY CB.SBDI)
GO

--Q39: Cho biết tên, địa chỉ, và điện thoại của khách hàng đã đi trên nhiều chuyến bay nhất.
SELECT KH.TEN, KH.DIACHI, KH.DTHOAI
FROM KHACHHANG KH JOIN DATCHO DC ON KH.MAKH = DC.MAKH
GROUP BY KH.TEN, KH.DIACHI, KH.DTHOAI
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
						FROM KHACHHANG KH1 JOIN DATCHO DC1 ON KH1.MAKH = DC1.MAKH
						GROUP BY KH1.TEN, KH1.DIACHI, KH1.DTHOAI)
GO

--Q40: Cho biết mã số, tên và lương của các phi công có khả năng lái nhiều loại máy bay nhất.
SELECT NV.MANV, NV.TEN, NV.LUONG
FROM NHANVIEN NV JOIN KHANANG KN ON NV.MANV = KN.MANV
GROUP BY NV.MANV, NV.TEN, NV.LUONG
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
						FROM NHANVIEN NV1 JOIN KHANANG KN1 ON NV1.MANV = KN1.MANV
						GROUP BY NV1.MANV)
GO
						
--Q41: Cho biết	thông tin (mã nhân viên, tên, lương) của nhân viên có mức lương cao nhất.
SELECT DISTINCT NV.MANV, NV.TEN, NV.LUONG
FROM NHANVIEN NV
WHERE NV.LUONG >= (SELECT MAX(NV1.LUONG)
					FROM NHANVIEN NV1)
GO

--Q42: Cho biết	tên, địa chỉ của các nhân viên có lương cao nhất trong phi hành đoàn 
--(các nhân viên được phân công trong một chuyến bay) mà người đó tham gia.

SELECT DISTINCT nv.TEN, nv.LUONG 
FROM NHANVIEN NV JOIN PHANCONG PC ON NV.MANV = PC.MANV
WHERE NV.LUONG >= ALL(
		SELECT NV1.LUONG
		FROM NHANVIEN NV1 JOIN PHANCONG PC1 on PC1.MANV = NV1.MANV
		WHERE PC1.NGAYDI = PC.NGAYDI and PC1.MACB = PC.MACB)
GO

--Q43: Cho biết mã chuyến bay, giờ đi và giờ đến của chuyến bay bay sớm nhất trong ngày.

SELECT CB.MACB, LB.NGAYDI, CB.GIODI, CB.GIODEN
FROM LICHBAY LB, CHUYENBAY CB
WHERE LB.MACB = CB.MACB AND EXISTS (
                    SELECT*
                    FROM LICHBAY LB1, CHUYENBAY CB1
                    WHERE LB1.MACB = CB1.MACB AND LB.NGAYDI = LB1.NGAYDI
                    GROUP BY LB1.NGAYDI
                    HAVING CB.GIODI = MIN(CB1.GIODI)
                    )
GO

--Q44: Cho biết mã chuyến bay có thời gian bay dài nhất. Xuất ra mã chuyến bay và thời gian bay	(tính bằng phút).
SELECT CB.MACB, DATEDIFF(MI, CB.GIODI, CB.GIODEN) AS N'THỜI GIAN BAY (PHÚT)'
FROM CHUYENBAY CB
WHERE DATEDIFF(MI, CB.GIODI, CB.GIODEN) >= ALL
	(SELECT DATEDIFF(MI, CB1.GIODI, CB1.GIODEN)
	FROM CHUYENBAY CB1)
GO

--Q45: Cho biết mã chuyến bay có thời gian bay ít nhất. Xuất ra mã chuyến bay và thời gian bay
SELECT CB.MACB, DATEDIFF(MI, CB.GIODI, CB.GIODEN) AS N'THỜI GIAN BAY (PHÚT)'
FROM CHUYENBAY CB
WHERE DATEDIFF(MI, CB.GIODI, CB.GIODEN) <= ALL
	(SELECT DATEDIFF(MI, CB1.GIODI, CB1.GIODEN)
	FROM CHUYENBAY CB1)
GO

--Q46: Cho biết mã chuyến bay, ngày đi của của những chuyến bay trên loại máy bay B747 nhiều nhất.

SELECT MACB, NGAYDI
FROM LICHBAY LB
WHERE EXISTS(
      SELECT *
      FROM LICHBAY LB1
      WHERE LB1.MALOAI = 'B747' AND LB1.MACB = LB.MACB
      GROUP BY MACB
      HAVING COUNT(LB1.NGAYDI) >= ALL 
				(SELECT COUNT(LB2.NGAYDI)
                  FROM LICHBAY LB2
                  WHERE LB2.MALOAI = 'B747'
                  GROUP BY MACB
                )
            )
GO

--Q47: Với mỗi chuyến bay có trên 3 hành khách, cho biết mã chuyến bay và số lượng nhân viên trên chuyến bay đó.	
----Xuất ra mã chuyến bay	và số lượng nhân viên.
SELECT LB.MACB, COUNT(DISTINCT PC.MANV) AS N'SỐ LƯỢNG NHÂN VIÊN'
FROM DATCHO DC JOIN LICHBAY LB ON DC.MACB = LB.MACB AND DC.NGAYDI = LB.NGAYDI 
JOIN PHANCONG PC ON PC.NGAYDI = LB.NGAYDI AND PC.MACB = LB.MACB
GROUP BY LB.MACB, LB.NGAYDI
HAVING COUNT(DISTINCT DC.MAKH) >= 3
GO

--Q48: Với mỗi loại nhân viên có tổng lương trên 600000, cho biết số lượng nhân	viên trong từng	loại nhân viên đó.
---- Xuất ra loại nhân viên, và số lượng nhân viên tương ứng.
SELECT NV.LOAINV, COUNT(NV.MANV) AS N'SỐ LƯỢNG NHÂN VIÊN'
FROM NHANVIEN NV
GROUP BY NV.LOAINV
HAVING SUM(NV.LUONG) > 600000
GO

--Q49: Với mỗi chuyến bay có trên 3 nhân viên, cho biết mã chuyến bay, và số lượng khách hàng đã đặt chỗ trên chuyến bay đó.
SELECT LB.MACB, COUNT(DISTINCT DC.MAKH) AS N'SỐ LƯỢNG KHÁCH'
FROM DATCHO DC JOIN LICHBAY LB ON DC.MACB = LB.MACB AND DC.NGAYDI = LB.NGAYDI 
JOIN PHANCONG PC ON PC.NGAYDI = LB.NGAYDI AND PC.MACB = LB.MACB
GROUP BY LB.MACB, LB.NGAYDI
HAVING COUNT(DISTINCT PC.MANV) > 3
GO

--Q50: Với mỗi loại máy bay có nhiều hơn 1 chiếc, cho biết số lượng chuyến bay
--đã được bố trí bay bằng loại máy bay đó, xuất ra mã loại và số lượng
SELECT LB.MALOAI, COUNT(*) AS N'SỐ LƯỢNG CHUYẾN BAY'
FROM LICHBAY LB
WHERE LB.MALOAI IN (SELECT MALOAI
            FROM MAYBAY MB
            GROUP BY MALOAI
            HAVING COUNT(*) > 1)
GROUP BY LB.MALOAI
GO
