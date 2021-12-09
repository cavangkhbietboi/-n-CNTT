create database auctiondata 
;
use auctiondata
;
create table taikhoan(
idTK int not null primary key AUTO_INCREMENT,
Ho nvarchar(20) not null CHECK (Ho !=""),
Ten nvarchar(15) not null CHECK (Ten !=""),
NgaySinh date,
Email nvarchar(50) not null UNIQUE CHECK (Email !=""),
TenDN nvarchar(30) not null CHECK (TenDN !=""),
MatKhau nvarchar(100) not null CHECK (MatKhau !=""),
SDT varchar(15),
Avt varchar(200),
PhanQuyen boolean default false
)
;
ALTER TABLE taikhoan AUTO_INCREMENT = 659323832;
insert into taikhoan (Ho, Ten, Email, TenDN, MatKhau, PhanQuyen) value ('admin', 'admin', 'admin@gmail.com', 'admin', '$2b$10$49gaTiDL9JLsckTIXI2cDekBBDBcHQrwf/oS5yLLr/KPVl6P4APJW', true);
-- update taikhoan set PhanQuyen = true where idTK = 659323832;
-- drop table taikhoan;

create table sanpham(
idSP int not null primary key AUTO_INCREMENT,
HinhAnh varchar(200),
Website nvarchar(100) not null CHECK (Website !=""),
ViTri nvarchar(50) not null CHECK (ViTri !=""),
KichThuoc nvarchar(50) not null CHECK (KichThuoc !=""),
Gia double not null CHECK (Gia !=""),
TrangThai int default 0, -- 0 là còn trong kho, 1 là đang trên kệ đấu giá, 2 là đã bán ;
MoTa text(1000)
)
;-- update sanpham set TrangThai = 0 where TrangThai = 1
-- select * from sanpham s, daugia d where s.idSP = d.idSP and idDG = 21;
-- select s.ViTri, s.KichThuoc, s.Website, s.HinhAnh, g.idGD, g.NgayDG, g.GiaTien, g.ThongTinGD from sanpham s, giaodich g where s.idSP = g.idSP and idTK = 659323833;
-- select s.ViTri, s.KichThuoc, s.Website, s.HinhAnh, s.Gia, d.TgBatDau, d.TgDauGia, d.BuocGia, q.idQT from sanpham s, daugia d, quantam q where s.idSP = d.idSP and q.idDG = d.idDG and idTK =659323833;
-- drop table sanpham;
-- drop table giaodich;
-- drop table daugia;

create table giaodich(
idGD int not null primary key AUTO_INCREMENT,
idSP int  not null CHECK (idSP !=""),
idTK int  not null CHECK (idTK !=""),
NgayDG date,
GiaTien double not null,
TrangThai int default 0, -- 2 la co nguoi mua, 1 la chua co nguoi mua, 0 là trong gio hang của ng mua
ThongTinGD text(1000),
foreign key (idTK) references taikhoan(idTK),
foreign key (idSP) references sanpham(idSP)
)
; -- alter table giaodich add column TrangThai int default 0 after GiaTien;
create table daugia(
idDG int not null primary key AUTO_INCREMENT,
idSP int  not null CHECK (idSP !=""),
TgBatDau datetime not null,
TgDauGia int not null,
TrangThai int default 0, -- 0 là sắp diễn ra, 1 là đang diễn ra, 2 là đã kết thúc ;
BuocGia double,
foreign key (idSP) references sanpham(idSP)
)
;-- drop table daugia; delete from daugia where TrangThai = 0; update sanpham set TrangThai = 0 where TrangThai = 0
-- select * from sanpham s, daugia d where s.idSP = d.idSP and idDG = 20

create table quantam(
idQT int not null primary key AUTO_INCREMENT,
idTK int  not null CHECK (idTK !=""),
idDG int  not null CHECK (idDG !=""),
foreign key (idTK) references taikhoan(idTK),
foreign key (idDG) references daugia(idDG)
);
