-- Tạo cơ sở dữ liệu
CREATE DATABASE QUANLYDONHANG;

-- Sử dụng cơ sở dữ liệu
USE QUANLYDONHANG;

-- Tạo bảng KHACHHANG
CREATE TABLE KHACHHANG (
    MaKhachHang INT PRIMARY KEY,
    HoTen VARCHAR(255),
    NgaySinh DATE,
    QueQuan VARCHAR(255),
    GioiTinh VARCHAR(10)
);

-- Tạo bảng NHANVIEN
CREATE TABLE NHANVIEN (
    MaNhanVien INT PRIMARY KEY,
    HoTen VARCHAR(255),
    NamLamViec INT,
    Luong FLOAT
);

-- Tạo bảng DONHANG
CREATE TABLE DONHANG (
    SoHoaDon INT PRIMARY KEY,
    MaKhachHang INT,
    MaNhanVien INT,
    TenSanPham VARCHAR(255),
    SoLuong INT,
    FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang),
    FOREIGN KEY (MaNhanVien) REFERENCES NHANVIEN(MaNhanVien)
);

-- Chèn dữ liệu vào bảng KHACHHANG
INSERT INTO KHACHHANG (MaKhachHang, HoTen, NgaySinh, QueQuan, GioiTinh)
VALUES (1, 'Nguyen Van Anh', '1990-01-01', 'Ha Noi', 'Nam'),
       (2, 'Tran Thi Binh', '1995-05-10', 'Ho Chi Minh', 'Nữ'),
       (3, 'Tran Thi Nhan', '1988-12-20', 'Da Nang', 'Nữ');

-- Chèn dữ liệu vào bảng NHANVIEN
INSERT INTO NHANVIEN (MaNhanVien, HoTen, NamLamViec, Luong)
VALUES (1, 'Pham Van Dong', 2018, 5000000),
       (2, 'Ho Thi Y', 2022, 3500000),
       (3, 'Phan Huy An', 2023, 7000000);

-- Chèn dữ liệu vào bảng DONHANG
INSERT INTO DONHANG (SoHoaDon, MaKhachHang, MaNhanVien, TenSanPham, SoLuong)
VALUES (1, 1, 1, 'Nuoc giai khat', 888888),
       (2, 2, 3, 'My Pham', 1999999),
       (3, 2, 2, 'Do Gia Dung', 333333),
       (4, 3, 1, 'My Pham', 222222);

SELECT * FROM KHACHHANG;
SELECT * FROM NHANVIEN;
SELECT * FROM DONHANG;

SELECT MaKhachHang, Hoten, YEAR(NOW()) - YEAR(NgaySinh) as Tuoi
FROM KHACHHANG
WHERE YEAR(NOW()) - YEAR(NgaySinh) > 18 AND QueQuan = 'Ha Noi';

SELECT MaNhanVien, Hoten, Luong
FROM NHANVIEN
WHERE NamLamViec > 2020 AND Hoten LIKE '%An';

SELECT KHACHHANG.MaKhachHang, KHACHHANG.HoTen, KHACHHANG.GioiTinh
FROM KHACHHANG
JOIN DONHANG ON KHACHHANG.MaKhachHang = DONHANG.MaKhachHang
WHERE DONHANG.TenSanPham = 'My Pham';

SELECT NHANVIEN.MaNhanVien, NHANVIEN.HoTen, COUNT(DONHANG.SoLuong) AS SoLuongSanPham
FROM NHANVIEN
JOIN DONHANG ON NHANVIEN.MaNhanVien = DONHANG.MaNhanVien
GROUP BY NHANVIEN.MaNhanVien, NHANVIEN.HoTen
ORDER BY SoLuongSanPham DESC
LIMIT 1;

UPDATE NHANVIEN
SET NamLamViec = 2021
WHERE Hoten = 'Phan Huy An';

DELETE FROM NHANVIEN
WHERE MaNhanVien NOT IN (
    SELECT MaNhanVien
    FROM DONHANG
);


DELIMITER $$ 
CREATE PROCEDURE ShowOrdersGreaterThan100000()
BEGIN
    SELECT * FROM DONHANG
    WHERE SoLuong > 100000;
END; $$

CALL ShowOrdersGreaterThan100000();

DELIMITER $$
CREATE PROCEDURE ShowCustomersByHometown(IN hometown VARCHAR(255))
BEGIN
    SELECT KHACHHANG.MaKhachHang, KHACHHANG.HoTen, TIMESTAMPDIFF(YEAR, KHACHHANG.NgaySinh, CURDATE()) AS Tuoi, DONHANG.TenSanPham
    FROM KHACHHANG
    JOIN DONHANG ON KHACHHANG.MaKhachHang = DONHANG.MaKhachHang
    WHERE KHACHHANG.QueQuan = hometown;
END; $$

CALL ShowCustomersByHometown("Ha Noi");