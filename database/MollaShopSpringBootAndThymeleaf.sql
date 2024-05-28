USE [master]
GO
/****** Object:  Database [MollaShop]    Script Date: 22/03/2023 9:34:08 SA ******/
CREATE DATABASE [MollaShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MollaShop', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\MollaShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MollaShop_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\MollaShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MollaShop] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MollaShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MollaShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MollaShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MollaShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MollaShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MollaShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [MollaShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MollaShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MollaShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MollaShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MollaShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MollaShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MollaShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MollaShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MollaShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MollaShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MollaShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MollaShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MollaShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MollaShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MollaShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MollaShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MollaShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MollaShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MollaShop] SET  MULTI_USER 
GO
ALTER DATABASE [MollaShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MollaShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MollaShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MollaShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MollaShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MollaShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [MollaShop] SET QUERY_STORE = OFF
GO
USE [MollaShop]
GO
/****** Object:  Table [dbo].[brands]    Script Date: 22/03/2023 9:34:08 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brands](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[last_modified_date] [datetime2](7) NULL,
	[name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 22/03/2023 9:34:08 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[last_modified_date] [datetime2](7) NULL,
	[name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[image_product]    Script Date: 22/03/2023 9:34:08 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[image_product](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](max) NULL,
	[product_id] [bigint] NULL,
 CONSTRAINT [PK__image_pr__3213E83F1640BDDD] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[likes]    Script Date: 22/03/2023 9:34:08 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[likes](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[last_modified_date] [datetime2](7) NULL,
	[product_id] [bigint] NULL,
	[user_id] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_address]    Script Date: 22/03/2023 9:34:08 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_address](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[last_modified_date] [datetime2](7) NULL,
	[address] [nvarchar](255) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[phone] [varchar](11) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_details]    Script Date: 22/03/2023 9:34:08 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_details](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[banner] [varchar](max) NULL,
	[discount] [float] NULL,
	[name] [nvarchar](max) NULL,
	[price] [float] NULL,
	[quantity] [int] NULL,
	[size] [varchar](50) NULL,
	[order_id] [bigint] NULL,
	[product_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 22/03/2023 9:34:08 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[last_modified_date] [datetime2](7) NULL,
	[note] [nvarchar](max) NULL,
	[pay] [int] NULL,
	[ship] [int] NULL,
	[status] [int] NULL,
	[order_address_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 22/03/2023 9:34:08 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[last_modified_date] [datetime2](7) NULL,
	[banner] [varchar](max) NULL,
	[color] [varchar](255) NULL,
	[description] [nvarchar](max) NULL,
	[discount] [float] NULL,
	[end_day_discount] [datetime2](7) NULL,
	[info] [nvarchar](max) NULL,
	[name] [nvarchar](max) NULL,
	[price] [bigint] NULL,
	[quantity] [int] NULL,
	[start_day_discount] [datetime2](7) NULL,
	[views] [int] NULL,
	[brand_id] [bigint] NULL,
	[category_id] [bigint] NULL,
 CONSTRAINT [PK__products__3213E83FFC19A5BB] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 22/03/2023 9:34:08 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [varchar](255) NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[last_modified_date] [datetime2](7) NULL,
	[address] [nvarchar](255) NULL,
	[avatar] [varchar](max) NULL,
	[birth_day] [datetime2](7) NULL,
	[email] [varchar](50) NOT NULL,
	[first_name] [nvarchar](50) NULL,
	[gender] [bit] NULL,
	[last_login_date] [datetime2](7) NULL,
	[last_name] [nvarchar](50) NULL,
	[login] [bit] NOT NULL,
	[password] [varchar](max) NOT NULL,
	[role] [varchar](255) NULL,
	[username] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[brands] ON 
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (N'1', CAST(N'2023-03-11 15:52:49.7310000' AS Datetime),CAST(N'2023-03-11 15:52:49.7310000' AS Datetime), N'Samsung')
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (N'2', CAST(N'2023-03-12 15:53:01.8050000' AS Datetime),CAST(N'2023-03-12 15:53:01.8050000' AS Datetime), N'Apple')
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (N'3', CAST(N'2023-03-10 15:53:35.1050000' AS Datetime),CAST(N'2023-03-10 15:53:35.1050000' AS Datetime), N'Oppo')
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (N'4', CAST(N'2023-03-09 15:53:59.1660000' AS Datetime),CAST(N'2023-03-09 15:53:59.1660000' AS Datetime), N'Vivo')
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (N'5', CAST(N'2023-03-08 15:54:49.7310000' AS Datetime),CAST(N'2023-03-08 15:52:49.7310000' AS Datetime), N'Dell')
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (N'6', CAST(N'2023-04-08 15:55:46.7310000' AS Datetime),CAST(N'2023-04-08 15:55:46.7310000' AS Datetime), N'Acer')
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (N'7', CAST(N'2023-04-09 15:56:43.7310000' AS Datetime),CAST(N'2023-04-09 15:56:43.7310000' AS Datetime), N'Asus')
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (N'8', CAST(N'2023-04-10 15:57:44.7310000' AS Datetime),CAST(N'2023-04-10 15:57:44.7310000' AS Datetime), N'Lenovo')
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (N'9', CAST(N'2023-04-11 15:57:47.7310000' AS Datetime),CAST(N'2023-04-11 15:57:47.7310000' AS Datetime), N'Xiaomi')
SET IDENTITY_INSERT [dbo].[brands] OFF
GO
SET IDENTITY_INSERT [dbo].[categories] ON 
INSERT [dbo].[categories] ([id], [created_date], [last_modified_date], [name]) VALUES (N'12', CAST(N'2023-03-11 15:52:49.7310000' AS Datetime),CAST(N'2023-03-11 15:52:49.7310000' AS Datetime), N'Laptop, Laptop Gaming')
INSERT [dbo].[categories] ([id], [created_date], [last_modified_date], [name]) VALUES (N'13', CAST(N'2023-03-12 15:52:49.7310000' AS Datetime),CAST(N'2023-03-12 15:52:49.7310000' AS Datetime), N'Smartphone')
INSERT [dbo].[categories] ([id], [created_date], [last_modified_date], [name]) VALUES (N'14', CAST(N'2023-03-10 15:52:49.7310000' AS Datetime),CAST(N'2023-03-10 15:52:49.7310000' AS Datetime), N'Đồng hồ')
INSERT [dbo].[categories] ([id], [created_date], [last_modified_date], [name]) VALUES (N'15', CAST(N'2023-03-09 15:52:49.7310000' AS Datetime),CAST(N'2023-03-09 15:52:49.7310000' AS Datetime), N'Ốp lưng')
INSERT [dbo].[categories] ([id], [created_date], [last_modified_date], [name]) VALUES (N'16', CAST(N'2023-03-08 15:52:49.7310000' AS Datetime),CAST(N'2023-03-08 15:52:49.7310000' AS Datetime), N'Củ sạc')
INSERT [dbo].[categories] ([id], [created_date], [last_modified_date], [name]) VALUES (N'17', CAST(N'2023-04-12 15:52:49.7310000' AS Datetime),CAST(N'2023-04-12 15:52:49.7310000' AS Datetime), N'Máy tính bảng')
SET IDENTITY_INSERT [dbo].[categories] OFF
GO
SET IDENTITY_INSERT [dbo].[immage_product] ON 
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (01, N'lap1.jpg', 3)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (02, N'hinh0.1.jpg', 7)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (03, N'hinh3.jpg', 6)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (04, N'lap3.jpg', 1)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (05, N'lap6.jpg', 4)
SET IDENTITY_INSERT [dbo].[immage_product] OFF
GO
SET IDENTITY_INSERT [dbo].[products] ON 

INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color], [description], [discount], [end_day_discount], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id])
VALUES (1, CAST(N'2023-03-11 15:52:49.7310000' AS Datetime),CAST(N'2023-03-11 15:52:49.7310000' AS Datetime),N'p058b9f5d-877c-4db7-8cb6-1ba32f0193e3.jpg',N'#000000',N'', 34, CAST(N'2024-03-01 07:00:00.0000000' AS Datetime), N'', N'Laptop Acer Nitro 5 AN515-45-R6EV (NH.QBMSV.006)', 28590000, 9860, CAST(N'2023-03-23 07:00:00.0000000' AS Datetime), 18, 6, 12)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color], [description], [discount], [end_day_discount], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id])
VALUES (2, CAST(N'2023-03-22 09:28:08.9580000' AS Datetime),CAST(N'2023-03-22 09:28:08.9580000' AS Datetime),N'p7d26867d-a40e-41ca-baad-9e84bc0511ed.jpg',N'#000000',N'', 32, CAST(N'2023-11-02 07:00:00.0000000' AS Datetime), N'', N'Laptop Asus TUF Gaming F15 FX506LHB-HN188W', 24550000, 9700, CAST(N'2023-03-15 07:00:00.0000000' AS Datetime), 1, 7, 12)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color], [description], [discount], [end_day_discount], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id])
VALUES (3, CAST(N'2023-03-14 21:56:31.2190000' AS Datetime),CAST(N'2023-03-14 21:56:31.2190000' AS Datetime),N'pf29c584f-52c7-4f38-9303-3c5c12cfa7c4.jpg',N'#000000',N'', 22, CAST(N'2023-09-08 07:00:00.0000000' AS Datetime), N'', N'Apple Macbook Air 13.6" M2 2022(MLY33) CPU M2/8GB/SSD 256GB/8GPU_Midnight', 36990000, 9780, CAST(N'2023-03-14 07:00:00.0000000' AS Datetime), 0, 2, 12)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color], [description], [discount], [end_day_discount], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id])
VALUES (4, CAST(N'2023-03-14 21:50:19.6010000' AS Datetime),CAST(N'2023-03-14 22:29:06.8060000' AS Datetime),N'p0bd9447a-d067-4eab-823a-256a9c3a274f.jpg',N'#ffffff',N'', 33, CAST(N'2023-08-08 07:00:00.0000000' AS Datetime), N'', N'Laptop Lenovo Ideapad 3 15IAU7 82RK005KVN', 16990000, 9680, CAST(N'2023-03-14 07:00:00.0000000' AS Datetime), 4, 8, 12)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color], [description], [discount], [end_day_discount], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id])
VALUES (5, CAST(N'2023-03-14 21:47:47.4560000' AS Datetime),CAST(N'2023-03-14 22:27:45.8760000' AS Datetime),N'pfd349974-f070-4916-b214-1a17680acc66.jpg',N'#000000',N'', 27, CAST(N'2023-11-14 07:00:00.0000000' AS Datetime), N'', N'Laptop Dell Inspiron 3520 N5I5122W1', 20990000, 9780, CAST(N'2023-03-14 07:00:00.0000000' AS Datetime), 4, 5, 12)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color], [description], [discount], [end_day_discount], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id])
VALUES (6, CAST(N'2023-03-16 21:47:47.4560000' AS Datetime),CAST(N'2023-03-16 22:27:45.8760000' AS Datetime),N'hinh3.jpg',N'#fff200',N'', 48, CAST(N'2023-11-15 07:00:00.0000000' AS Datetime), N'', N'Samsung Galaxy S21 FE 5G', 690000, 9980, CAST(N'2023-03-15 07:00:00.0000000' AS Datetime), 4, 1, 13)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color], [description], [discount], [end_day_discount], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id])
VALUES (7, CAST(N'2023-03-15 21:47:47.4560000' AS Datetime),CAST(N'2023-03-15 22:27:45.8760000' AS Datetime),N'hinh0.1.jpg',N'#fff300',N'', 43, CAST(N'2023-11-16 07:00:00.0000000' AS Datetime), N'', N'Xiaomi Redmi Note 11 (6GB/128Gb)', 520000, 8980, CAST(N'2023-03-14 07:00:00.0000000' AS Datetime), 4, 9, 13)
SET IDENTITY_INSERT [dbo].[products] OFF
GO


SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [created_date], [last_modified_date], [address], [avatar], [birth_day], [email], [first_name], [gender], [last_login_date], [last_name], [login], [password], [role], [username])
VALUES (N'PC001', CAST(N'2023-06-11 15:52:49.7310000' AS Datetime),CAST(N'2023-11-11 15:52:49.7310000' AS Datetime),N'An mimh, Kiên Giang',N'user1.jpg', CAST(N'2003-19-04' AS Date), N'nguyenccpc03965@fpt.edu.vn', N'Châu Chí', N'True', CAST(N'2023-08-03 17:30:43.7560000' AS Datetime), N'Nguyện', N'True', N'123456',N'ROLE_ADMIN', N'nguyencc')
INSERT [dbo].[users] ([id], [created_date], [last_modified_date], [address], [avatar], [birth_day], [email], [first_name], [gender], [last_login_date], [last_name], [login], [password], [role], [username])
VALUES (N'PC002', CAST(N'2023-06-11 15:52:49.7310000' AS Datetime),CAST(N'2023-11-11 15:52:49.7310000' AS Datetime),N'An Giang',N'user2.jpg', CAST(N'2003-08-14' AS Date), N'tinhhhpc04105@fpt.edu.vn', N'Huỳnh Hữu', N'True', CAST(N'2023-08-04 17:30:43.7560000' AS Datetime), N'Tình', N'True', N'123456789',N'ROLE_ADMIN', N'tinhhh')
SET IDENTITY_INSERT [dbo].[products] OFF
GO

ALTER TABLE [dbo].[image_product]  WITH CHECK ADD  CONSTRAINT [FKr01evkpk9msgd6a4j55hv73ja] FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[image_product] CHECK CONSTRAINT [FKr01evkpk9msgd6a4j55hv73ja]
GO
ALTER TABLE [dbo].[likes]  WITH CHECK ADD  CONSTRAINT [FK79ytfme5tdc4k9i57h0akaah2] FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[likes] CHECK CONSTRAINT [FK79ytfme5tdc4k9i57h0akaah2]
GO
ALTER TABLE [dbo].[likes]  WITH CHECK ADD  CONSTRAINT [FKnvx9seeqqyy71bij291pwiwrg] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[likes] CHECK CONSTRAINT [FKnvx9seeqqyy71bij291pwiwrg]
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD  CONSTRAINT [FK4q98utpd73imf4yhttm3w0eax] FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[order_details] CHECK CONSTRAINT [FK4q98utpd73imf4yhttm3w0eax]
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD  CONSTRAINT [FKjyu2qbqt8gnvno9oe9j2s2ldk] FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[order_details] CHECK CONSTRAINT [FKjyu2qbqt8gnvno9oe9j2s2ldk]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FKt0ecml6rxswu7mop3s4nc73ie] FOREIGN KEY([order_address_id])
REFERENCES [dbo].[order_address] ([id])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FKt0ecml6rxswu7mop3s4nc73ie]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FKa3a4mpsfdf4d2y6r8ra3sc8mv] FOREIGN KEY([brand_id])
REFERENCES [dbo].[brands] ([id])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FKa3a4mpsfdf4d2y6r8ra3sc8mv]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FKog2rp4qthbtt2lfyhfo32lsw9] FOREIGN KEY([category_id])
REFERENCES [dbo].[categories] ([id])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FKog2rp4qthbtt2lfyhfo32lsw9]
GO
USE [master]
GO
ALTER DATABASE [MollaShop] SET  READ_WRITE 
GO
