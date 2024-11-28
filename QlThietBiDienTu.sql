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




INSERT INTO NguoiDung (id, username, password,gioitinh,ngaysinh) VALUES
('user123', N'user123', '12345',0,'2000-10-12'),
('user456', N'user456', '12345', 1,'2000-08-23'),
('user789', N'user789', '12345', 0,'1992-03-17'),

('admin123', N'admin123', '12345',1,'1991-01-30'),

('staff123', N'staff123', '12345',1,'1999-04-04'),
('staff456', N'staff456', '12345',0,'1998-05-25'),
('staff789', N'staff789', '12345', '0','2003-07-16');

-- Thêm vai trò
INSERT INTO Roles (id, role_name) VALUES ('R1', 'Admin'), ('R2', 'Staff'), ('R3', 'Customer');

-- Thêm quyền
INSERT INTO Permissions (id, permission_name, description)
VALUES 
('P1', 'Manage_Books', 'Thêm, sửa, xóa sách'),
('P2', 'Manage_Orders', 'Xem và xử lý đơn hàng'),
('P3', 'View_Reports', 'Xem báo cáo doanh thu'),
('P4', 'Place_Order', 'Đặt hàng'),
('P5', 'Manage_Authors', 'Xem, thêm, sửa, xóa tác giả'),
('P6', 'Manage_Publishers', 'Xem, thêm, sửa, xóa nhà xuất bản'),
('P7', 'Manage_Users', 'Xem, thêm, sửa, xóa người dùng'),
('P8', 'View_Order_History', 'Xem lịch sử đơn hàng đã mua');

-- Cập nhật quyền cho Admin
-- Admin có quyền thêm, sửa, xóa sách, tác giả, nhà xuất bản, người dùng
INSERT INTO Role_Permissions (role_id, permission_id)
VALUES 
('R1', 'P1'),  -- Quản lý sách
('R1', 'P2'),  -- Quản lý đơn hàng
('R1', 'P3'),  -- Xem báo cáo
('R1', 'P5'),  -- Quản lý tác giả (thêm, sửa, xóa)
('R1', 'P6'),  -- Quản lý nhà xuất bản (thêm, sửa, xóa)
('R1', 'P7');  -- Quản lý người dùng (thêm, sửa, xóa)

-- Cập nhật quyền cho Staff
-- Staff chỉ có quyền xem và xử lý đơn hàng
-- Quyền tương tự như trước (P2 và P3)
INSERT INTO Role_Permissions (role_id, permission_id)
VALUES 
('R2', 'P2'), -- Xử lý đơn hàng
('R2', 'P3'); -- Xem báo cáo

-- Cập nhật quyền cho User
-- User có quyền xem sản phẩm, nhà xuất bản, tác giả và lịch sử đơn hàng
INSERT INTO Role_Permissions (role_id, permission_id)
VALUES 
('R3', 'P4'), -- Đặt hàng (quyền này đã có)
('R3', 'P5'), -- Xem tác giả
('R3', 'P6'), -- Xem nhà xuất bản
('R3', 'P8'); -- Xem lịch sử đơn hàng (quyền này cần thêm vào bảng Permissions)

-- Gán vai trò cho người dùng
INSERT INTO User_Roles (user_id, role_id)
VALUES 
('user123', 'R3'), -- Người dùng user123 là Customer
('user456', 'R3'), -- Người dùng user456 là Customer
('user789', 'R3'), -- Người dùng user789 là Customer
('admin123', 'R1'), -- Người dùng admin123 là Admin
('staff123', 'R2'), -- Người dùng staff123 là Staff
('staff456', 'R2'), -- Người dùng staff456 là Staff
('staff789', 'R2'); -- Người dùng staff789 là Staff


-- Chèn dữ liệu vào bảng Khachhang
INSERT INTO Khachhang (id, ten, diachi, sodienthoai, email, id_NguoiDung) VALUES
('KH001', N'Nguyễn Văn A', N'123 Đường Trần Hưng Đạo, Hà Nội', '0987654321', 'nguyenvana@example.com', 'user123'),
('KH002', N'Trần Thị B', N'456 Nguyễn Du, Hồ Chí Minh', '0912345678', 'tranthib@example.com', 'user456'),
('KH003', N'Lê Văn C', N'789 Lê Thánh Tôn, Đà Nẵng', '0789456123', 'levanc@example.com', 'user789');

-- Chèn dữ liệu vào bảng NhanVien
INSERT INTO NhanVien (id, ten, chucVu, sodienthoai, email, id_NguoiDung) VALUES
('NV001', N'Phạm Văn D', N'Quản lý', '0901234567', 'phamvand@example.com', 'staff123'),
('NV002', N'Huỳnh Thị E', N'Nhân viên kinh doanh', '0936547890', 'huynhthie@example.com', 'staff456'),
('NV003', N'Đỗ Văn F', N'Nhân viên kỹ thuật', '0775552211', 'dovanf@example.com', 'staff789'),
('NV004', N'Nguyễn Văn G', N'Admin', '0989123456', 'nguyenvang@example.com', 'admin123');
-- Thêm dữ liệu vào bảng Đơn đặt hàng
INSERT INTO DonHang (id, nguoidung_id, trangthaiDH, ngayDatHang, tongTien) VALUES
('DH001', 'user123',0, '2023-03-01', 150000),
('DH002', 'user123', 1, '2023-03-05', 75000),
('DH003', 'admin123', 0, '2023-03-10', 180000),
('DH004', null, 0, '2023-04-12', 110000);


-- Thêm dữ liệu vào bảng Chi tiết đơn hàng
INSERT INTO ChiTietDonHang (id, donhang_id, sach_id, soLuong, giaDonVi) VALUES
('CTDH001', 'DH001', 'S001', 2, 50000),
('CTDH002', 'DH001', 'S002', 1, 75000),
('CTDH003', 'DH002', 'S003', 3, 100000),
('CTDH004', 'DH003', 'S004', 2, 80000),
('CTDH005', 'DH003', 'S005', 1, 90000);


-- Thêm dữ liệu vào bảng Đặt trước

-- Thêm dữ liệu vào bảng Tác giả - Sách
INSERT INTO TacGia_Sach (sach_id, tacgia_id) VALUES
('S001', 'TG001'),
('S002', 'TG002'),
('S003', 'TG003'),
('S004', 'TG004'),
('S005', 'TG005'),
('S006', 'TG006');


CREATE OR ALTER PROCEDURE SP_XoaNguoiDungVaLienQuan
    @NguoiDungId VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RoleId INT;
    DECLARE @RoleName VARCHAR(50);

    -- Lấy role_id và role_name của người dùng
    SELECT @RoleId = ur.role_id, @RoleName = r.role_name
    FROM User_Roles ur
    INNER JOIN Roles r ON ur.role_id = r.id
    WHERE ur.user_id = @NguoiDungId;

    -- Kiểm tra nếu người dùng không tồn tại hoặc không có vai trò
    IF @RoleName IS NULL
    BEGIN
        PRINT 'Người dùng không tồn tại hoặc không có vai trò.';
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Xóa các bản ghi trong bảng ChiTietDonHang nếu tồn tại đơn hàng liên quan
        IF EXISTS (SELECT 1 FROM DonHang WHERE nguoidung_id = @NguoiDungId)
        BEGIN
            DELETE FROM ChiTietDonHang
            WHERE donhang_id IN (SELECT id FROM DonHang WHERE nguoidung_id = @NguoiDungId);
        END

        -- Xóa các bản ghi trong bảng HoaDon nếu tồn tại đơn hàng liên quan
        IF EXISTS (SELECT 1 FROM DonHang WHERE nguoidung_id = @NguoiDungId)
        BEGIN
            DELETE FROM HoaDon
            WHERE donhang_id IN (SELECT id FROM DonHang WHERE nguoidung_id = @NguoiDungId);
        END

        -- Xóa các bản ghi trong bảng DonHang nếu tồn tại
        IF EXISTS (SELECT 1 FROM DonHang WHERE nguoidung_id = @NguoiDungId)
        BEGIN
            DELETE FROM DonHang
            WHERE nguoidung_id = @NguoiDungId;
        END

        -- Xóa người dùng khỏi bảng User_Roles
        DELETE FROM User_Roles WHERE user_id = @NguoiDungId;

        -- Xóa khách hàng hoặc nhân viên dựa trên role_name của người dùng
        IF @RoleName = 'customer'
        BEGIN
            DELETE FROM KhachHang WHERE id_NguoiDung = @NguoiDungId;
        END
        ELSE IF @RoleName IN ('staff', 'admin')
        BEGIN
            DELETE FROM NhanVien WHERE id_NguoiDung = @NguoiDungId;
        END

        -- Xóa người dùng khỏi bảng NguoiDung
        DELETE FROM NguoiDung WHERE id = @NguoiDungId;

        -- Commit transaction nếu không có lỗi
        COMMIT TRANSACTION;

        PRINT 'Xóa người dùng và các bản ghi liên quan thành công.';
    END TRY
    BEGIN CATCH
        -- Rollback transaction nếu có lỗi
        ROLLBACK TRANSACTION;
        PRINT 'Lỗi xảy ra trong quá trình xóa người dùng. Đã rollback.';
    END CATCH
END;
GO

-- STORE PROC LẤY TẤT CẢ THỂ LOẠI
CREATE  PROCEDURE SP_Book_GetAllType
AS
BEGIN
	select *
	from TheLoai
END
GO
-- STORE PROC LẤY THỂ LOẠI theo id
CREATE  PROCEDURE SP_LayThongTinTheLoai @idTL VARCHAR(10)
AS
BEGIN
	select *
	from TheLoai tl
	where tl.id=@idTL
END
GO


CREATE or alter PROCEDURE  SP_LayTrangThaiDonHang  @TrangThai int,@idND VARCHAR(50)
as
begin
select * from DonHang dh  where  dh.trangthaiDH=@TrangThai AND @idND =dh.nguoidung_id
end

exec SP_LayTrangThaiDonHang 0, 'user123'
-- lay chi tietdon hang
CREATE OR ALTER PROCEDURE SP_LayChiTietDonHangTheoSachId
    @OrderID NVARCHAR(50),
    @SachId NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM ChiTietDonHang 
    WHERE donhang_id = @OrderID AND sach_id = @SachId;
END

--  Lấy Chi Tiết Đơn Hàng Theo Đơn Hàng ID

CREATE  PROCEDURE SP_LayChiTietDonHangTheoDH
	@OrderID varchar(50)

AS
BEGIN
	SELECT *
	FROM ChiTietDonHang ct
	WHERE ct.donhang_id = @OrderID
END


--  Lấy Chi Tiết Đơn Hàng Theo Chi Tiết Đơn Hàng ID

CREATE OR ALTER PROCEDURE SP_LayChiTietDonHangTheoID
	@OrderDetailID varchar(50)

AS
BEGIN
	SELECT *
	FROM ChiTietDonHang ct
	WHERE ct.id = @OrderDetailID
END
GO
-- lấy chi tiết thông tin sách
CREATE  PROCEDURE SP_ThongTinSachDuocDatCuaKhTheoId
    @SachId VARCHAR(50)
AS
BEGIN
    SELECT 
        S.id AS SachId,
        S.tieude AS TenSach,
		S.HinhAnh,
		S.Gia,
		S.SoLuongTon,
		S.NamXuatBan,
		S.MoTa,
		S.theloai_id,
        TL.ten AS TenTheLoai,
		STRING_AGG(TG.ten, ', ') AS TenTacGias, -- Sử dụng STRING_AGG
		STRING_AGG(TG.id, ', ') AS TacGiaIds, -- Sử dụng STRING_AGG
		NXB.ten as TenNhaXuatBan,
		NXB.id as NhaXuatBanId
    FROM 
        Sach S
        INNER JOIN TheLoai TL ON S.theloai_id = TL.id
        INNER JOIN TacGia_Sach TGS ON S.id = TGS.sach_id
        INNER JOIN TacGia TG ON TGS.tacgia_id = TG.id
        INNER JOIN NhaXuatBan NXB ON NXB.id = S.nxb_id
    WHERE 
        S.id = @SachId
	GROUP BY
		S.id, S.tieude, S.HinhAnh, S.Gia, S.SoLuongTon, S.NamXuatBan, S.MoTa, S.theloai_id, TL.ten, NXB.ten, NXB.id;
END;

exec SP_ThongTinSachDuocDatCuaKhTheoId 'S001'
-- LẤY SÁCH THEO ĐƠN HÀNG ID
CREATE  PROCEDURE SP_LaySachTheoIdDonHang
    @OrderID VARCHAR(50) -- Tham số đầu vào: ID đơn hàng
AS
BEGIN
    SELECT 
        S.id AS SachId,
        S.tieude AS TenSach,
        S.HinhAnh,
        S.Gia,
        CD.soLuong AS SoLuongDat,
        S.NamXuatBan,
        S.MoTa,
        TL.ten AS TenTheLoai,
        STRING_AGG(TG.ten, ', ') AS TenTacGias, -- Kết hợp tên tác giả bằng dấu phẩy
        NXB.ten AS TenNhaXuatBan,
        NXB.id AS NhaXuatBanId
    FROM 
        ChiTietDonHang CD
        INNER JOIN Sach S ON CD.sach_id = S.id
        INNER JOIN TheLoai TL ON S.theloai_id = TL.id
        INNER JOIN TacGia_Sach TGS ON S.id = TGS.sach_id
        INNER JOIN TacGia TG ON TGS.tacgia_id = TG.id
        INNER JOIN NhaXuatBan NXB ON S.nxb_id = NXB.id
    WHERE 
        CD.donhang_id = @OrderID -- Lọc theo OrderID
    GROUP BY
        S.id, S.tieude, S.HinhAnh, S.Gia, CD.soLuong, S.NamXuatBan, S.MoTa, S.theloai_id, TL.ten, NXB.ten, NXB.id
    ORDER BY
        CD.soLuong DESC; -- Sắp xếp theo số lượng đặt giảm dần
END;


-- Lấy sách theo số lượng tồn
CREATE OR ALTER PROCEDURE SP_SapXepSachTheoSoLuongTon
AS
BEGIN
    SELECT 
	     S.id AS SachId,
        S.tieude AS TenSach,
		S.HinhAnh,
		S.Gia,
		S.SoLuongTon,
		S.NamXuatBan,
		S.MoTa,
		S.theloai_id,
        TL.ten AS TenTheLoai,
		STRING_AGG(TG.ten, ', ') AS TenTacGias, -- Sử dụng STRING_AGG
		STRING_AGG(TG.id, ', ') AS TacGiaIds, -- Sử dụng STRING_AGG
		NXB.ten as TenNhaXuatBan,
		NXB.id as NhaXuatBanId

    FROM 
        Sach S
        INNER JOIN TheLoai TL ON S.theloai_id = TL.id
        INNER JOIN TacGia_Sach TGS ON S.id = TGS.sach_id
        INNER JOIN TacGia TG ON TGS.tacgia_id = TG.id
        INNER JOIN NhaXuatBan NXB ON NXB.id = S.nxb_id

		GROUP BY
		S.id, S.tieude, S.HinhAnh, S.Gia, S.SoLuongTon, S.NamXuatBan, S.MoTa, S.theloai_id, TL.ten, NXB.ten, NXB.id
		order by soLuongTon DESC;

END;
-- lấy chi tiết thông tin sách theo thể loại

CREATE or alter PROCEDURE SP_DanhSachSachTheoTheLoai @TheLoaiId VARCHAR(50)
AS
BEGIN
    SELECT 
        S.id AS SachId,
        S.tieude AS TenSach,
		S.HinhAnh,
		S.Gia,
		S.SoLuongTon,
		S.NamXuatBan,
		S.MoTa,
		S.theloai_id,
        TL.ten AS TenTheLoai,
		STRING_AGG(TG.ten, ', ') AS TenTacGias, -- Sử dụng STRING_AGG
		STRING_AGG(TG.id, ', ') AS TacGiaIds, -- Sử dụng STRING_AGG
		NXB.ten as TenNhaXuatBan,
		NXB.id as NhaXuatBanId

    FROM 
        Sach S
        INNER JOIN TheLoai TL ON S.theloai_id = TL.id
        INNER JOIN TacGia_Sach TGS ON S.id = TGS.sach_id
        INNER JOIN TacGia TG ON TGS.tacgia_id = TG.id
        INNER JOIN NhaXuatBan NXB ON NXB.id = S.nxb_id

    WHERE 
        S.theloai_id = @TheLoaiId
	GROUP BY
		S.id, S.tieude, S.HinhAnh, S.Gia, S.SoLuongTon, S.NamXuatBan, S.MoTa, S.theloai_id, TL.ten, NXB.ten, NXB.id;
END;


-- Lấy tất cả sách

CREATE or alter PROCEDURE SP_DanhSachSach
AS
BEGIN
    SELECT 
	     S.id AS SachId,
        S.tieude AS TenSach,
		S.HinhAnh,
		S.Gia,
		S.SoLuongTon,
		S.NamXuatBan,
		S.MoTa,
		S.theloai_id,
        TL.ten AS TenTheLoai,
		STRING_AGG(TG.ten, ', ') AS TenTacGias, -- Sử dụng STRING_AGG
		STRING_AGG(TG.id, ', ') AS TacGiaIds, -- Sử dụng STRING_AGG
		NXB.ten as TenNhaXuatBan,
		NXB.id as NhaXuatBanId

    FROM 
        Sach S
        INNER JOIN TheLoai TL ON S.theloai_id = TL.id
        INNER JOIN TacGia_Sach TGS ON S.id = TGS.sach_id
        INNER JOIN TacGia TG ON TGS.tacgia_id = TG.id
        INNER JOIN NhaXuatBan NXB ON NXB.id = S.nxb_id

		GROUP BY
		S.id, S.tieude, S.HinhAnh, S.Gia, S.SoLuongTon, S.NamXuatBan, S.MoTa, S.theloai_id, TL.ten, NXB.ten, NXB.id;

END;



-- PROC THANH TOÁN
CREATE SEQUENCE dbo.Seq_HoaDon
    AS INT
    START WITH 1
    INCREMENT BY 1;

CREATE OR ALTER PROCEDURE SP_ThanhToanDonHang
    @DonHangId VARCHAR(50),
    @PhuongThucTT NVARCHAR(50),
    @Email NVARCHAR(255),
    @SoDienThoai VARCHAR(10),
    @DiaChi NVARCHAR(255),
    @TenNguoiDatHang NVARCHAR(255),
    @TongTien DECIMAL(10, 2) OUTPUT
AS
BEGIN
    -- Bắt đầu transaction
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Kiểm tra xem đơn hàng có tồn tại và chưa thanh toán
        IF EXISTS (SELECT 1 FROM DonHang WHERE id = @DonHangId AND trangthaiDH = 0)
        BEGIN
            -- Cập nhật trạng thái đơn hàng thành đã thanh toán
            UPDATE DonHang
            SET trangthaiDH = 1
            WHERE id = @DonHangId;

            -- Lấy tổng tiền của đơn hàng và trả về qua tham số đầu ra
            -- SELECT @TongTien = tongTien FROM DonHang WHERE id = @DonHangId;

            -- Tạo ID cho hóa đơn với tiền tố "HD" và số tự động tăng
            DECLARE @HoaDonId VARCHAR(50);
            SET @HoaDonId = 'HD' + RIGHT('000' + CAST(NEXT VALUE FOR dbo.Seq_HoaDon AS VARCHAR), 4);

            -- Tạo mới hóa đơn cho đơn hàng
            INSERT INTO HoaDon (
                id,
                donhang_id,
                ngayLap,
                tongTien,
                phuongThucTT,
                trangthaiTT,
                email,
                sodienthoai,
                diachi,
                tenNguoiDatHang
            )
            VALUES (
                @HoaDonId,
                @DonHangId,
                GETDATE(),
                @TongTien,
                @PhuongThucTT,
                N'Đặt hàng thành công',
                @Email,
                @SoDienThoai,
                @DiaChi,
                @TenNguoiDatHang
            );

            -- Xác nhận giao dịch
            COMMIT TRANSACTION;
            PRINT 'Thanh toán thành công và hóa đơn đã được tạo.';
        END
        ELSE
        BEGIN
            -- Nếu đơn hàng không tồn tại hoặc đã thanh toán, báo lỗi
            RAISERROR ('Đơn hàng không tồn tại hoặc đã thanh toán.', 16, 1);
            ROLLBACK TRANSACTION;
        END
    END TRY
    BEGIN CATCH
        -- Bắt lỗi nếu có vấn đề
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

-- PROCEDURE: Cập nhật trạng thái đơn hàng và số lượng tồn kho khi đơn hàng được thanh toán.


CREATE PROCEDURE SP_CapNhatDonHang
    @donhang_id VARCHAR(50)
AS
BEGIN
    DECLARE @sach_id VARCHAR(50), @soLuong INT;

    -- Cập nhật trạng thái đơn hàng
    UPDATE DonHang
    SET trangthaiDH = 1 -- Đã thanh toán
    WHERE id = @donhang_id;

    -- Giảm số lượng tồn kho của từng sách trong đơn hàng
    DECLARE cur CURSOR FOR
        SELECT sach_id, soLuong
        FROM ChiTietDonHang
        WHERE donhang_id = @donhang_id;

    OPEN cur;
    FETCH NEXT FROM cur INTO @sach_id, @soLuong;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE Sach
        SET soLuongTon = soLuongTon - @soLuong
        WHERE id = @sach_id;

        FETCH NEXT FROM cur INTO @sach_id, @soLuong;
    END;
    CLOSE cur;
    DEALLOCATE cur;
END;


-- Stored Procedure để cập nhật đơn hàng, đặt ngày đặt hàng là ngày hiện tại

CREATE  PROCEDURE SP_UpdateDonHang
    @id VARCHAR(50),
    @nguoidung_id VARCHAR(50) = NULL,
    @trangthaiDH INT = NULL,
    @tongTien DECIMAL(10, 2) = NULL
AS
BEGIN
    -- Kiểm tra xem đơn hàng tồn tại hay không
    IF NOT EXISTS (SELECT 1 FROM DonHang WHERE id = @id)
    BEGIN
        RAISERROR('Đơn hàng không tồn tại.', 16, 1)
        RETURN 0
    END

    -- Cập nhật các trường dữ liệu
	-- Đặt ngày đặt hàng là ngày hiện tại
	DECLARE @ngayDatHang DATETIME = GETDATE();

    UPDATE DonHang
    SET
        nguoidung_id = ISNULL(@nguoidung_id, nguoidung_id),
        trangthaiDH = ISNULL(@trangthaiDH, trangthaiDH),
        ngayDatHang = @ngayDatHang,  -- Sử dụng biến @ngayDatHang
        tongTien = ISNULL(@tongTien, tongTien)
    WHERE
        id = @id;



    RETURN 1;
END;
-- Stored Procedure để cập nhật chi tiết đơn hàng
CREATE PROCEDURE SP_UpdateChiTietDonHang
    @id VARCHAR(50),
    @donhang_id VARCHAR(50) = NULL,
    @sach_id VARCHAR(50) = NULL,
    @soLuong INT = NULL,
    @giaDonVi DECIMAL(10, 2) = NULL
AS
BEGIN
    -- Kiểm tra xem chi tiết đơn hàng tồn tại hay không
    IF NOT EXISTS (SELECT 1 FROM ChiTietDonHang WHERE id = @id)
    BEGIN
        RAISERROR('Chi tiết đơn hàng không tồn tại.', 16, 1)
        RETURN
    END

    -- Cập nhật các trường dữ liệu nếu giá trị truyền vào khác NULL
    UPDATE ChiTietDonHang
    SET
        donhang_id = ISNULL(@donhang_id, donhang_id),
        sach_id = ISNULL(@sach_id, sach_id),
        soLuong = ISNULL(@soLuong, soLuong),
        giaDonVi = ISNULL(@giaDonVi, giaDonVi)
    WHERE
        id = @id;
    
    -- Kiểm tra dữ liệu sau cập nhật
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('Không có thay đổi được thực hiện.', 16, 1)
        RETURN 1;  -- Trả về mã lỗi khác 0
    END

    -- Trả về thông tin chi tiết đơn hàng cập nhật (tùy chọn)
    SELECT *
    FROM ChiTietDonHang
    WHERE id = @id;

    RETURN 0; -- Trả về 0 nếu cập nhật thành công
END;
-- Store procedure xóa hóa đơn
CREATE OR ALTER PROCEDURE SP_DeleteHoaDonVaCapNhatDonHang
    @hoaDonId VARCHAR(50)
AS
BEGIN
    -- Bắt đầu một giao dịch để đảm bảo tính toàn vẹn dữ liệu
    BEGIN TRANSACTION;

    -- Lấy DonHangId từ hóa đơn trước khi xóa
    DECLARE @donHangId VARCHAR(50);
    SELECT @donHangId = donhang_id FROM HoaDon WHERE id = @hoaDonId;

    -- Kiểm tra nếu hóa đơn tồn tại và lấy các chi tiết đơn hàng (sách và số lượng)
    DECLARE @SachId VARCHAR(50);
    DECLARE @SoLuong INT;

    -- Duyệt qua các chi tiết của hóa đơn để trả lại số lượng sách vào kho
    DECLARE ChiTietCursor CURSOR FOR
        SELECT ct.sach_id, ct.soLuong
        FROM ChiTietDonHang ct
        JOIN HoaDon hd ON ct.donhang_id = hd.donhang_id
        WHERE hd.id = @hoaDonId;

    OPEN ChiTietCursor;
    FETCH NEXT FROM ChiTietCursor INTO @SachId, @SoLuong;

    -- Cập nhật số lượng tồn kho của sách
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Tăng số lượng tồn kho của sách
        UPDATE Sach
        SET soLuongTon = soLuongTon + @SoLuong
        WHERE id = @SachId;

        FETCH NEXT FROM ChiTietCursor INTO @SachId, @SoLuong;
    END

    -- Đóng con trỏ
    CLOSE ChiTietCursor;
    DEALLOCATE ChiTietCursor;

    -- Xóa hóa đơn
    DELETE FROM HoaDon WHERE id = @hoaDonId;

    -- Cập nhật trạng thái đơn hàng thành 0 (chưa thanh toán) nếu đơn hàng có tồn tại
    IF @donHangId IS NOT NULL
    BEGIN
        UPDATE DonHang
        SET trangthaiDH = 0
        WHERE id = @donHangId;
    END

    -- Kiểm tra và hoàn thành giao dịch
    IF @@ERROR = 0
    BEGIN
        COMMIT TRANSACTION;
    END
    ELSE
    BEGIN
        ROLLBACK TRANSACTION;
    END
END

-- store procedure xóa ctdh
CREATE PROCEDURE SP_DeleteChiTietDonHang
    @id VARCHAR(50)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM ChiTietDonHang WHERE id = @id)
        RETURN 1;  -- Lỗi: Không tồn tại

    DELETE FROM ChiTietDonHang WHERE id = @id;
    IF @@ROWCOUNT = 0
        RETURN 2;  -- Lỗi: Không có dòng nào bị xóa

    RETURN 0; -- Thành công
END;
-- PROC TAO DON HANG

CREATE  PROCEDURE SP_TaoDonHang
    @IDND NVARCHAR(50),
    @OrderPrice DECIMAL(18, 2),
    @OrderStatus INT,
    @NGAYDATHANG DATETIME = NULL -- tham số ngày đặt hàng
AS
BEGIN
    -- Nếu @NGAYDATHANG không được truyền vào, sử dụng ngày hiện tại
    IF @NGAYDATHANG IS NULL
    BEGIN
        SET @NGAYDATHANG = GETDATE(); -- Lấy ngày giờ hiện tại
    END

    DECLARE @NewOrderID NVARCHAR(50);
    DECLARE @MaxID NVARCHAR(50);

    -- Lấy giá trị id lớn nhất hiện tại trong bảng DonHang
    SELECT @MaxID = MAX(id) FROM DonHang WHERE id LIKE 'DH%';

    -- Kiểm tra nếu không có id nào, đặt giá trị khởi tạo là 'DH001'
    IF @MaxID IS NULL
    BEGIN
        SET @NewOrderID = 'DH001';
    END
    ELSE
    BEGIN
        -- Lấy phần số trong id, tăng số lên 1 và tạo lại id mới
        SET @NewOrderID = 'DH' + RIGHT('000' + CAST(CAST(SUBSTRING(@MaxID, 3, LEN(@MaxID)) AS INT) + 1 AS VARCHAR), 3);
    END

    -- Thực hiện INSERT vào bảng DonHang
    INSERT INTO DonHang (id, nguoidung_id, tongTien, trangthaiDH, ngayDatHang)
    VALUES (@NewOrderID, @IDND, @OrderPrice, @OrderStatus, @NGAYDATHANG);
    
END;

exec SP_TaoDonHang 'admin123',0,0
-- PROC TẠO CTHDH
CREATE PROCEDURE SP_TaoChiTietDonHang
    @OrderID NVARCHAR(50),
    @SachId NVARCHAR(50),
    @SoLuong INT,
    @GiaDonVi DECIMAL(10, 2)
AS
BEGIN
    -- Tạo ID mới cho ChiTietDonHang, bắt đầu với 'CTDH' và theo sau là giá trị số tự động
    DECLARE @NewId NVARCHAR(50);
    SET @NewId = 'CTDH' + CAST((SELECT ISNULL(MAX(CAST(SUBSTRING(Id, 5, LEN(Id)) AS INT)), 0) + 1 FROM ChiTietDonHang) AS NVARCHAR(50));

    -- Thực hiện INSERT vào bảng ChiTietDonHang
    INSERT INTO ChiTietDonHang (Id, donhang_id, sach_id, soLuong, giaDonVi)
    VALUES (@NewId, @OrderID, @SachId, @SoLuong, @GiaDonVi);
END;

-- PROC THEM SACH
CREATE OR ALTER PROCEDURE SP_ThemSach
    @TieuDe NVARCHAR(255),
    @TheLoaiID VARCHAR(50),
    @Gia DECIMAL(10, 2),
    @SoLuongTon INT,
    @HinhAnh VARCHAR(MAX),
    @NamXuatBan INT,
    @MoTa NVARCHAR(MAX),
    @NXB_ID VARCHAR(50),
    @TacGiaIDList NVARCHAR(MAX) -- Danh sách các ID tác giả, phân cách bởi dấu phẩy
AS
BEGIN
    SET NOCOUNT ON;

    -- Tạo ID cho sách tự động
    DECLARE @SachID VARCHAR(50);
    DECLARE @MaxSachID INT;

    -- Lấy số lượng sách hiện tại và xác định ID sách tiếp theo
    SELECT @MaxSachID = COUNT(*) + 1 FROM Sach; -- Tính số sách hiện tại và thêm 1 cho ID tiếp theo

    -- Tạo SachID theo định dạng SP001, SP002, ...
    SET @SachID = 'SP' + RIGHT('000' + CAST(@MaxSachID AS VARCHAR), 3);

    -- Thêm thông tin sách vào bảng Sach
    INSERT INTO Sach (id, tieude, theloai_id, gia, soLuongTon, hinhAnh, namXuatBan, MoTa, nxb_id)
    VALUES (@SachID, @TieuDe, @TheLoaiID, @Gia, @SoLuongTon, @HinhAnh, @NamXuatBan, @MoTa, @NXB_ID);

    -- Sử dụng CURSOR để thêm các tác giả vào bảng TacGia_Sach
    DECLARE @TacGiaID VARCHAR(50);
    DECLARE TacGiaCursor CURSOR FOR
    SELECT value
    FROM STRING_SPLIT(@TacGiaIDList, ',');

    -- Mở CURSOR
    OPEN TacGiaCursor;

    -- Lặp qua từng tác giả trong danh sách và thêm vào TacGia_Sach
    FETCH NEXT FROM TacGiaCursor INTO @TacGiaID;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO TacGia_Sach (sach_id, tacgia_id)
        VALUES (@SachID, @TacGiaID);

        FETCH NEXT FROM TacGiaCursor INTO @TacGiaID;
    END

    -- Đóng và hủy CURSOR
    CLOSE TacGiaCursor;
    DEALLOCATE TacGiaCursor;

    PRINT 'Thêm sách thành công với ID: ' + @SachID;
END;


-- PROC CAP NHAT SACH
CREATE PROCEDURE SP_UpdateThongTinSach
    @SachID VARCHAR(50),
    @TieuDe NVARCHAR(255),
    @TheLoaiID VARCHAR(50),
    @Gia DECIMAL(10, 2),
    @SoLuongTon INT,
    @HinhAnh VARCHAR(MAX),
    @NamXuatBan INT,
    @MoTa NVARCHAR(MAX),
    @NXB_ID VARCHAR(50),
    @TacGiaIDList NVARCHAR(MAX) -- Danh sách các ID tác giả, phân cách bởi dấu phẩy
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra xem sách có tồn tại hay không
    IF NOT EXISTS (SELECT 1 FROM Sach WHERE id = @SachID)
    BEGIN
        PRINT 'Sách không tồn tại.';
        RETURN;
    END

    -- Cập nhật thông tin chi tiết của sách trong bảng Sach
    UPDATE Sach
    SET 
        tieude = @TieuDe,
        theloai_id = @TheLoaiID,
        gia = @Gia,
        soLuongTon = @SoLuongTon,
        hinhAnh = @HinhAnh,
        namXuatBan = @NamXuatBan,
        MoTa = @MoTa,
        nxb_id = @NXB_ID
    WHERE 
        id = @SachID;

    -- Xóa các tác giả hiện tại của sách trong bảng TacGia_Sach
    DELETE FROM TacGia_Sach WHERE sach_id = @SachID;

    -- Sử dụng CURSOR để thêm các tác giả mới vào bảng TacGia_Sach
    DECLARE @TacGiaID VARCHAR(50);
    DECLARE TacGiaCursor CURSOR FOR
    SELECT value
    FROM STRING_SPLIT(@TacGiaIDList, ',');

    -- Mở CURSOR
    OPEN TacGiaCursor;

    -- Lặp qua từng tác giả trong danh sách và thêm vào TacGia_Sach
    FETCH NEXT FROM TacGiaCursor INTO @TacGiaID;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO TacGia_Sach (sach_id, tacgia_id)
        VALUES (@SachID, @TacGiaID);

        FETCH NEXT FROM TacGiaCursor INTO @TacGiaID;
    END

    -- Đóng và hủy CURSOR
    CLOSE TacGiaCursor;
    DEALLOCATE TacGiaCursor;

    PRINT 'Cập nhật thông tin sách thành công.';
END;
-- PROC XOA SACH
CREATE PROCEDURE SP_XoaSach
    @SachID VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra xem sách có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM Sach WHERE id = @SachID)
    BEGIN
        PRINT 'Sách không tồn tại.';
        RETURN;
    END

    -- Xóa các tác giả liên quan đến sách trong bảng TacGia_Sach
    DELETE FROM TacGia_Sach WHERE sach_id = @SachID;

    -- Xóa sách trong bảng Sach
    DELETE FROM Sach WHERE id = @SachID;

    PRINT 'Xóa sách thành công.';
END;

-- PROC ĐẶT HÀNG THÀNH CÔNG
CREATE PROCEDURE SP_DatHangThanhCong
    @donhang_id VARCHAR(50)
AS
BEGIN
    -- Bắt đầu transaction để đảm bảo tính toàn vẹn dữ liệu
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Bước 1: Cập nhật trạng thái đơn hàng thành "1" (Đã đặt hàng thành công)
        UPDATE DonHang
        SET trangthaiDH = 1
        WHERE id = @donhang_id;

        -- Bước 2: Khai báo các biến để lưu mã sách và số lượng sách trong từng dòng chi tiết của đơn hàng
        DECLARE @sach_id VARCHAR(50);
        DECLARE @soLuong INT;

        -- Bước 3: Khai báo cursor để duyệt qua từng dòng trong bảng ChiTietDonHang của đơn hàng
        DECLARE sach_cursor CURSOR FOR
        SELECT sach_id, soLuong
        FROM ChiTietDonHang
        WHERE donhang_id = @donhang_id;

        OPEN sach_cursor;

        -- Bước 4: Duyệt qua từng dòng và cập nhật số lượng tồn kho của sách
        FETCH NEXT FROM sach_cursor INTO @sach_id, @soLuong;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Kiểm tra xem sách có đủ tồn kho không
            IF (SELECT soLuongTon FROM Sach WHERE id = @sach_id) >= @soLuong
            BEGIN
                -- Nếu đủ tồn kho, tiến hành trừ số lượng tồn kho
                UPDATE Sach
                SET soLuongTon = soLuongTon - @soLuong
                WHERE id = @sach_id;
            END
            ELSE
            BEGIN
                -- Nếu không đủ tồn kho, thông báo lỗi và rollback transaction
                RAISERROR ('Số lượng tồn kho của sách %s không đủ để thực hiện đơn hàng', 16, 1, @sach_id);
                ROLLBACK TRANSACTION;
                RETURN;
            END

            -- Tiếp tục duyệt qua dòng tiếp theo
            FETCH NEXT FROM sach_cursor INTO @sach_id, @soLuong;
        END;

        -- Đóng và giải phóng cursor
        CLOSE sach_cursor;
        DEALLOCATE sach_cursor;

        -- Nếu tất cả đều thành công, commit transaction
        COMMIT TRANSACTION;
        
        PRINT 'Đặt hàng thành công và cập nhật số lượng tồn kho.';
    END TRY
    BEGIN CATCH
        -- Xử lý lỗi và rollback nếu có lỗi
        ROLLBACK TRANSACTION;
        
        -- Lấy thông tin lỗi
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Thông báo lỗi
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
-- FUNTION
CREATE FUNCTION fn_TongTienDonHang(@donhang_id NVARCHAR(50))
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TongTien DECIMAL(18, 2);

    SELECT @TongTien = SUM(cd.soLuong * cd.giaDonVi)
    FROM ChiTietDonHang cd
    WHERE cd.donhang_id = @donhang_id;

    RETURN ISNULL(@TongTien, 0);
END;

CREATE FUNCTION FnKiemTraSachSapHetHang()
RETURNS TABLE
AS
RETURN
(
    SELECT id, tieude, soLuongTon
    FROM Sach
    WHERE soLuongTon < 10
);
-- D) FUNCTION: Tính tổng số lượng sách đã bán của một mã sách cụ thể.
DROP FUNCTION IF EXISTS dbo.FnTinhTongSoLuongSachDaBan;

CREATE FUNCTION dbo.FnTinhTongSoLuongSachDaBan (@SachId VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @TongSoLuong INT;

    -- Tính tổng số lượng sách đã bán cho mã sách cụ thể khi trạng thái hóa đơn là 1 (thành công)
    SELECT @TongSoLuong = SUM(ctd.soLuong) 
    FROM ChiTietDonHang ctd
    JOIN DonHang dh ON ctd.donhang_id = dh.id
    WHERE ctd.sach_id = @SachId
    AND dh.trangthaiDH = '1';  -- '1' là trạng thái đã thanh toán thành công

    -- Nếu không có đơn hàng nào thì trả về 0
    IF @TongSoLuong IS NULL
    BEGIN
        SET @TongSoLuong = 0;
    END

    RETURN @TongSoLuong;
END;

SELECT dbo.FnTinhTongSoLuongSachDaBan('S004');


-- PROC LOGIN
CREATE OR ALTER PROCEDURE SP_LOGIN
    @Username NVARCHAR(50),
    @Password NVARCHAR(255),
    @UserRole NVARCHAR(MAX) OUTPUT, -- Trả về danh sách các vai trò (nếu có nhiều vai trò)
    @FullName NVARCHAR(255) OUTPUT, -- Trả về tên người dùng
    @UserId NVARCHAR(50) OUTPUT      -- Trả về ID người dùng
AS
BEGIN
    -- Lấy thông tin người dùng
    SELECT 
        @UserId = NguoiDung.id,
        @FullName = CASE
                        WHEN EXISTS (SELECT 1 FROM Khachhang WHERE id_NguoiDung = NguoiDung.id) 
                        THEN (SELECT ten FROM Khachhang WHERE id_NguoiDung = NguoiDung.id)
                        WHEN EXISTS (SELECT 1 FROM NhanVien WHERE id_NguoiDung = NguoiDung.id) 
                        THEN (SELECT ten FROM NhanVien WHERE id_NguoiDung = NguoiDung.id)
                        ELSE NULL
                    END
    FROM NguoiDung
    WHERE username = @Username AND password = @Password;

    -- Kiểm tra nếu không tìm thấy thông tin người dùng
    IF @UserId IS NULL
    BEGIN
        RAISERROR('Tên người dùng hoặc mật khẩu không chính xác.', 16, 1);
        RETURN;
    END

    -- Lấy danh sách các vai trò của người dùng
    SELECT 
        @UserRole =  Roles.role_name
    FROM User_Roles
    INNER JOIN Roles ON User_Roles.role_id = Roles.id
    WHERE User_Roles.user_id = @UserId;

    -- Kiểm tra nếu không có vai trò nào được gán
    IF @UserRole IS NULL
    BEGIN
        RAISERROR('Người dùng chưa được gán vai trò.', 16, 1);
        RETURN;
    END

    PRINT N'Đăng nhập thành công.';
END;


DECLARE @Role NVARCHAR(MAX);
DECLARE @FullName NVARCHAR(255);
DECLARE @UserId NVARCHAR(50);

EXEC SP_LOGIN 
    @Username = 'admin123',
    @Password = '12345',
    @UserRole = @Role OUTPUT,
    @FullName = @FullName OUTPUT,
    @UserId = @UserId OUTPUT;

-- Kết quả trả về
PRINT 'User Role: ' + @Role;
PRINT 'Full Name: ' + @FullName;
PRINT 'User ID: ' + @UserId;
-- procedure lấy danh sách nhà xuất bản

CREATE PROCEDURE SP_DanhSachNXB
AS
BEGIN
    SELECT id, ten, diachi, sodienthoai, email
    FROM NhaXuatBan;
END;

-- procedure lấy danh sách tác giá

CREATE PROCEDURE SP_DanhSachTacGia
AS
BEGIN
    SELECT * 
    FROM TacGia;
END;


exec SP_DanhSachTacGia


-- procedure

-- 


-- thêm kh
CREATE PROCEDURE ThemKH
    @id VARCHAR(50),
    @ten VARCHAR(255),
    @diachi VARCHAR(255),
    @sodienthoai VARCHAR(10),
    @email VARCHAR(255)
AS
BEGIN
    INSERT INTO Khachhang (id, ten, diachi, sodienthoai, email)
    VALUES (@id, @ten, @diachi, @sodienthoai, @email);
END;



-- cập nhật hàng tồn kho

CREATE PROCEDURE UpdateTonKho
    @sach_id VARCHAR(50),
    @soLuong INT
AS
BEGIN
    UPDATE Sach
    SET soLuongTon = soLuongTon + @soLuong
    WHERE id = @sach_id;
END;


-- lấy thông tin sách theo id

CREATE PROCEDURE HienThiSachId
    @id VARCHAR(50)
AS
BEGIN
    SELECT * FROM Sach
    WHERE id = @id;
END;



-- Lay sach duoc dat nhieu nhat



-- Tìm Sách Theo Từ Khóa Trong Tiêu Đề
CREATE PROCEDURE TimSachTheoTuKhoa
    @keyword NVARCHAR(255)
AS
BEGIN
    SELECT * FROM Sach
    WHERE tieude LIKE '%' + @keyword + '%';
END;

--  Tính Tổng Số Sách Theo Thể Loại
CREATE PROCEDURE TongSachTL
    @genre_id VARCHAR(50)
AS
BEGIN
    SELECT COUNT(*) AS TongSoSach
    FROM Sach
    WHERE theloai_id = @genre_id;
END;


-- lay doanh thu theo tháng

--  Lấy Các Đơn Hàng Chưa Thanh Toán Trong Khoảng Thời Gian
-------------------------------- CURSOR




-- Lấy thông tin tài khoản



-- FUNCTION: Tính tổng doanh thu từ tất cả các đơn hàng đã thanh toán.
CREATE FUNCTION fn_TongDoanhThu()
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @tongDoanhThu DECIMAL(10, 2);

    SELECT @tongDoanhThu = SUM(tongTien)
    FROM DonHang
    WHERE trangthaiDH = 1; -- Đã thanh toán

    RETURN @tongDoanhThu;
END;


-- Tìm kiếm sách theo thể loại và khoảng giá.

CREATE PROCEDURE sp_TimSachTheoTheLoaiGia
    @theloai_id VARCHAR(50),
    @giaMin DECIMAL(10, 2),
    @giaMax DECIMAL(10, 2)
AS
BEGIN
    SELECT *
    FROM Sach
    WHERE theloai_id = @theloai_id
      AND gia BETWEEN @giaMin AND @giaMax;
END;


-- PROCEDURE: Lấy danh sách khách hàng theo tổng giá trị đơn hàng đã mua.

CREATE PROCEDURE sp_LayDanhSachKhachHangTheoGiaTri
    @minValue DECIMAL(10, 2),
    @maxValue DECIMAL(10, 2)
AS
BEGIN
    SELECT k.ten, k.diachi, k.sodienthoai, SUM(d.tongTien) AS TongGiaTriMua
    FROM Khachhang k
    JOIN DonHang d ON k.id = d.nguoidung_id
    WHERE d.trangthaiDH = 1 -- Đã thanh toán
    GROUP BY k.ten, k.diachi, k.sodienthoai
    HAVING SUM(d.tongTien) BETWEEN @minValue AND @maxValue;
END;


-- Kiểm tra số lượng tồn kho của sách.
CREATE FUNCTION fn_KiemTraTonKho(@sach_id VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @soLuongTon INT;

    SELECT @soLuongTon = soLuongTon
    FROM Sach
    WHERE id = @sach_id;

    RETURN @soLuongTon;
END;


-- CURSOR: Tạo danh sách top 5 sách bán chạy nhất.

CREATE PROCEDURE sp_TopSachBanChay
AS
BEGIN
    DECLARE @sach_id VARCHAR(50), @tongSoLuong INT;

    DECLARE cur CURSOR FOR
        SELECT TOP 5 sach_id, SUM(soLuong) AS tongSoLuong
        FROM ChiTietDonHang
        GROUP BY sach_id
        ORDER BY tongSoLuong DESC;

    OPEN cur;
    FETCH NEXT FROM cur INTO @sach_id, @tongSoLuong;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'Sách ID: ' + @sach_id + ', Số lượng đã bán: ' + CAST(@tongSoLuong AS VARCHAR);

        FETCH NEXT FROM cur INTO @sach_id, @tongSoLuong;
    END;
    CLOSE cur;
    DEALLOCATE cur;
END;



   SELECT hd.id, hd.donhang_id, hd.ngayLap, hd.tongTien, hd.phuongThucTT, 
          hd.trangthaiTT, hd.email, hd.sodienthoai, hd.diachi, hd.tenNguoiDatHang
   FROM HoaDon hd
   INNER JOIN DonHang dh ON hd.donhang_id = dh.id
   WHERE dh.nguoidung_id = @hoadonid





