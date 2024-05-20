USE [master]
GO
/****** Object:  Database [DDTShopp]    Script Date: 12/8/2023 5:04:48 AM ******/
CREATE DATABASE [DDTShopp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DDTShopp', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MRTHOR\MSSQL\DATA\DDTShopp.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DDTShopp_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MRTHOR\MSSQL\DATA\DDTShopp_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DDTShopp] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DDTShopp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DDTShopp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DDTShopp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DDTShopp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DDTShopp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DDTShopp] SET ARITHABORT OFF 
GO
ALTER DATABASE [DDTShopp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DDTShopp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DDTShopp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DDTShopp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DDTShopp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DDTShopp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DDTShopp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DDTShopp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DDTShopp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DDTShopp] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DDTShopp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DDTShopp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DDTShopp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DDTShopp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DDTShopp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DDTShopp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DDTShopp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DDTShopp] SET RECOVERY FULL 
GO
ALTER DATABASE [DDTShopp] SET  MULTI_USER 
GO
ALTER DATABASE [DDTShopp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DDTShopp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DDTShopp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DDTShopp] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DDTShopp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DDTShopp] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DDTShopp] SET QUERY_STORE = OFF
GO
USE [DDTShopp]
GO
/****** Object:  Table [dbo].[brands]    Script Date: 12/8/2023 5:04:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brands](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[last_modified_date] [datetime2](7) NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_brands] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 12/8/2023 5:04:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[last_modified_date] [datetime2](7) NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_categories] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[colors]    Script Date: 12/8/2023 5:04:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[colors](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[last_modified_date] [datetime2](7) NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_colors] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[comment]    Script Date: 12/8/2023 5:04:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comment](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[rate] [int] NULL,
	[comment] [nvarchar](max) NULL,
	[user_id] [varchar](255) NULL,
 CONSTRAINT [PK_comment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[image_product]    Script Date: 12/8/2023 5:04:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[image_product](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](max) NULL,
	[product_id] [bigint] NULL,
 CONSTRAINT [PK_image_product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[likes]    Script Date: 12/8/2023 5:04:48 AM ******/
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
 CONSTRAINT [PK_likes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_address]    Script Date: 12/8/2023 5:04:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_address](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[last_modified_date] [datetime2](7) NULL,
	[email] [varchar](50) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[phone] [varchar](11) NOT NULL,
	[address] [nvarchar](255) NOT NULL,
	[province] [nvarchar](255) NULL,
	[district] [nvarchar](255) NULL,
	[ward] [nvarchar](255) NULL,
 CONSTRAINT [PK_order_address] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_details]    Script Date: 12/8/2023 5:04:48 AM ******/
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
	[size_id] [bigint] NULL,
	[order_id] [bigint] NULL,
	[product_id] [bigint] NULL,
	[color_id] [bigint] NULL,
 CONSTRAINT [PK_order_details] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 12/8/2023 5:04:48 AM ******/
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
 CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 12/8/2023 5:04:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[last_modified_date] [datetime2](7) NULL,
	[banner] [varchar](max) NULL,
	[color_id] [bigint] NULL,
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
	[size_id] [bigint] NULL,
	[comment_id] [bigint] NULL,
 CONSTRAINT [PK_products] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sizes]    Script Date: 12/8/2023 5:04:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sizes](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[last_modified_date] [datetime2](7) NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_sizes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 12/8/2023 5:04:48 AM ******/
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
	[active] [bit] NOT NULL,
	[password] [varchar](max) NOT NULL,
	[role] [varchar](255) NULL,
	[username] [varchar](50) NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[brands] ON 

INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (1, CAST(N'2023-12-03T23:25:21.9270000' AS DateTime2), CAST(N'2023-12-03T23:25:21.9270000' AS DateTime2), N'GUCCI')
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (2, CAST(N'2023-12-07T00:41:29.7300000' AS DateTime2), CAST(N'2023-12-07T00:41:29.7300000' AS DateTime2), N'JUNO')
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (3, CAST(N'2023-12-07T00:41:41.0590000' AS DateTime2), CAST(N'2023-12-07T00:41:41.0590000' AS DateTime2), N'OWEN')
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (4, CAST(N'2023-12-07T00:42:00.4210000' AS DateTime2), CAST(N'2023-12-07T00:42:00.4210000' AS DateTime2), N'VIỆT TIẾN')
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (5, CAST(N'2023-12-07T00:44:48.5790000' AS DateTime2), CAST(N'2023-12-07T00:44:48.5790000' AS DateTime2), N'NOVELTY')
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (6, CAST(N'2023-12-07T00:45:05.5170000' AS DateTime2), CAST(N'2023-12-07T00:45:05.5170000' AS DateTime2), N'BLUE EXCHANGE')
INSERT [dbo].[brands] ([id], [created_date], [last_modified_date], [name]) VALUES (7, CAST(N'2023-12-07T00:45:45.4470000' AS DateTime2), CAST(N'2023-12-07T00:45:45.4470000' AS DateTime2), N'YAME')
SET IDENTITY_INSERT [dbo].[brands] OFF
GO
SET IDENTITY_INSERT [dbo].[categories] ON 

INSERT [dbo].[categories] ([id], [created_date], [last_modified_date], [name]) VALUES (1, CAST(N'2023-12-03T23:25:12.6840000' AS DateTime2), CAST(N'2023-12-07T01:04:51.5290000' AS DateTime2), N'Áo Vest và Blazer')
INSERT [dbo].[categories] ([id], [created_date], [last_modified_date], [name]) VALUES (2, CAST(N'2023-12-07T00:47:08.1650000' AS DateTime2), CAST(N'2023-12-07T00:47:26.7220000' AS DateTime2), N'Hoodie')
INSERT [dbo].[categories] ([id], [created_date], [last_modified_date], [name]) VALUES (3, CAST(N'2023-12-07T00:47:48.5060000' AS DateTime2), CAST(N'2023-12-07T00:47:48.5060000' AS DateTime2), N'Áo Khoác')
INSERT [dbo].[categories] ([id], [created_date], [last_modified_date], [name]) VALUES (4, CAST(N'2023-12-07T00:48:18.6300000' AS DateTime2), CAST(N'2023-12-07T00:48:18.6300000' AS DateTime2), N'Quần Jeans')
INSERT [dbo].[categories] ([id], [created_date], [last_modified_date], [name]) VALUES (5, CAST(N'2023-12-07T00:48:49.1230000' AS DateTime2), CAST(N'2023-12-07T00:48:49.1230000' AS DateTime2), N'Quần Âu')
INSERT [dbo].[categories] ([id], [created_date], [last_modified_date], [name]) VALUES (6, CAST(N'2023-12-07T00:50:10.5480000' AS DateTime2), CAST(N'2023-12-07T00:50:10.5480000' AS DateTime2), N'CROPTOP')
INSERT [dbo].[categories] ([id], [created_date], [last_modified_date], [name]) VALUES (7, CAST(N'2023-12-07T00:50:36.9290000' AS DateTime2), CAST(N'2023-12-07T00:50:36.9290000' AS DateTime2), N'Áo Thun')
INSERT [dbo].[categories] ([id], [created_date], [last_modified_date], [name]) VALUES (8, CAST(N'2023-12-07T00:52:32.2970000' AS DateTime2), CAST(N'2023-12-07T00:52:32.2970000' AS DateTime2), N'Đồ Bộ')
SET IDENTITY_INSERT [dbo].[categories] OFF
GO
SET IDENTITY_INSERT [dbo].[colors] ON 

INSERT [dbo].[colors] ([id], [created_date], [last_modified_date], [name]) VALUES (1, CAST(N'2023-12-03T23:25:33.8600000' AS DateTime2), CAST(N'2023-12-03T23:25:33.8600000' AS DateTime2), N'Vàng')
INSERT [dbo].[colors] ([id], [created_date], [last_modified_date], [name]) VALUES (2, CAST(N'2023-12-07T00:50:51.1590000' AS DateTime2), CAST(N'2023-12-07T00:50:51.1590000' AS DateTime2), N'Đen ')
INSERT [dbo].[colors] ([id], [created_date], [last_modified_date], [name]) VALUES (3, CAST(N'2023-12-07T00:50:55.6080000' AS DateTime2), CAST(N'2023-12-07T00:50:55.6080000' AS DateTime2), N'Nâu')
INSERT [dbo].[colors] ([id], [created_date], [last_modified_date], [name]) VALUES (4, CAST(N'2023-12-07T00:51:02.5450000' AS DateTime2), CAST(N'2023-12-07T00:51:02.5450000' AS DateTime2), N'Trắng')
INSERT [dbo].[colors] ([id], [created_date], [last_modified_date], [name]) VALUES (5, CAST(N'2023-12-07T00:51:14.3620000' AS DateTime2), CAST(N'2023-12-07T00:51:14.3620000' AS DateTime2), N'Xanh')
INSERT [dbo].[colors] ([id], [created_date], [last_modified_date], [name]) VALUES (6, CAST(N'2023-12-07T01:54:36.1670000' AS DateTime2), CAST(N'2023-12-07T01:54:36.1670000' AS DateTime2), N'Hồng')
SET IDENTITY_INSERT [dbo].[colors] OFF
GO
SET IDENTITY_INSERT [dbo].[image_product] ON 

INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (10, N'p31a13d3b-5371-4f79-9a8e-e401c41b89a8.jpg', 4)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (11, N'p1302c309-436d-45d9-9b6e-c13b63f861d1.jpg', 4)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (12, N'p07a8248d-7f8d-4e22-9bd7-d8446389b823.jpg', 4)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (13, N'pc4014302-f15e-4ac9-bba7-a988de3eaf41.jpg', 4)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (14, N'pd14e8fb3-3ea9-46f3-9412-2e4d1d00a490.jpg', 5)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (15, N'p58334f9d-ef8b-49dc-bd20-3cd9ee2d6a45.jpg', 5)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (16, N'pea82fdd5-8386-490f-afd1-6f0db1113a06.jpg', 5)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (17, N'p021c85cf-24bb-44d4-a95b-c73b962872b4.jpg', 5)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (18, N'p1e480cda-5b64-4938-8fff-31b7c911382c.jpg', 5)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (19, N'p3ecf3e30-dc52-4c0c-b2c8-0e65046ff350.jpg', 5)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (20, N'paa32977f-d33a-46af-bb96-77b46a97a336.jpg', 5)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (21, N'p16ac7a70-b404-46e9-82a6-7ad98e13ab07.jpg', 5)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (22, N'pfa64be64-9c31-4e6b-8551-f88c012a8718.jpg', 6)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (23, N'pc0926b4a-eeb4-42a2-9a42-a80f294dd63b.jpg', 6)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (24, N'p35bae6ff-8131-4fc5-858f-461c9a86625a.jpg', 6)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (25, N'pa45ceafd-e49b-46f0-afe6-72cab9cd72d0.jpg', 6)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (26, N'pbc0b041f-208b-42c8-8209-ade939d507b8.jpg', 6)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (27, N'pcc681740-7f9c-41d3-8dcb-25a7adbf2407.jpg', 6)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (28, N'pd032618c-bfd7-4cce-aba5-f5257fb0a149.jpg', 6)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (29, N'pe2776faa-1b19-4453-b730-4a715dad88c4.jpg', 6)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (30, N'pdfee1634-5ee4-4fc0-8736-a5aadd408aa7.jpg', 7)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (31, N'p63c29958-8c07-4fcd-94de-f385b5d10439.jpg', 7)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (32, N'p68791162-b46c-4d32-9278-202edb0a5040.jpg', 7)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (33, N'pce84d45d-c1bc-49b5-84ff-1dab11871b3d.jpg', 7)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (34, N'pcfa17642-d0aa-4d4c-ac2b-7596927a5cda.jpg', 8)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (35, N'pd2f1c094-f7e2-4b67-be78-a0ad441e2966.jpg', 8)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (36, N'pec2a5818-c6ea-4408-a196-293ff1e99f8a.jpg', 8)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (37, N'peaaf1fae-0f68-4e6f-a02f-5580f372c891.jpg', 8)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (38, N'pf3e0eefb-cb85-43a2-becc-be1cdcfdd032.jpg', 8)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (39, N'p1b6c0932-cbd5-4b9b-9536-e00a8a99dff8.jpg', 9)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (40, N'pbf398881-aae3-4b97-9efd-28af23682a55.jpg', 9)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (41, N'p514be619-b6ca-4301-81eb-27501efa657a.jpg', 9)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (42, N'p0e0a1355-e661-48c6-b204-f80ce92d09d2.jpg', 9)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (43, N'p0c76465b-ec46-431b-82b3-391c71244a1a.jpg', 9)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (44, N'peb0d9f88-534f-4c2f-a438-8622844e0442.jpg', 10)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (45, N'p0a3e58ee-edc5-4ee3-bcf5-e9b4ac9c644e.jpg', 10)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (46, N'pc4d5105a-282d-4863-b180-9c18d6d96e0f.jpg', 10)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (47, N'p862a32a7-8217-4b5a-b678-deaa01e91c18.jpg', 11)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (48, N'pdbf1fa94-a7d2-4f13-b07c-adb5407b22e1.jpg', 11)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (49, N'p62a7ef28-1da8-4c35-8ded-fcf469391f63.jpg', 11)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (50, N'pa4ab268c-30c8-413e-b20e-c69c299d4f85.jpg', 12)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (51, N'peb4fa5a5-ec58-4062-8f63-f82a09bd3907.jpg', 12)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (52, N'pf284ef8c-4c99-4c11-a4d3-62b49026bab3.jpg', 12)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (53, N'p408aeb1c-6905-4a8f-b2e6-96a19e1d13b4.jpg', 12)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (54, N'pa553426e-8adf-4073-8342-e5e9f2246685.jpg', 12)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (55, N'pb17827b1-05f5-4f25-bfda-dc8297ce2870.jpg', 13)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (56, N'p5428b16a-1ebc-499a-83c2-58bf8e13f7e3.jpg', 13)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (57, N'p5a3f4d33-0273-4077-b4c0-14a50b815074.jpg', 13)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (58, N'pbe73b558-6d7b-42b6-9a31-85c6cd826bd2.jpg', 13)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (59, N'p000cc855-d497-4f03-a08b-4f067ca0ada1.jpg', 13)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (60, N'pc7a7ddae-d6d2-44af-8048-b83375754282.jpg', 14)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (61, N'pe8209d42-3bd4-4d99-84d3-be42c4601674.jpg', 14)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (62, N'p0892bf4d-e788-406c-8619-25e765a38e2a.jpg', 14)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (63, N'p7f6d97ec-ae37-4c14-aa5f-c86068b0d214.jpg', 14)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (64, N'p9cd8ba4b-34e9-41a2-a652-a9caaa3b2bce.jpg', 14)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (65, N'p420fc02f-3415-4112-93ea-8928aa561506.jpg', 14)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (66, N'p751649df-9e35-4eba-af6d-425e6a8cd7f0.jpg', 15)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (67, N'p7f90b5e0-eb65-4979-9955-b1e5e748565f.jpg', 15)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (68, N'p47c87261-bb3d-4ad1-8083-686b5afad6e3.jpg', 15)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (69, N'pc0fd4abd-9364-44cd-8aba-2670b181ae60.jpg', 16)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (70, N'pe495e5d1-4ff0-4f17-bfb9-596e560f34de.jpg', 16)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (71, N'p1704942a-51e6-49ea-963a-5d8e2c76cc68.jpg', 16)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (72, N'pebda72f3-b494-43bd-914a-832c1f72f5e0.jpg', 17)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (73, N'p3fd97a49-2dc6-407b-9148-b51230e46ee9.jpg', 17)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (74, N'pb3c14fff-037b-4c7f-9452-2666fd58bbff.jpg', 18)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (75, N'p7a0ea24a-55ad-448e-b93e-cb88086068de.jpg', 18)
INSERT [dbo].[image_product] ([id], [name], [product_id]) VALUES (76, N'pd1b19848-f21a-4ab2-a3b6-21ef7e3f6142.jpg', 18)
SET IDENTITY_INSERT [dbo].[image_product] OFF
GO
SET IDENTITY_INSERT [dbo].[likes] ON 

INSERT [dbo].[likes] ([id], [created_date], [last_modified_date], [product_id], [user_id]) VALUES (1, CAST(N'2023-12-07T02:54:48.1390000' AS DateTime2), CAST(N'2023-12-07T02:54:48.1390000' AS DateTime2), 12, N'c0a80069-8c3b-1172-818c-3b061c1f0000')
INSERT [dbo].[likes] ([id], [created_date], [last_modified_date], [product_id], [user_id]) VALUES (2, CAST(N'2023-12-08T04:03:46.7390000' AS DateTime2), CAST(N'2023-12-08T04:03:46.7390000' AS DateTime2), 16, N'c0a80069-8c45-147e-818c-45e108a20002')
INSERT [dbo].[likes] ([id], [created_date], [last_modified_date], [product_id], [user_id]) VALUES (3, CAST(N'2023-12-08T04:28:24.7240000' AS DateTime2), CAST(N'2023-12-08T04:28:24.7240000' AS DateTime2), 17, N'c0a80069-8c45-147e-818c-45e108a20002')
SET IDENTITY_INSERT [dbo].[likes] OFF
GO
SET IDENTITY_INSERT [dbo].[order_address] ON 

INSERT [dbo].[order_address] ([id], [created_date], [last_modified_date], [email], [first_name], [last_name], [phone], [address], [province], [district], [ward]) VALUES (2, CAST(N'2023-12-03T23:46:12.3140000' AS DateTime2), CAST(N'2023-12-08T02:52:00.8450000' AS DateTime2), N'datntpc03950@fpt.edu.vn', N'Nguyen', N'Dat', N'079191103', N'25/13', N'Hà lội', N'Đóng đa', N'La thành')
INSERT [dbo].[order_address] ([id], [created_date], [last_modified_date], [email], [first_name], [last_name], [phone], [address], [province], [district], [ward]) VALUES (3, CAST(N'2023-12-06T02:21:21.2960000' AS DateTime2), CAST(N'2023-12-06T02:30:06.7790000' AS DateTime2), N'datmee2528@gmail.com', N'dat', N'nguyen', N'113', N'ádf', N'sad', N'sad', N'ada')
INSERT [dbo].[order_address] ([id], [created_date], [last_modified_date], [email], [first_name], [last_name], [phone], [address], [province], [district], [ward]) VALUES (4, CAST(N'2023-12-08T03:04:31.2450000' AS DateTime2), CAST(N'2023-12-08T03:04:49.5250000' AS DateTime2), N'mrthor251003@gmail.com', N'a', N'a', N'123', N'b', N'b', N'b', N'b')
SET IDENTITY_INSERT [dbo].[order_address] OFF
GO
SET IDENTITY_INSERT [dbo].[order_details] ON 

INSERT [dbo].[order_details] ([id], [banner], [discount], [name], [price], [quantity], [size_id], [order_id], [product_id], [color_id]) VALUES (12, N'p32c6011f-7e79-4ef2-bf7b-2be2be992ea0.jpg', 46, N'Áo khoác Blazer Nam Form rộng dài tay unisex basic chất Flannel Hàn cao cấp ,hợp mọi thời đại, phong cách Hàn Quốc, Vest', 439000, 1, 4, 23, 5, 2)
SET IDENTITY_INSERT [dbo].[order_details] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([id], [created_date], [last_modified_date], [note], [pay], [ship], [status], [order_address_id]) VALUES (23, CAST(N'2023-12-08T02:35:45.1900000' AS DateTime2), CAST(N'2023-12-08T02:55:23.0210000' AS DateTime2), N'', 0, NULL, 0, 2)
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[products] ON 

INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (4, CAST(N'2023-12-07T00:55:48.1100000' AS DateTime2), CAST(N'2023-12-07T00:57:55.3670000' AS DateTime2), N'p0b815a24-c421-4a2d-9826-5cf0a393e853.jpg', 2, N'Sản phẩm được may đo trên chất liệu cao cấp phù hợp với dáng thiết kế cho sản phẩm chuẩn phong cách như hình.Sản phẩm cho bạn nữ từ 40kg đến 60kg mặc form rộng đẹp y hình, sản phẩm không thể thiếu được trong tủ đồ của các bạn nhé
Chất Liệu  Áo chất cotton su, quần da cá
NHÓM MÀU;LOANG
Xuất xứ: Việt Nam
Bảng SIZE: 
-Size S: 40-46kg, Cao dưới 1m60
-SizeM: từ 47- 53kg , Cao 1m61 - 1m70
-Size L: từ 54- 60kg , Cao - 1m75', 44, CAST(N'2023-12-20T07:00:00.0000000' AS DateTime2), N'Xuất xứ: Việt Nam
Cổ áo: Cổ tròn
Chiều dài tay áo: Tay ngắn
Chất liệu: Cotton
Mùa: Mùa hè
Mẫu: Trơn', N'SÉT BỘ NAM NỮ MÀU LOANG URBAN FROM RỘNG PHONG CÁCH THỜI TRANG HOTTREND 365', 160000, 10000, CAST(N'2023-12-07T07:00:00.0000000' AS DateTime2), 1, 2, 8, 2, NULL)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (5, CAST(N'2023-12-07T01:09:16.0320000' AS DateTime2), CAST(N'2023-12-08T02:35:45.2100000' AS DateTime2), N'p32c6011f-7e79-4ef2-bf7b-2be2be992ea0.jpg', 2, N'MÔ TẢ SẢN PHẨM
     Chất Liệu Vải :  Flannel xuất Hàn cao cấp 100%, co giãn 4 chiều, vải mềm, mịn, thoáng mát, không xù lông.
     Kĩ thuật may: Đường may chuẩn chỉnh, tỉ mỉ, chắc chắn
     Kiểu Dáng :Form Rộng Thoải Mái
     Full size nam nữ : 40 - 85 kg', 46, CAST(N'2023-12-21T07:00:00.0000000' AS DateTime2), N'Xuất xứ: Trung Quốc
Dáng kiểu áo: Rộng
Phong cách: Cơ bản, Hàn Quốc, Đường phố, Công sở, Nhiệt đới
Kiểu nút: hai nút
Chất liệu: Flannel nhập Hàn cao cấp', N'Áo khoác Blazer Nam Form rộng dài tay unisex basic chất Flannel Hàn cao cấp ,hợp mọi thời đại, phong cách Hàn Quốc, Vest', 439000, 9999, CAST(N'2023-12-07T07:00:00.0000000' AS DateTime2), 2, 1, 1, 4, NULL)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (6, CAST(N'2023-12-07T01:14:34.0800000' AS DateTime2), CAST(N'2023-12-07T01:46:17.7030000' AS DateTime2), N'p90ce5296-7e6f-4904-b0bc-4ddacdb65ba4.jpg', 3, N'Áo croptop nữ đa phong cách, bởi phần trên của chiếc áo croptop có thể được thiết kế giống như áo thun, sweater, giống áo sơ mi, giống áo hoodie, giống áo hai dây, midriff, áo trễ vai, áo ba lỗ, belly hay tummy top,… Tay áo có thể dài, ngắn, rộng, sát nách, trễ vai,… tùy theo sở thích của từng người. Ngoài ra, còn có áo croptop form rộng hay áo croptop ôm sát cơ thể để khoe body.', 30, CAST(N'2023-12-13T07:00:00.0000000' AS DateTime2), N'Phong cách: Retro, sexy
Petite: Không
Mùa: Mùa hè
Mẫu: Trơn
Cropped Top: Có', N'Áo croptop nữ 2 dây kiểu thời trang với thiết kế không đều với dây chuyền', 200000, 10000, CAST(N'2023-12-06T07:00:00.0000000' AS DateTime2), 2, 5, 6, 1, NULL)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (7, CAST(N'2023-12-07T01:23:53.7110000' AS DateTime2), CAST(N'2023-12-07T01:24:55.1650000' AS DateTime2), N'p6b5ed5cc-4cc0-4455-ab5e-74ac36354cb7.jpg', 2, N'Cân nặng đề xuất (Cân nặng đề xuất này được tính theo chiều cao 160cm)
M = 45-55kg
L = 55-67,5 kg
XL = 67,5-80kg
2XL = 80-92,5 kg
3XL = 92,5-100 kg', 43, CAST(N'2023-12-15T07:00:00.0000000' AS DateTime2), N'Thương hiệu: YAME
Xuất xứ: Trung Quốc
Cổ áo: Cổ tròn
Chiều dài tay áo: Tay ngắn
Chất liệu: Cotton, Khác', N'Áo thun HIIXIIVI 100% cotton tay ngắn dáng suông in hình trẻ trung thời trang unisex size XL', 216000, 10000, CAST(N'2023-12-07T07:00:00.0000000' AS DateTime2), 1, 7, 7, 4, NULL)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (8, CAST(N'2023-12-07T01:28:59.7010000' AS DateTime2), CAST(N'2023-12-07T01:28:59.7010000' AS DateTime2), N'p39508716-8bdd-4bf8-824c-beb939fd5fcc.jpg', 2, N'***Áo Phông Oversize Hình Dễ Thương Thời Trang Trẻ Trung Mẫu Mới Nhất***
Mùa hè come back rồi ạ, cần lắm những chiếc áo phông rực rỡ sắc màu, trẻ trung tươi mát cho nàng diện cả hè nhé.
Hàng trăm mẫu áo phông, áo thun oversize mới nhất đã lên kệ, mời khách yêu nhanh tay đăt hàng ạ.
***Chất liệu:
- Chất cotton tici mềm mịn tạo cảm giác thoải mái khi mặc kể cả trong ngày hè oi bức. Độ dày củ vải vừa phải không quá dày không quá mỏng, tránh nóng bí và cũng không để lộ nội y với các màu sáng như trắng, vàng, be. Đường may cẩn thận, chắc chắn, không vải thừa chỉ thừa. Hình in sắc nét, tươi sáng, không phai màu.', 44, CAST(N'2023-12-12T07:00:00.0000000' AS DateTime2), N'Cổ áo: Cổ tròn
Chất liệu: Cotton
Mẫu: In
Cropped Top: Không', N'Áo Phông Oversize Hình Dễ Thương Thời Trang Trẻ Trung Mẫu Mới Nhất', 150000, 10000, CAST(N'2023-12-03T07:00:00.0000000' AS DateTime2), 0, 2, 7, 2, NULL)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (9, CAST(N'2023-12-07T01:44:55.6460000' AS DateTime2), CAST(N'2023-12-07T01:44:55.6460000' AS DateTime2), N'pd7b2a508-5aaa-458d-8d21-5e4b3fd1359e.jpg', 1, N'áo kiểu áo thun free size nhé  tầm 52kg đổ lại mặc đẹp hú hồn nè 
chất liệu thì nhìu chất lắm 
 thun lụa nè 
 voan xịn 
 kaki 
chân váy quần kaki váy đủ loại 
 chất kaki  da kate ...
 lưng thun free size 
 size : S M L
áo khoác sương sương mẫu 
 chất kaki dù các cái
 free size dưới 70kg nhé 
sét bộ lung linh ', 0, NULL, N'Chiều dài tay áo
Tay ngắn
Mẫu
Trơn
Cropped Top
Có', N'ÁO CROPTOP XINH PHỐI MÀU CÁ TÁNH LẮM TINA2', 99000, 99000, NULL, 0, 6, 6, 1, NULL)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (10, CAST(N'2023-12-07T01:51:21.3400000' AS DateTime2), CAST(N'2023-12-08T04:11:57.8130000' AS DateTime2), N'p5baeb2db-9263-4940-81b0-b72287d6e396.jpg', 2, N'CH  STORE ❤️
Chuyên Sản Xuất Hàng May Sẵn .', 70, CAST(N'2023-12-30T07:00:00.0000000' AS DateTime2), N'Cổ áo: Cổ tròn
Chất liệu: Cotton
Cropped Top: Không', N'Áo phông Wey in nổi chất cotton su form rộng túi zip', 500000, 10000, CAST(N'2023-12-07T07:00:00.0000000' AS DateTime2), 1, 4, 7, 4, NULL)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (11, CAST(N'2023-12-07T02:04:53.5110000' AS DateTime2), CAST(N'2023-12-07T02:04:53.5110000' AS DateTime2), N'p7a67ce27-8599-4ba3-adfb-873fa1c660bd.jpg', 6, N'THÔNG TIN SẢN PHẨM: 
- Tên sản phẩm: Áo thun Unisex form rộng tay lỡ nam nữ
- Xuất sứ: Việt Nam 
- Chất liệu: 35% Cotton, 60% Polyester, 5% Spandex
- Vải thun co giãn, hình in sắc nét, chất vải thoáng mát, không xù, không nhăn, không hút bụi bẩn
BẢNG SIZE:
SIZE      Cân Nặng          Chiều Cao     Chiều Dài - Rộng áo                   
  S          29 - 35kg         1m31 - 1m41   Dài 63cm rộng 48cm
  M         36 - 44kg         1m42 - 1m52   Dài 66cm rộng 50cm          
   L         45 - 52kg         1m53 - 1m59   Dài 68cm rộng 53cm   
  XL        53 - 63kg         1m60 - 1m69   Dài 70cm rộng 55cm  
 XXL      Trên 63kg           Trên 1m70     Dài 73cm rộng 57cm', 20, CAST(N'2023-12-18T07:00:00.0000000' AS DateTime2), N'Xuất xứ: Việt Nam
Cổ áo: Cổ tròn
Chiều dài tay áo: Dài 3/4
Chất liệu: Cotton
Mùa: Mùa hè', N'Áo thun tay lỡ unisex nam nữ GẤU EVERYDAY LUXA, Áo phông unisex form rộng ATL02', 199000, 9900, CAST(N'2023-12-07T07:00:00.0000000' AS DateTime2), 0, 5, 7, 2, NULL)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (12, CAST(N'2023-12-07T02:11:59.4010000' AS DateTime2), CAST(N'2023-12-07T02:54:56.6310000' AS DateTime2), N'pfaba1397-6ce9-4a82-b532-b3c0729c6ff8.jpg', 2, N'Áo blazer nam chumi  2 lớp dày dặn form rộng dáng unisex ad006
- Vải wool mềm, mịn, thoáng mát, form rộng, thích hợp với n hiều dáng người. 
- Blazer sinh ra không chỉ để phục vụ họp hành công việc mà còn để đi chơi, dạo phố vì nó không quá cứng nhắc như vest nhưng lại lịch sự hợn những chiếc áo phông với quần bò. 

Bảng size Áo blazer nam ulzzang 2 lớp dày dặn phong cách Hàn quốc :
 Thiết kế: Áo Khoác Blazer cổ bẻ
Size : M, L, XL, XXL
Size M cân nặng dưới 55kg chiều cao160-167cm
Size L cân nặng từ 55-65kg chiều cao167-172cm
Size XL cân nặng 65-75kg chiều cao 167-175cm
Size XXL cân nặng 75-85kg chiều cao 168-180cm
Lưu ý : Nếu còn chưa chắc chắn về size áo hãy INBOX cho CHUMI để được tư vấn cụ thể nhất ', 25, CAST(N'2023-12-22T07:00:00.0000000' AS DateTime2), N'Thương hiệu: Chums
Xuất xứ: Việt Nam
Dáng kiểu áo: Rộng
Phong cách: Boho, Hàn Quốc, Đường phố, Công sở
Kiểu nút: hai nút
Chất liệu: Khác', N'Áo blazer nam chumi 2 lớp dày dặn form rộng dáng unisex ad006', 500000, 9090, CAST(N'2023-12-07T07:00:00.0000000' AS DateTime2), 2, 1, 1, 3, NULL)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (13, CAST(N'2023-12-07T02:19:46.7200000' AS DateTime2), CAST(N'2023-12-07T02:19:46.7200000' AS DateTime2), N'p29c50453-3722-48be-a08f-b2eace3ecade.jpg', 4, N'ĐẾN VỚI ĐỂ CÙNG CHÚNG TÔI TẠO NÊN PHONG CÁCH RIÊNG CỦA BẠN 

CHÀO MỪNG BẠN ĐẾN VỚI CỬA HÀNG CỦA CHÚNG TÔI RẤT MONG ĐƯỢC PHỤC VỤ BẠN 
Blazer hiểu đơn giản nhất là những chiếc áo khoác với form chung của vest, nhưng đường cắt và màu sắc lại hoàn toàn phá cách. Blazer cũng không cần lúc nào cũng phải đi kèm theo cả một bộ đồ như khi bạn diện suit, thực ra, chẳng ai đóng thùng trong sơ mi hồ cứng cổ với blazer đâu. ', 30, CAST(N'2023-12-10T07:00:00.0000000' AS DateTime2), N'Xuất xứ: Việt Nam
Dáng kiểu áo: Rộng
Phong cách: Thể thao, Cơ bản, Hàn Quốc, Retro, Đường phố
Loại suit: Cài nút chéo
Tall Fit: Có', N'Áo Blazer thêu hoạ tiết, áo vest from Hàn Quốc, Thời Trang Unisex From Rộng V016', 650000, 9000, CAST(N'2023-12-07T07:00:00.0000000' AS DateTime2), 0, 1, 1, 2, NULL)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (14, CAST(N'2023-12-07T02:28:52.4850000' AS DateTime2), CAST(N'2023-12-08T02:55:35.0160000' AS DateTime2), N'pf44732b5-cddc-48d3-8a5c-4e9db0f7a98b.jpg', 2, N'MÔ TẢ SẢN PHẨM
     Chất Liệu Vải :  Flannel xuất Hàn cao cấp 100%, co giãn 4 chiều, vải mềm, mịn, thoáng mát, không xù lông.
     Kĩ thuật may: Đường may chuẩn chỉnh, tỉ mỉ, chắc chắn
     Kiểu Dáng :Form Rộng Thoải Mái
     Full size nam nữ : 40 - 85 kg', 45, CAST(N'2023-12-13T07:00:00.0000000' AS DateTime2), N'Xuất xứ: Trung Quốc
Dáng kiểu áo: Rộng
Phong cách: Hàn Quốc, Retro, Đường phố, Công sở
Loại suit: Cài nút đơn
Chất liệu: Flannel', N'áo khoác dài cổ Vest, form rộng, chất Flannel cao cấp - áo khoác măng tô phong cách Hàn Quốc 2 lớp, Blazer dài', 750000, 10000, CAST(N'2023-11-26T07:00:00.0000000' AS DateTime2), 2, 2, 1, 2, NULL)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (15, CAST(N'2023-12-07T02:34:54.7010000' AS DateTime2), CAST(N'2023-12-08T03:48:58.6650000' AS DateTime2), N'p71f23406-18b4-4c05-9b76-67699dbcf98f.jpg', 2, N'Phiên bản: Tiêu chuẩn
Chiều dài tay áo: tay dài
Loại cổ áo: cổ áo ve áo phẳng
Mặt trước: hai nút ngực đơn
Độ dày: Bình thường
Phong cách cơ bản: pop trẻ trung
Cách thông hơi trở lại: không có lỗ thông hơi
Sử dụng cho dịp: thời trang thường ngày
Thích hợp cho: thanh thiếu niên
Phong cách phân khu: Tide
Công nghệ quần áo: xử lý ủi miễn phí', 30, CAST(N'2023-12-22T07:00:00.0000000' AS DateTime2), N'Xuất xứ: Trung Quốc
Chiều dài tay áo: Tay dài
Chất liệu: Cotton, Khác', N'Áo Vest Dài Tay Hai Hàng Nút Thời Trang Nam Trẻ Trung', 900000, 9000, CAST(N'2023-12-06T07:00:00.0000000' AS DateTime2), 2, 1, 1, 3, NULL)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (16, CAST(N'2023-12-07T02:49:56.8830000' AS DateTime2), CAST(N'2023-12-08T02:33:31.7910000' AS DateTime2), N'pf70922f7-dd4e-4dc0-a3a4-9cfc76267501.jpg', 4, N'Kính gửi quý khách hàng 💗 ：
▼ Hướng dẫn cách giặt
◆ Nên giặt sản phẩm bằng tay, không cho vào máy giặt
◆ Sản phẩm bị phai màu sau khi giặt là điều bình thường, vui lòng giặt riêng
◆ Để tránh bạc màu và phai màu, vui lòng không tiếp xúc với ánh nắng mạnh', 0, NULL, N'Thương hiệu: You You
Chiều dài tay áo: Dài tay
Chất liệu: Lông cừu
Rất lớn: Không', N'Áo Khoác hoodie Lông Cừu Dáng Rộng unisex Có Vẻ Ngoài Tốt Cho Cả Nam Và Nữ', 100000, 9000, NULL, 1, 2, 2, 2, NULL)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (17, CAST(N'2023-12-08T04:28:01.7440000' AS DateTime2), CAST(N'2023-12-08T04:51:04.0040000' AS DateTime2), N'pe1de2d36-2eef-43f9-8da8-fc21ce500d71.jpg', 3, N'Theo số đo 3 vòng SIZE NGỰC EO MÔNG
Size L: 91-105 76-85 90-105
Size: XL: 101-115 86-95 101-115
Size: XXL 111-125 96-105 111-125
⋆ Lưu ý: 
•    Eo: Đo trên rốn 3cm
•    Nếu không chọn được size, khi đặt hàng bạn ghi chú thêm chiều cao, cân nặng hoặc số đo 3 vòng để shop lấy size vừa đẹp nhé
•    Hãy nhắn tin cho shop, đội ngũ tư vấn chuyên nghiệp sẽ giúp bạn chọn size vừa đẹp', 5, CAST(N'2023-12-21T07:00:00.0000000' AS DateTime2), N'Chất liệu: Cotton
Địa chỉ tổ chức chịu trách nhiệm sản xuất: Đang cập nhật
Petite: Không
Xuất xứ: Việt Nam', N'Đồ bộ bigsize nữ set vest dự tiệc đi chơi sang chảnh kiểu vest 2 nút Lazaxy 50 - 85 kg', 85000, 10000, CAST(N'2023-12-08T07:00:00.0000000' AS DateTime2), 4, 3, 8, 3, NULL)
INSERT [dbo].[products] ([id], [created_date], [last_modified_date], [banner], [color_id], [description], [discount], [end_day_discount], [info], [name], [price], [quantity], [start_day_discount], [views], [brand_id], [category_id], [size_id], [comment_id]) VALUES (18, CAST(N'2023-12-08T04:58:20.6840000' AS DateTime2), CAST(N'2023-12-08T04:58:37.3730000' AS DateTime2), N'p944f9e5f-b0b8-4d9e-9d80-3dc1f90cc996.jpg', 2, N'Bộ Đồ Nam Mùa Hè Tay Ngắn Cổ Bẻ Áo Khuy Cài Quần Short Có Túi Kiểu Dáng Trẻ Trung Thời Trang Zenkonu QA NAM 071V1
* THÔNG TIN SẢN PHẨM:
🔸Chât liệu: vải kaki thô mềm mại, thấm hút mồ hôi.
🔸 Kích thước: XS   S   M   L    XL
🔸 Xuất xứ: Việt Nam
Với thiết kế trẻ trung năng động, phù hợp nhiều hoàn cảnh, phong cách Ulzzang cập nhập xu hướng mới nhất.', 25, CAST(N'2023-12-20T07:00:00.0000000' AS DateTime2), N'Danh Mục: Shopee
Thời Trang Nam: Đồ Bộ
', N'Bộ Đồ Nam Mùa Hè Tay Ngắn Cổ Bẻ Áo Khuy Cài Quần Short Có Túi Kiểu Dáng Trẻ Trung Thời Trang Zenkonu QA NAM 071V1', 350000, 10000, CAST(N'2023-12-07T07:00:00.0000000' AS DateTime2), 1, 2, 1, 4, NULL)
SET IDENTITY_INSERT [dbo].[products] OFF
GO
SET IDENTITY_INSERT [dbo].[sizes] ON 

INSERT [dbo].[sizes] ([id], [created_date], [last_modified_date], [name]) VALUES (1, CAST(N'2023-12-03T23:25:41.2440000' AS DateTime2), CAST(N'2023-12-03T23:25:41.2440000' AS DateTime2), N'S')
INSERT [dbo].[sizes] ([id], [created_date], [last_modified_date], [name]) VALUES (2, CAST(N'2023-12-03T23:25:45.5410000' AS DateTime2), CAST(N'2023-12-03T23:25:45.5410000' AS DateTime2), N'M')
INSERT [dbo].[sizes] ([id], [created_date], [last_modified_date], [name]) VALUES (3, CAST(N'2023-12-03T23:25:52.3410000' AS DateTime2), CAST(N'2023-12-03T23:25:52.3410000' AS DateTime2), N'L')
INSERT [dbo].[sizes] ([id], [created_date], [last_modified_date], [name]) VALUES (4, CAST(N'2023-12-03T23:25:57.0120000' AS DateTime2), CAST(N'2023-12-03T23:25:57.0120000' AS DateTime2), N'XL')
SET IDENTITY_INSERT [dbo].[sizes] OFF
GO
INSERT [dbo].[users] ([id], [created_date], [last_modified_date], [address], [avatar], [birth_day], [email], [first_name], [gender], [last_login_date], [last_name], [active], [password], [role], [username]) VALUES (N'c0a80069-8c3b-1172-818c-3b061c1f0000', CAST(N'2023-12-06T00:28:25.3650000' AS DateTime2), CAST(N'2023-12-08T04:21:35.0860000' AS DateTime2), N'can tho', N'pe1b27b5c-3244-4126-a2dd-a4f31df36ccb.jpg', CAST(N'2003-10-25T07:00:00.0000000' AS DateTime2), N'dat12@gmail.com', N'nguyen', 1, CAST(N'2023-12-08T04:21:35.0520000' AS DateTime2), N'dat', 1, N'$2a$10$pnZXcBZ3h4buFKYN8FXTheZFhW8T1qWIMRNYyB8iWEBloishuyUPG', N'ROLE_ADMIN', N'dat123')
INSERT [dbo].[users] ([id], [created_date], [last_modified_date], [address], [avatar], [birth_day], [email], [first_name], [gender], [last_login_date], [last_name], [active], [password], [role], [username]) VALUES (N'c0a80069-8c3b-1c67-818c-3b5cf4a60000', CAST(N'2023-12-06T02:03:16.8940000' AS DateTime2), CAST(N'2023-12-06T02:03:16.9330000' AS DateTime2), NULL, NULL, NULL, N'datmee2528@gmail.com', NULL, NULL, CAST(N'2023-12-06T02:03:16.9300000' AS DateTime2), NULL, 1, N'$2a$10$gDWjiL/xlINLl2DCEOcvQOS8xfYFvXnP73mjcDDppscu5c4PWionW', N'ROLE_USER', N'101748795317300724874')
INSERT [dbo].[users] ([id], [created_date], [last_modified_date], [address], [avatar], [birth_day], [email], [first_name], [gender], [last_login_date], [last_name], [active], [password], [role], [username]) VALUES (N'c0a80069-8c45-147e-818c-45c59c920000', CAST(N'2023-12-08T02:33:47.7920000' AS DateTime2), CAST(N'2023-12-08T03:01:18.5450000' AS DateTime2), NULL, NULL, NULL, N'datntpc03950@fpt.edu.vn', NULL, NULL, CAST(N'2023-12-08T03:01:18.5410000' AS DateTime2), NULL, 1, N'$2a$10$41Wv7rnVhWMJQFNO39UK0.IZpYOF8DxV1cJmIwXg/l8zhPMy05t5G', N'ROLE_USER', N'117664999226805960935')
INSERT [dbo].[users] ([id], [created_date], [last_modified_date], [address], [avatar], [birth_day], [email], [first_name], [gender], [last_login_date], [last_name], [active], [password], [role], [username]) VALUES (N'c0a80069-8c45-147e-818c-45d74fd30001', CAST(N'2023-12-08T02:53:07.7930000' AS DateTime2), CAST(N'2023-12-08T03:02:08.9330000' AS DateTime2), NULL, NULL, NULL, N'dat@gmail.com', NULL, NULL, CAST(N'2023-12-08T03:02:08.9320000' AS DateTime2), NULL, 1, N'$2a$10$waQa4CasBxHplNCLsSSaMeRfxcZBOq4g2IM1d01NLycYuEHvyGL/G', N'ROLE_ADMIN', N'dat12')
INSERT [dbo].[users] ([id], [created_date], [last_modified_date], [address], [avatar], [birth_day], [email], [first_name], [gender], [last_login_date], [last_name], [active], [password], [role], [username]) VALUES (N'c0a80069-8c45-147e-818c-45e108a20002', CAST(N'2023-12-08T03:03:44.9290000' AS DateTime2), CAST(N'2023-12-08T03:03:44.9350000' AS DateTime2), NULL, NULL, NULL, N'mrthor251003@gmail.com', NULL, NULL, CAST(N'2023-12-08T03:03:44.9350000' AS DateTime2), NULL, 1, N'$2a$10$f3Qwcszfy.3u6jTgjZceT.HqeYIN2opQU2Iy7DGIiYCYhBI9GS9a6', N'ROLE_USER', N'107172076954350101603')
INSERT [dbo].[users] ([id], [created_date], [last_modified_date], [address], [avatar], [birth_day], [email], [first_name], [gender], [last_login_date], [last_name], [active], [password], [role], [username]) VALUES (N'c0a80069-8c46-1077-818c-464345090000', CAST(N'2023-12-08T04:51:02.9180000' AS DateTime2), CAST(N'2023-12-08T04:51:02.9180000' AS DateTime2), NULL, NULL, NULL, N'tiendspc04163@fpt.edu.vn', NULL, NULL, NULL, NULL, 1, N'$2a$10$00wv2dVmJfV.n5MMAT2G0eQBKMxPxwfNyu0fqGdTFFBPUYdlokgMS', N'ROLE_USER', N'anhdagia')
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD  CONSTRAINT [FK_comment_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[comment] CHECK CONSTRAINT [FK_comment_users]
GO
ALTER TABLE [dbo].[image_product]  WITH CHECK ADD  CONSTRAINT [FK_image_product_products] FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[image_product] CHECK CONSTRAINT [FK_image_product_products]
GO
ALTER TABLE [dbo].[likes]  WITH CHECK ADD  CONSTRAINT [FK_likes_products] FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[likes] CHECK CONSTRAINT [FK_likes_products]
GO
ALTER TABLE [dbo].[likes]  WITH CHECK ADD  CONSTRAINT [FK_likes_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[likes] CHECK CONSTRAINT [FK_likes_users]
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD  CONSTRAINT [FK_order_details_orders] FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[order_details] CHECK CONSTRAINT [FK_order_details_orders]
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD  CONSTRAINT [FK_order_details_products] FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[order_details] CHECK CONSTRAINT [FK_order_details_products]
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD  CONSTRAINT [FKbepbencqn2uy93dia210dejgj] FOREIGN KEY([color_id])
REFERENCES [dbo].[colors] ([id])
GO
ALTER TABLE [dbo].[order_details] CHECK CONSTRAINT [FKbepbencqn2uy93dia210dejgj]
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD  CONSTRAINT [FKq1pfc355kfs5d2yjbdfhk4m5o] FOREIGN KEY([size_id])
REFERENCES [dbo].[sizes] ([id])
GO
ALTER TABLE [dbo].[order_details] CHECK CONSTRAINT [FKq1pfc355kfs5d2yjbdfhk4m5o]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FK_orders_order_address] FOREIGN KEY([order_address_id])
REFERENCES [dbo].[order_address] ([id])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FK_orders_order_address]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_brands] FOREIGN KEY([brand_id])
REFERENCES [dbo].[brands] ([id])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_products_brands]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_categories] FOREIGN KEY([category_id])
REFERENCES [dbo].[categories] ([id])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_products_categories]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_colors] FOREIGN KEY([color_id])
REFERENCES [dbo].[colors] ([id])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_products_colors]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_comment] FOREIGN KEY([comment_id])
REFERENCES [dbo].[comment] ([id])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_products_comment]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_sizes] FOREIGN KEY([size_id])
REFERENCES [dbo].[sizes] ([id])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_products_sizes]
GO
USE [master]
GO
ALTER DATABASE [DDTShopp] SET  READ_WRITE 
GO
