-- Kiểm tra xem database có tồn tại hay không
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'QL_BANHTHIEBIDIENTU')
BEGIN
    -- Đóng tất cả các kết nối đến database (nếu có)
    ALTER DATABASE QL_BANHTHIEBIDIENTU SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    -- Xóa database
    DROP DATABASE QL_BANHTHIEBIDIENTU;
END
-- Tạo database mới
CREATE DATABASE QL_BANHTHIEBIDIENTU;

GO

USE QL_BANHTHIEBIDIENTU;

-- Thông báo database đã được tạo thành công
PRINT N'Database QL_BANHTHIEBIDIENTU đã tạo thành công.';

-- Bảng Sản phẩm (thay thế Sách)
CREATE TABLE SanPham (
    id VARCHAR(50) PRIMARY KEY,
    tenSanPham NVARCHAR(255),
    loaiSanPham_id VARCHAR(50),
    gia DECIMAL(10, 2),
    soLuongTon INT,
    hinhAnh VARCHAR(max),
    namSanXuat INT,
    moTa NVARCHAR(max),
    nhaCungCap_id VARCHAR(50)
);

-- Bảng Người dùng
CREATE TABLE NguoiDung (
    id VARCHAR(50) PRIMARY KEY,
    username NVARCHAR(50) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL, -- Mật khẩu (nên được mã hóa)
    gioitinh INT,
    NgaySinh DateTime
);

-- Bảng Vai trò
CREATE TABLE Roles (
    id VARCHAR(50) PRIMARY KEY,
    role_name NVARCHAR(50) NOT NULL UNIQUE
);

-- Bảng Quyền
CREATE TABLE Permissions (
    id VARCHAR(50) PRIMARY KEY,
    permission_name NVARCHAR(50) NOT NULL UNIQUE,
    description NVARCHAR(255)
);

-- Bảng Vai trò - Quyền
CREATE TABLE Role_Permissions (
    role_id VARCHAR(50),
    permission_id VARCHAR(50),
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES Roles(id),
    FOREIGN KEY (permission_id) REFERENCES Permissions(id)
);

-- Bảng Người dùng - Vai trò
CREATE TABLE User_Roles (
    user_id VARCHAR(50),
    role_id VARCHAR(50),
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES NguoiDung(id),
    FOREIGN KEY (role_id) REFERENCES Roles(id)
);

-- Bảng Khách hàng
CREATE TABLE KhachHang (
    id VARCHAR(50) PRIMARY KEY,
    ten NVARCHAR(255),
    diachi NVARCHAR(255),
    sodienthoai VARCHAR(10),
    email VARCHAR(255),
    id_NguoiDung VARCHAR(50)
);

-- Bảng Nhân viên
CREATE TABLE NhanVien (
    id VARCHAR(50) PRIMARY KEY,
    ten NVARCHAR(255),
    chucVu NVARCHAR(255),
    sodienthoai VARCHAR(10),
    email VARCHAR(255),
    id_NguoiDung VARCHAR(50) NULL
);

-- Bảng Đơn đặt hàng
CREATE TABLE DonHang (
    id VARCHAR(50) PRIMARY KEY,
    nguoidung_id VARCHAR(50) null,
    trangthaiDH int DEFAULT 0,
    ngayDatHang DATETIME,
    tongTien DECIMAL(10, 2)
);

-- Bảng Chi tiết đơn hàng
CREATE TABLE ChiTietDonHang (
    id VARCHAR(50) PRIMARY KEY,
    donhang_id VARCHAR(50),
    sanpham_id VARCHAR(50),
    soLuong INT,
    giaDonVi DECIMAL(10, 2)
);

-- Bảng Loại sản phẩm
CREATE TABLE LoaiSanPham (
    id VARCHAR(50) PRIMARY KEY,
    ten NVARCHAR(255)
);

-- Bảng Nhà cung cấp
CREATE TABLE NhaCungCap (
    id VARCHAR(50) PRIMARY KEY,
    ten NVARCHAR(255),
    diachi NVARCHAR(255),
    sodienthoai VARCHAR(10),
    email VARCHAR(255)
);

-- Bảng Hóa đơn
CREATE TABLE HoaDon (
    id VARCHAR(50) PRIMARY KEY,
    donhang_id VARCHAR(50) UNIQUE,
    ngayLap DATETIME,
    tongTien DECIMAL(10, 2),
    phuongThucTT NVARCHAR(50),
    trangthaiTT NVARCHAR(50),
    email NVARCHAR(255),
    sodienthoai VARCHAR(10),
    diachi NVARCHAR(255),
    tenNguoiDatHang NVARCHAR(255)
);

-- Bảng Sản phẩm - Nhà cung cấp (nhiều - nhiều)
CREATE TABLE NhaCungCap_SanPham (
    sanpham_id VARCHAR(50),
    nhacungcap_id VARCHAR(50),
    PRIMARY KEY (sanpham_id, nhacungcap_id)
);

-- Thêm khóa ngoại cho bảng NguoiDung
ALTER TABLE KhachHang
ADD CONSTRAINT FK_KhachHang_NguoiDung
FOREIGN KEY (id_NguoiDung) REFERENCES NguoiDung(id);

ALTER TABLE NhanVien
ADD CONSTRAINT FK_NhanVien_NguoiDung
FOREIGN KEY (id_NguoiDung) REFERENCES NguoiDung(id);

GO

-- Thêm khóa ngoại cho bảng Hóa đơn
ALTER TABLE HoaDon
ADD CONSTRAINT FK_HoaDon_DonHang FOREIGN KEY (donhang_id) REFERENCES DonHang(id);

GO

-- Thêm khóa ngoại cho bảng Sản phẩm (Loại sản phẩm và Nhà cung cấp)
ALTER TABLE SanPham
ADD CONSTRAINT FK_SanPham_LoaiSanPham FOREIGN KEY (loaiSanPham_id) REFERENCES LoaiSanPham(id),
    CONSTRAINT FK_SanPham_NhaCungCap FOREIGN KEY (nhaCungCap_id) REFERENCES NhaCungCap(id);

GO

-- Thêm khóa ngoại cho bảng Đơn hàng (Khách hàng và Nhân viên)
ALTER TABLE DonHang
ADD CONSTRAINT FK_DonHang_KhachHang FOREIGN KEY (nguoidung_id) REFERENCES NguoiDung(id);

GO

-- Thêm khóa ngoại cho bảng Chi tiết đơn hàng (Sản phẩm và Đơn hàng)
ALTER TABLE ChiTietDonHang
ADD CONSTRAINT FK_ChiTietDonHang_SanPham FOREIGN KEY (sanpham_id) REFERENCES SanPham(id),
    CONSTRAINT FK_ChiTietDonHang_DonHang FOREIGN KEY (donhang_id) REFERENCES DonHang(id);

GO

-- Thêm khóa ngoại cho bảng Sản phẩm - Nhà cung cấp (Nhà cung cấp và Sản phẩm)
ALTER TABLE NhaCungCap_SanPham
ADD CONSTRAINT FK_NhaCungCap_SanPham_SanPham FOREIGN KEY (sanpham_id) REFERENCES SanPham(id),
    CONSTRAINT FK_NhaCungCap_SanPham_NhaCungCap FOREIGN KEY (nhacungcap_id) REFERENCES NhaCungCap(id);

