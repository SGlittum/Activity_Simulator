USE [master]
GO
/****** Object:  Database [ActivityDB]    Script Date: 24.04.2018 22.41.24 ******/
CREATE DATABASE [ActivityDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ActivityDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ActivityDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ActivityDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ActivityDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ActivityDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ActivityDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ActivityDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ActivityDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ActivityDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ActivityDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ActivityDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ActivityDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ActivityDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ActivityDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ActivityDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ActivityDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ActivityDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ActivityDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ActivityDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ActivityDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ActivityDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ActivityDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ActivityDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ActivityDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ActivityDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ActivityDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ActivityDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ActivityDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ActivityDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ActivityDB] SET  MULTI_USER 
GO
ALTER DATABASE [ActivityDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ActivityDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ActivityDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ActivityDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ActivityDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ActivityDB] SET QUERY_STORE = OFF
GO
USE [ActivityDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [ActivityDB]
GO
/****** Object:  Table [dbo].[Activity]    Script Date: 24.04.2018 22.41.24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Activity](
	[ActivityId] [int] IDENTITY(1,1) NOT NULL,
	[Activity] [varchar](50) NULL,
 CONSTRAINT [PK_Activity] PRIMARY KEY CLUSTERED 
(
	[ActivityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActivityData]    Script Date: 24.04.2018 22.41.24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityData](
	[ActivityDataId] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [datetime2](7) NOT NULL,
	[EndTime] [datetime2](7) NOT NULL,
	[SensorLocationId] [int] NOT NULL,
	[ActivityId] [int] NULL,
	[DatasetIndex] [int] NULL,
 CONSTRAINT [PK_Behaviour_Import_3] PRIMARY KEY CLUSTERED 
(
	[ActivityDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActivityPosition]    Script Date: 24.04.2018 22.41.24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityPosition](
	[ActivityPositionId] [int] IDENTITY(1,1) NOT NULL,
	[Position] [varchar](50) NULL,
	[XPos] [float] NULL,
	[YPos] [float] NULL,
	[ActivityId] [int] NULL,
	[ConfigId] [int] NULL,
 CONSTRAINT [PK_ActivityLocationConfig] PRIMARY KEY CLUSTERED 
(
	[ActivityPositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Config]    Script Date: 24.04.2018 22.41.24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Config](
	[ConfigId] [int] NOT NULL,
 CONSTRAINT [PK_Config] PRIMARY KEY CLUSTERED 
(
	[ConfigId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataSet]    Script Date: 24.04.2018 22.41.24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSet](
	[DataSetIndex] [int] NOT NULL,
	[StartTime] [datetime2](7) NULL,
	[EndTime] [datetime2](7) NULL,
 CONSTRAINT [PK_DataSet] PRIMARY KEY CLUSTERED 
(
	[DataSetIndex] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoorsPosition]    Script Date: 24.04.2018 22.41.24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoorsPosition](
	[DoorsPositionId] [int] IDENTITY(1,1) NOT NULL,
	[VerticalPosition] [float] NULL,
	[ConfigId] [int] NULL,
 CONSTRAINT [PK_DoorsPosition] PRIMARY KEY CLUSTERED 
(
	[DoorsPositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 24.04.2018 22.41.24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[RoomId] [int] IDENTITY(1,1) NOT NULL,
	[Room] [varchar](50) NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room_Activity_Mapping]    Script Date: 24.04.2018 22.41.24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room_Activity_Mapping](
	[RoomId] [int] NOT NULL,
	[ActivityId] [int] NOT NULL,
 CONSTRAINT [PK_Room_Activity_Mapping] PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC,
	[ActivityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SensorLocation]    Script Date: 24.04.2018 22.41.24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SensorLocation](
	[SensorLocationId] [int] IDENTITY(1,1) NOT NULL,
	[Location] [varchar](50) NULL,
	[SensorTypeId] [int] NULL,
	[RoomId] [int] NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[SensorLocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SensorType]    Script Date: 24.04.2018 22.41.24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SensorType](
	[SensorTypeId] [int] IDENTITY(1,1) NOT NULL,
	[SensorType] [varchar](50) NULL,
 CONSTRAINT [PK_Sensor] PRIMARY KEY CLUSTERED 
(
	[SensorTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Activity] ON 
GO
INSERT [dbo].[Activity] ([ActivityId], [Activity]) VALUES (1, N'Sleeping')
GO
INSERT [dbo].[Activity] ([ActivityId], [Activity]) VALUES (2, N'Toileting')
GO
INSERT [dbo].[Activity] ([ActivityId], [Activity]) VALUES (3, N'Showering')
GO
INSERT [dbo].[Activity] ([ActivityId], [Activity]) VALUES (4, N'Breakfast')
GO
INSERT [dbo].[Activity] ([ActivityId], [Activity]) VALUES (5, N'Grooming')
GO
INSERT [dbo].[Activity] ([ActivityId], [Activity]) VALUES (6, N'SpareTime/TV')
GO
INSERT [dbo].[Activity] ([ActivityId], [Activity]) VALUES (7, N'Leaving')
GO
INSERT [dbo].[Activity] ([ActivityId], [Activity]) VALUES (8, N'Lunch')
GO
INSERT [dbo].[Activity] ([ActivityId], [Activity]) VALUES (9, N'Snack')
GO
SET IDENTITY_INSERT [dbo].[Activity] OFF
GO
SET IDENTITY_INSERT [dbo].[ActivityData] ON 
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (1, CAST(N'2011-11-28T02:27:59.0000000' AS DateTime2), CAST(N'2011-11-28T10:18:11.0000000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (2, CAST(N'2011-11-28T10:21:24.0000000' AS DateTime2), CAST(N'2011-11-28T10:21:31.0000000' AS DateTime2), 2, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (3, CAST(N'2011-11-28T10:21:44.0000000' AS DateTime2), CAST(N'2011-11-28T10:23:31.0000000' AS DateTime2), 3, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (4, CAST(N'2011-11-28T10:23:02.0000000' AS DateTime2), CAST(N'2011-11-28T10:23:36.0000000' AS DateTime2), 4, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (5, CAST(N'2011-11-28T10:25:44.0000000' AS DateTime2), CAST(N'2011-11-28T10:32:06.0000000' AS DateTime2), 5, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (6, CAST(N'2011-11-28T10:34:23.0000000' AS DateTime2), CAST(N'2011-11-28T10:34:41.0000000' AS DateTime2), 6, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (7, CAST(N'2011-11-28T10:34:44.0000000' AS DateTime2), CAST(N'2011-11-28T10:37:17.0000000' AS DateTime2), 7, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (8, CAST(N'2011-11-28T10:38:00.0000000' AS DateTime2), CAST(N'2011-11-28T10:42:41.0000000' AS DateTime2), 8, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (9, CAST(N'2011-11-28T10:38:33.0000000' AS DateTime2), CAST(N'2011-11-28T10:38:40.0000000' AS DateTime2), 6, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (10, CAST(N'2011-11-28T10:41:29.0000000' AS DateTime2), CAST(N'2011-11-28T10:41:36.0000000' AS DateTime2), 7, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (11, CAST(N'2011-11-28T10:41:43.0000000' AS DateTime2), CAST(N'2011-11-28T10:41:59.0000000' AS DateTime2), 9, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (12, CAST(N'2011-11-28T10:41:59.0000000' AS DateTime2), CAST(N'2011-11-28T10:42:55.0000000' AS DateTime2), 10, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (13, CAST(N'2011-11-28T10:49:48.0000000' AS DateTime2), CAST(N'2011-11-28T10:51:13.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (14, CAST(N'2011-11-28T10:51:41.0000000' AS DateTime2), CAST(N'2011-11-28T13:05:07.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (15, CAST(N'2011-11-28T13:06:04.0000000' AS DateTime2), CAST(N'2011-11-28T13:06:06.0000000' AS DateTime2), 3, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (16, CAST(N'2011-11-28T13:06:07.0000000' AS DateTime2), CAST(N'2011-11-28T13:06:31.0000000' AS DateTime2), 4, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (17, CAST(N'2011-11-28T13:09:31.0000000' AS DateTime2), CAST(N'2011-11-28T13:09:35.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (18, CAST(N'2011-11-28T13:28:59.0000000' AS DateTime2), CAST(N'2011-11-28T13:29:09.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (19, CAST(N'2011-11-28T13:33:32.0000000' AS DateTime2), CAST(N'2011-11-28T13:38:23.0000000' AS DateTime2), 6, 9, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (20, CAST(N'2011-11-28T13:38:40.0000000' AS DateTime2), CAST(N'2011-11-28T14:21:40.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (21, CAST(N'2011-11-28T14:26:38.0000000' AS DateTime2), CAST(N'2011-11-28T14:27:07.0000000' AS DateTime2), 4, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (22, CAST(N'2011-11-28T14:27:11.0000000' AS DateTime2), CAST(N'2011-11-28T14:28:46.0000000' AS DateTime2), 6, 8, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (23, CAST(N'2011-11-28T14:28:48.0000000' AS DateTime2), CAST(N'2011-11-28T14:28:55.0000000' AS DateTime2), 7, 8, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (24, CAST(N'2011-11-28T14:31:06.0000000' AS DateTime2), CAST(N'2011-11-28T14:41:54.0000000' AS DateTime2), 9, 8, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (25, CAST(N'2011-11-28T14:31:44.0000000' AS DateTime2), CAST(N'2011-11-28T14:31:56.0000000' AS DateTime2), 7, 8, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (26, CAST(N'2011-11-28T14:35:22.0000000' AS DateTime2), CAST(N'2011-11-28T14:35:27.0000000' AS DateTime2), 6, 8, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (27, CAST(N'2011-11-28T15:04:59.0000000' AS DateTime2), CAST(N'2011-11-28T15:06:29.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (28, CAST(N'2011-11-28T15:07:01.0000000' AS DateTime2), CAST(N'2011-11-28T16:09:57.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (29, CAST(N'2011-11-28T16:10:05.0000000' AS DateTime2), CAST(N'2011-11-28T16:10:05.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (30, CAST(N'2011-11-28T16:10:38.0000000' AS DateTime2), CAST(N'2011-11-28T20:19:27.0000000' AS DateTime2), 11, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (31, CAST(N'2011-11-28T20:20:55.0000000' AS DateTime2), CAST(N'2011-11-28T20:20:59.0000000' AS DateTime2), 6, 9, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (32, CAST(N'2011-11-28T20:21:15.0000000' AS DateTime2), CAST(N'2011-11-29T02:06:51.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (33, CAST(N'2011-11-29T02:16:05.0000000' AS DateTime2), CAST(N'2011-11-29T11:31:04.0000000' AS DateTime2), 1, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (34, CAST(N'2011-11-29T11:37:16.0000000' AS DateTime2), CAST(N'2011-11-29T11:37:27.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (35, CAST(N'2011-11-29T11:37:38.0000000' AS DateTime2), CAST(N'2011-11-29T11:48:29.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (36, CAST(N'2011-11-29T11:38:16.0000000' AS DateTime2), CAST(N'2011-11-29T11:38:37.0000000' AS DateTime2), 2, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (37, CAST(N'2011-11-29T11:48:52.0000000' AS DateTime2), CAST(N'2011-11-29T11:48:54.0000000' AS DateTime2), 2, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (38, CAST(N'2011-11-29T11:49:57.0000000' AS DateTime2), CAST(N'2011-11-29T11:51:13.0000000' AS DateTime2), 5, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (39, CAST(N'2011-11-29T12:08:28.0000000' AS DateTime2), CAST(N'2011-11-29T12:09:21.0000000' AS DateTime2), 7, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (40, CAST(N'2011-11-29T12:09:09.0000000' AS DateTime2), CAST(N'2011-11-29T12:13:02.0000000' AS DateTime2), 8, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (41, CAST(N'2011-11-29T12:09:24.0000000' AS DateTime2), CAST(N'2011-11-29T12:09:37.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (42, CAST(N'2011-11-29T12:09:42.0000000' AS DateTime2), CAST(N'2011-11-29T12:10:37.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (43, CAST(N'2011-11-29T12:19:16.0000000' AS DateTime2), CAST(N'2011-11-29T12:19:19.0000000' AS DateTime2), 2, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (44, CAST(N'2011-11-29T12:19:24.0000000' AS DateTime2), CAST(N'2011-11-29T12:21:11.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (45, CAST(N'2011-11-29T12:21:56.0000000' AS DateTime2), CAST(N'2011-11-29T12:21:58.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (46, CAST(N'2011-11-29T12:22:38.0000000' AS DateTime2), CAST(N'2011-11-29T13:25:15.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (47, CAST(N'2011-11-29T13:25:29.0000000' AS DateTime2), CAST(N'2011-11-29T13:25:32.0000000' AS DateTime2), 6, 9, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (48, CAST(N'2011-11-29T13:25:38.0000000' AS DateTime2), CAST(N'2011-11-29T15:12:26.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (49, CAST(N'2011-11-29T15:13:28.0000000' AS DateTime2), CAST(N'2011-11-29T15:13:57.0000000' AS DateTime2), 4, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (50, CAST(N'2011-11-29T15:13:32.0000000' AS DateTime2), CAST(N'2011-11-29T15:13:34.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (51, CAST(N'2011-11-29T15:14:33.0000000' AS DateTime2), CAST(N'2011-11-29T15:15:09.0000000' AS DateTime2), 7, 8, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (52, CAST(N'2011-11-29T15:15:14.0000000' AS DateTime2), CAST(N'2011-11-29T15:36:26.0000000' AS DateTime2), 9, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (53, CAST(N'2011-11-29T15:15:17.0000000' AS DateTime2), CAST(N'2011-11-29T15:22:57.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (54, CAST(N'2011-11-29T15:15:27.0000000' AS DateTime2), CAST(N'2011-11-29T15:16:39.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (55, CAST(N'2011-11-29T15:24:13.0000000' AS DateTime2), CAST(N'2011-11-29T15:24:41.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (56, CAST(N'2011-11-29T15:24:39.0000000' AS DateTime2), CAST(N'2011-11-29T15:24:45.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (57, CAST(N'2011-11-29T15:45:49.0000000' AS DateTime2), CAST(N'2011-11-29T15:45:54.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (58, CAST(N'2011-11-29T15:49:51.0000000' AS DateTime2), CAST(N'2011-11-29T15:50:54.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (59, CAST(N'2011-11-29T15:52:04.0000000' AS DateTime2), CAST(N'2011-11-29T16:17:58.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (60, CAST(N'2011-11-29T16:31:16.0000000' AS DateTime2), CAST(N'2011-11-29T16:31:27.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (61, CAST(N'2011-11-29T16:32:20.0000000' AS DateTime2), CAST(N'2011-11-29T16:32:23.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (62, CAST(N'2011-11-29T16:34:17.0000000' AS DateTime2), CAST(N'2011-11-29T17:08:07.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (63, CAST(N'2011-11-29T17:08:58.0000000' AS DateTime2), CAST(N'2011-11-29T17:09:00.0000000' AS DateTime2), 3, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (64, CAST(N'2011-11-29T17:09:04.0000000' AS DateTime2), CAST(N'2011-11-29T17:09:29.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (65, CAST(N'2011-11-29T17:09:09.0000000' AS DateTime2), CAST(N'2011-11-29T18:57:22.0000000' AS DateTime2), 11, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (66, CAST(N'2011-11-29T19:02:15.0000000' AS DateTime2), CAST(N'2011-11-29T19:02:21.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (67, CAST(N'2011-11-29T20:23:32.0000000' AS DateTime2), CAST(N'2011-11-29T20:23:38.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (68, CAST(N'2011-11-29T20:28:08.0000000' AS DateTime2), CAST(N'2011-11-30T01:19:47.0000000' AS DateTime2), 11, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (69, CAST(N'2011-11-30T01:22:33.0000000' AS DateTime2), CAST(N'2011-11-30T10:07:31.0000000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (70, CAST(N'2011-11-30T10:14:07.0000000' AS DateTime2), CAST(N'2011-11-30T10:14:34.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (71, CAST(N'2011-11-30T10:14:45.0000000' AS DateTime2), CAST(N'2011-11-30T10:18:33.0000000' AS DateTime2), 5, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (72, CAST(N'2011-11-30T10:23:02.0000000' AS DateTime2), CAST(N'2011-11-30T10:23:17.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (73, CAST(N'2011-11-30T10:23:21.0000000' AS DateTime2), CAST(N'2011-11-30T10:23:36.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (74, CAST(N'2011-11-30T10:23:46.0000000' AS DateTime2), CAST(N'2011-11-30T10:28:38.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (75, CAST(N'2011-11-30T10:24:10.0000000' AS DateTime2), CAST(N'2011-11-30T10:27:58.0000000' AS DateTime2), 8, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (76, CAST(N'2011-11-30T10:39:30.0000000' AS DateTime2), CAST(N'2011-11-30T10:41:13.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (77, CAST(N'2011-11-30T10:39:42.0000000' AS DateTime2), CAST(N'2011-11-30T10:39:45.0000000' AS DateTime2), 2, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (78, CAST(N'2011-11-30T10:41:38.0000000' AS DateTime2), CAST(N'2011-11-30T13:05:01.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (79, CAST(N'2011-11-30T13:05:27.0000000' AS DateTime2), CAST(N'2011-11-30T13:05:31.0000000' AS DateTime2), 6, 9, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (80, CAST(N'2011-11-30T13:05:38.0000000' AS DateTime2), CAST(N'2011-11-30T14:09:34.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (81, CAST(N'2011-11-30T14:11:16.0000000' AS DateTime2), CAST(N'2011-11-30T14:11:48.0000000' AS DateTime2), 4, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (82, CAST(N'2011-11-30T14:11:22.0000000' AS DateTime2), CAST(N'2011-11-30T14:11:24.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (83, CAST(N'2011-11-30T14:13:45.0000000' AS DateTime2), CAST(N'2011-11-30T14:34:09.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (84, CAST(N'2011-11-30T14:39:42.0000000' AS DateTime2), CAST(N'2011-11-30T14:55:24.0000000' AS DateTime2), 9, 8, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (85, CAST(N'2011-11-30T14:40:14.0000000' AS DateTime2), CAST(N'2011-11-30T14:40:24.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (86, CAST(N'2011-11-30T14:41:57.0000000' AS DateTime2), CAST(N'2011-11-30T14:42:12.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (87, CAST(N'2011-11-30T14:46:46.0000000' AS DateTime2), CAST(N'2011-11-30T14:46:50.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (88, CAST(N'2011-11-30T14:50:19.0000000' AS DateTime2), CAST(N'2011-11-30T14:50:33.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (89, CAST(N'2011-11-30T15:11:48.0000000' AS DateTime2), CAST(N'2011-11-30T16:39:11.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (90, CAST(N'2011-11-30T16:40:00.0000000' AS DateTime2), CAST(N'2011-11-30T16:40:24.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (91, CAST(N'2011-11-30T16:40:04.0000000' AS DateTime2), CAST(N'2011-11-30T16:40:09.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (92, CAST(N'2011-11-30T16:41:05.0000000' AS DateTime2), CAST(N'2011-11-30T16:41:09.0000000' AS DateTime2), 6, 9, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (93, CAST(N'2011-11-30T16:41:15.0000000' AS DateTime2), CAST(N'2011-11-30T18:00:38.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (94, CAST(N'2011-11-30T18:01:44.0000000' AS DateTime2), CAST(N'2011-11-30T18:01:47.0000000' AS DateTime2), 3, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (95, CAST(N'2011-11-30T18:01:46.0000000' AS DateTime2), CAST(N'2011-11-30T18:02:11.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (96, CAST(N'2011-11-30T18:01:54.0000000' AS DateTime2), CAST(N'2011-11-30T18:43:20.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (97, CAST(N'2011-11-30T18:57:08.0000000' AS DateTime2), CAST(N'2011-11-30T18:57:34.0000000' AS DateTime2), 4, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (98, CAST(N'2011-11-30T18:57:39.0000000' AS DateTime2), CAST(N'2011-11-30T19:37:10.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (99, CAST(N'2011-11-30T19:37:36.0000000' AS DateTime2), CAST(N'2011-11-30T19:38:01.0000000' AS DateTime2), 4, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (100, CAST(N'2011-11-30T19:37:40.0000000' AS DateTime2), CAST(N'2011-11-30T19:37:46.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (101, CAST(N'2011-11-30T19:46:44.0000000' AS DateTime2), CAST(N'2011-11-30T19:46:49.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (102, CAST(N'2011-11-30T20:05:07.0000000' AS DateTime2), CAST(N'2011-11-30T20:05:12.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (103, CAST(N'2011-11-30T20:08:39.0000000' AS DateTime2), CAST(N'2011-11-30T20:08:44.0000000' AS DateTime2), 11, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (104, CAST(N'2011-11-30T20:09:07.0000000' AS DateTime2), CAST(N'2011-11-30T20:13:18.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (105, CAST(N'2011-11-30T20:13:39.0000000' AS DateTime2), CAST(N'2011-11-30T20:13:48.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (106, CAST(N'2011-11-30T20:14:03.0000000' AS DateTime2), CAST(N'2011-12-01T01:34:27.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (107, CAST(N'2011-12-01T01:37:52.0000000' AS DateTime2), CAST(N'2011-12-01T10:50:45.0000000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (108, CAST(N'2011-12-01T10:55:03.0000000' AS DateTime2), CAST(N'2011-12-01T10:55:32.0000000' AS DateTime2), 4, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (109, CAST(N'2011-12-01T10:55:08.0000000' AS DateTime2), CAST(N'2011-12-01T10:55:13.0000000' AS DateTime2), 2, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (110, CAST(N'2011-12-01T10:55:16.0000000' AS DateTime2), CAST(N'2011-12-01T10:55:25.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (111, CAST(N'2011-12-01T10:58:37.0000000' AS DateTime2), CAST(N'2011-12-01T11:12:22.0000000' AS DateTime2), 5, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (112, CAST(N'2011-12-01T11:17:05.0000000' AS DateTime2), CAST(N'2011-12-01T11:19:49.0000000' AS DateTime2), 8, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (113, CAST(N'2011-12-01T11:17:14.0000000' AS DateTime2), CAST(N'2011-12-01T11:17:26.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (114, CAST(N'2011-12-01T11:17:29.0000000' AS DateTime2), CAST(N'2011-12-01T11:17:43.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (115, CAST(N'2011-12-01T11:17:49.0000000' AS DateTime2), CAST(N'2011-12-01T11:19:43.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (116, CAST(N'2011-12-01T11:30:06.0000000' AS DateTime2), CAST(N'2011-12-01T14:29:02.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (117, CAST(N'2011-12-01T14:08:19.0000000' AS DateTime2), CAST(N'2011-12-01T14:08:22.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (118, CAST(N'2011-12-01T14:29:37.0000000' AS DateTime2), CAST(N'2011-12-01T14:52:02.0000000' AS DateTime2), 9, 8, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (119, CAST(N'2011-12-01T14:29:48.0000000' AS DateTime2), CAST(N'2011-12-01T14:36:38.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (120, CAST(N'2011-12-01T14:38:25.0000000' AS DateTime2), CAST(N'2011-12-01T14:38:54.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (121, CAST(N'2011-12-01T14:49:15.0000000' AS DateTime2), CAST(N'2011-12-01T14:49:19.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (122, CAST(N'2011-12-01T15:09:00.0000000' AS DateTime2), CAST(N'2011-12-01T16:26:17.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (123, CAST(N'2011-12-01T16:26:35.0000000' AS DateTime2), CAST(N'2011-12-01T16:27:04.0000000' AS DateTime2), 4, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (124, CAST(N'2011-12-01T16:26:36.0000000' AS DateTime2), CAST(N'2011-12-01T17:27:13.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (125, CAST(N'2011-12-01T17:29:29.0000000' AS DateTime2), CAST(N'2011-12-01T17:29:58.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (126, CAST(N'2011-12-01T18:49:46.0000000' AS DateTime2), CAST(N'2011-12-01T18:49:51.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (127, CAST(N'2011-12-01T18:54:52.0000000' AS DateTime2), CAST(N'2011-12-01T18:54:56.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (128, CAST(N'2011-12-01T18:55:03.0000000' AS DateTime2), CAST(N'2011-12-01T19:10:34.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (129, CAST(N'2011-12-01T19:28:51.0000000' AS DateTime2), CAST(N'2011-12-01T19:29:17.0000000' AS DateTime2), 4, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (130, CAST(N'2011-12-01T19:29:13.0000000' AS DateTime2), CAST(N'2011-12-01T23:52:52.0000000' AS DateTime2), 11, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (131, CAST(N'2011-12-01T23:53:00.0000000' AS DateTime2), CAST(N'2011-12-01T23:53:28.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (132, CAST(N'2011-12-01T23:54:32.0000000' AS DateTime2), CAST(N'2011-12-02T01:18:32.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (133, CAST(N'2011-12-02T01:18:44.0000000' AS DateTime2), CAST(N'2011-12-02T01:18:57.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (134, CAST(N'2011-12-02T01:19:09.0000000' AS DateTime2), CAST(N'2011-12-02T02:08:17.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (135, CAST(N'2011-12-02T02:09:33.0000000' AS DateTime2), CAST(N'2011-12-02T02:13:56.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (136, CAST(N'2011-12-02T02:15:55.0000000' AS DateTime2), CAST(N'2011-12-02T12:15:19.0000000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (137, CAST(N'2011-12-02T12:20:40.0000000' AS DateTime2), CAST(N'2011-12-02T12:21:09.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (138, CAST(N'2011-12-02T12:20:41.0000000' AS DateTime2), CAST(N'2011-12-02T12:20:46.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (139, CAST(N'2011-12-02T12:21:02.0000000' AS DateTime2), CAST(N'2011-12-02T12:21:06.0000000' AS DateTime2), 2, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (140, CAST(N'2011-12-02T12:21:19.0000000' AS DateTime2), CAST(N'2011-12-02T12:25:40.0000000' AS DateTime2), 5, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (141, CAST(N'2011-12-02T12:27:47.0000000' AS DateTime2), CAST(N'2011-12-02T12:28:03.0000000' AS DateTime2), 7, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (142, CAST(N'2011-12-02T12:28:45.0000000' AS DateTime2), CAST(N'2011-12-02T12:29:02.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (143, CAST(N'2011-12-02T12:29:08.0000000' AS DateTime2), CAST(N'2011-12-02T12:31:50.0000000' AS DateTime2), 8, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (144, CAST(N'2011-12-02T12:29:25.0000000' AS DateTime2), CAST(N'2011-12-02T12:31:10.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (145, CAST(N'2011-12-02T12:37:47.0000000' AS DateTime2), CAST(N'2011-12-02T14:46:29.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (146, CAST(N'2011-12-02T14:46:59.0000000' AS DateTime2), CAST(N'2011-12-02T14:47:08.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (147, CAST(N'2011-12-02T14:47:18.0000000' AS DateTime2), CAST(N'2011-12-02T15:05:06.0000000' AS DateTime2), 9, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (148, CAST(N'2011-12-02T14:47:22.0000000' AS DateTime2), CAST(N'2011-12-02T14:50:19.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (149, CAST(N'2011-12-02T14:56:44.0000000' AS DateTime2), CAST(N'2011-12-02T14:56:49.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (150, CAST(N'2011-12-02T14:59:11.0000000' AS DateTime2), CAST(N'2011-12-02T14:59:15.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (151, CAST(N'2011-12-02T15:24:05.0000000' AS DateTime2), CAST(N'2011-12-02T15:55:12.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (152, CAST(N'2011-12-02T15:56:02.0000000' AS DateTime2), CAST(N'2011-12-02T15:57:55.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (153, CAST(N'2011-12-02T15:57:56.0000000' AS DateTime2), CAST(N'2011-12-02T16:36:05.0000000' AS DateTime2), 11, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (154, CAST(N'2011-12-02T16:47:27.0000000' AS DateTime2), CAST(N'2011-12-02T16:47:55.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (155, CAST(N'2011-12-02T16:47:39.0000000' AS DateTime2), CAST(N'2011-12-02T19:39:08.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (156, CAST(N'2011-12-02T19:40:44.0000000' AS DateTime2), CAST(N'2011-12-02T19:40:50.0000000' AS DateTime2), 6, 9, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (157, CAST(N'2011-12-02T19:41:14.0000000' AS DateTime2), CAST(N'2011-12-02T21:26:09.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (158, CAST(N'2011-12-02T21:44:37.0000000' AS DateTime2), CAST(N'2011-12-02T21:45:03.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (159, CAST(N'2011-12-02T21:46:31.0000000' AS DateTime2), CAST(N'2011-12-03T01:41:08.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (160, CAST(N'2011-12-03T01:47:02.0000000' AS DateTime2), CAST(N'2011-12-03T11:56:20.0000000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (161, CAST(N'2011-12-03T11:59:15.0000000' AS DateTime2), CAST(N'2011-12-03T11:59:45.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (162, CAST(N'2011-12-03T11:59:33.0000000' AS DateTime2), CAST(N'2011-12-03T11:59:36.0000000' AS DateTime2), 2, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (163, CAST(N'2011-12-03T11:59:42.0000000' AS DateTime2), CAST(N'2011-12-03T12:01:34.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (164, CAST(N'2011-12-03T12:03:36.0000000' AS DateTime2), CAST(N'2011-12-03T12:06:26.0000000' AS DateTime2), 5, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (165, CAST(N'2011-12-03T12:08:53.0000000' AS DateTime2), CAST(N'2011-12-03T12:08:55.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (166, CAST(N'2011-12-03T12:10:35.0000000' AS DateTime2), CAST(N'2011-12-03T12:13:51.0000000' AS DateTime2), 8, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (167, CAST(N'2011-12-03T12:10:42.0000000' AS DateTime2), CAST(N'2011-12-03T12:10:51.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (168, CAST(N'2011-12-03T12:10:55.0000000' AS DateTime2), CAST(N'2011-12-03T12:11:16.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (169, CAST(N'2011-12-03T12:11:36.0000000' AS DateTime2), CAST(N'2011-12-03T12:13:58.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (170, CAST(N'2011-12-03T12:21:30.0000000' AS DateTime2), CAST(N'2011-12-03T13:28:36.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (171, CAST(N'2011-12-03T13:29:22.0000000' AS DateTime2), CAST(N'2011-12-03T13:29:32.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (172, CAST(N'2011-12-03T13:29:48.0000000' AS DateTime2), CAST(N'2011-12-03T14:01:20.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (173, CAST(N'2011-12-03T14:11:10.0000000' AS DateTime2), CAST(N'2011-12-03T14:14:43.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (174, CAST(N'2011-12-03T14:18:11.0000000' AS DateTime2), CAST(N'2011-12-03T14:18:23.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (175, CAST(N'2011-12-03T17:48:33.0000000' AS DateTime2), CAST(N'2011-12-03T17:48:37.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (176, CAST(N'2011-12-03T17:50:14.0000000' AS DateTime2), CAST(N'2011-12-03T20:37:41.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (177, CAST(N'2011-12-03T20:37:49.0000000' AS DateTime2), CAST(N'2011-12-03T20:38:07.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (178, CAST(N'2011-12-03T20:38:15.0000000' AS DateTime2), CAST(N'2011-12-03T23:53:24.0000000' AS DateTime2), 11, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (179, CAST(N'2011-12-03T23:54:51.0000000' AS DateTime2), CAST(N'2011-12-03T23:55:21.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (180, CAST(N'2011-12-03T23:55:18.0000000' AS DateTime2), CAST(N'2011-12-04T03:16:13.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (181, CAST(N'2011-12-04T03:19:17.0000000' AS DateTime2), CAST(N'2011-12-04T12:37:49.0000000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (182, CAST(N'2011-12-04T12:45:44.0000000' AS DateTime2), CAST(N'2011-12-04T12:46:15.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (183, CAST(N'2011-12-04T12:46:11.0000000' AS DateTime2), CAST(N'2011-12-04T12:46:15.0000000' AS DateTime2), 2, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (184, CAST(N'2011-12-04T12:46:20.0000000' AS DateTime2), CAST(N'2011-12-04T12:47:28.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (185, CAST(N'2011-12-04T12:50:56.0000000' AS DateTime2), CAST(N'2011-12-04T12:54:55.0000000' AS DateTime2), 5, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (186, CAST(N'2011-12-04T12:56:08.0000000' AS DateTime2), CAST(N'2011-12-04T12:56:20.0000000' AS DateTime2), 6, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (187, CAST(N'2011-12-04T12:56:21.0000000' AS DateTime2), CAST(N'2011-12-04T12:56:33.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (188, CAST(N'2011-12-04T12:56:43.0000000' AS DateTime2), CAST(N'2011-12-04T12:58:48.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (189, CAST(N'2011-12-04T12:56:47.0000000' AS DateTime2), CAST(N'2011-12-04T12:58:37.0000000' AS DateTime2), 8, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (190, CAST(N'2011-12-04T13:00:53.0000000' AS DateTime2), CAST(N'2011-12-04T13:58:10.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (191, CAST(N'2011-12-04T14:03:42.0000000' AS DateTime2), CAST(N'2011-12-04T14:04:13.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (192, CAST(N'2011-12-04T14:11:50.0000000' AS DateTime2), CAST(N'2011-12-04T14:11:54.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (193, CAST(N'2011-12-04T16:30:57.0000000' AS DateTime2), CAST(N'2011-12-04T16:31:01.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (194, CAST(N'2011-12-04T16:34:00.0000000' AS DateTime2), CAST(N'2011-12-04T17:25:39.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (195, CAST(N'2011-12-04T17:27:03.0000000' AS DateTime2), CAST(N'2011-12-04T17:27:08.0000000' AS DateTime2), 6, 9, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (196, CAST(N'2011-12-04T17:27:16.0000000' AS DateTime2), CAST(N'2011-12-04T17:43:56.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (197, CAST(N'2011-12-04T17:45:15.0000000' AS DateTime2), CAST(N'2011-12-04T17:45:19.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (198, CAST(N'2011-12-04T18:08:28.0000000' AS DateTime2), CAST(N'2011-12-04T18:57:52.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (199, CAST(N'2011-12-04T18:59:06.0000000' AS DateTime2), CAST(N'2011-12-04T18:59:33.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (200, CAST(N'2011-12-04T18:59:09.0000000' AS DateTime2), CAST(N'2011-12-04T18:59:12.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (201, CAST(N'2011-12-04T18:59:53.0000000' AS DateTime2), CAST(N'2011-12-04T18:59:59.0000000' AS DateTime2), 6, 9, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (202, CAST(N'2011-12-04T19:00:04.0000000' AS DateTime2), CAST(N'2011-12-04T22:20:59.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (203, CAST(N'2011-12-04T22:21:42.0000000' AS DateTime2), CAST(N'2011-12-04T22:22:10.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (204, CAST(N'2011-12-04T22:21:45.0000000' AS DateTime2), CAST(N'2011-12-04T22:21:57.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (205, CAST(N'2011-12-04T22:22:19.0000000' AS DateTime2), CAST(N'2011-12-05T01:28:09.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (206, CAST(N'2011-12-05T01:31:34.0000000' AS DateTime2), CAST(N'2011-12-05T01:31:39.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (207, CAST(N'2011-12-05T01:35:10.0000000' AS DateTime2), CAST(N'2011-12-05T11:48:55.0000000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (208, CAST(N'2011-12-05T11:53:01.0000000' AS DateTime2), CAST(N'2011-12-05T11:53:31.0000000' AS DateTime2), 4, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (209, CAST(N'2011-12-05T11:57:47.0000000' AS DateTime2), CAST(N'2011-12-05T11:57:55.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (210, CAST(N'2011-12-05T12:01:23.0000000' AS DateTime2), CAST(N'2011-12-05T12:08:56.0000000' AS DateTime2), 5, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (211, CAST(N'2011-12-05T12:10:06.0000000' AS DateTime2), CAST(N'2011-12-05T12:14:19.0000000' AS DateTime2), 11, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (212, CAST(N'2011-12-05T12:14:49.0000000' AS DateTime2), CAST(N'2011-12-05T12:14:55.0000000' AS DateTime2), 7, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (213, CAST(N'2011-12-05T12:14:58.0000000' AS DateTime2), CAST(N'2011-12-05T12:15:29.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (214, CAST(N'2011-12-05T12:15:45.0000000' AS DateTime2), CAST(N'2011-12-05T12:17:41.0000000' AS DateTime2), 8, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (215, CAST(N'2011-12-05T12:15:55.0000000' AS DateTime2), CAST(N'2011-12-05T12:17:58.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (216, CAST(N'2011-12-05T12:16:02.0000000' AS DateTime2), CAST(N'2011-12-05T12:16:06.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (217, CAST(N'2011-12-05T12:26:37.0000000' AS DateTime2), CAST(N'2011-12-05T14:26:46.0000000' AS DateTime2), 11, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (218, CAST(N'2011-12-05T14:28:36.0000000' AS DateTime2), CAST(N'2011-12-05T14:28:42.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (219, CAST(N'2011-12-05T14:38:07.0000000' AS DateTime2), CAST(N'2011-12-05T14:38:32.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (220, CAST(N'2011-12-05T14:55:00.0000000' AS DateTime2), CAST(N'2011-12-05T14:55:06.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (221, CAST(N'2011-12-05T14:57:51.0000000' AS DateTime2), CAST(N'2011-12-05T15:00:54.0000000' AS DateTime2), 6, 8, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (222, CAST(N'2011-12-05T15:00:10.0000000' AS DateTime2), CAST(N'2011-12-05T15:00:25.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (223, CAST(N'2011-12-05T15:00:55.0000000' AS DateTime2), CAST(N'2011-12-05T15:21:30.0000000' AS DateTime2), 9, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (224, CAST(N'2011-12-05T15:00:58.0000000' AS DateTime2), CAST(N'2011-12-05T15:13:55.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (225, CAST(N'2011-12-05T15:11:41.0000000' AS DateTime2), CAST(N'2011-12-05T15:11:45.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (226, CAST(N'2011-12-05T15:15:04.0000000' AS DateTime2), CAST(N'2011-12-05T15:15:10.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (227, CAST(N'2011-12-05T15:18:33.0000000' AS DateTime2), CAST(N'2011-12-05T15:18:37.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (228, CAST(N'2011-12-05T15:33:05.0000000' AS DateTime2), CAST(N'2011-12-05T15:33:15.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (229, CAST(N'2011-12-05T15:33:55.0000000' AS DateTime2), CAST(N'2011-12-05T15:33:59.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (230, CAST(N'2011-12-05T15:42:25.0000000' AS DateTime2), CAST(N'2011-12-05T15:44:05.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (231, CAST(N'2011-12-05T15:44:16.0000000' AS DateTime2), CAST(N'2011-12-05T15:45:09.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (232, CAST(N'2011-12-05T15:44:56.0000000' AS DateTime2), CAST(N'2011-12-05T16:02:10.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (233, CAST(N'2011-12-05T16:36:32.0000000' AS DateTime2), CAST(N'2011-12-05T16:37:00.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (234, CAST(N'2011-12-05T16:37:15.0000000' AS DateTime2), CAST(N'2011-12-05T17:14:32.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (235, CAST(N'2011-12-05T17:17:07.0000000' AS DateTime2), CAST(N'2011-12-05T17:17:13.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (236, CAST(N'2011-12-05T18:57:11.0000000' AS DateTime2), CAST(N'2011-12-05T18:57:16.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (237, CAST(N'2011-12-05T19:01:42.0000000' AS DateTime2), CAST(N'2011-12-05T19:24:02.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (238, CAST(N'2011-12-05T19:24:11.0000000' AS DateTime2), CAST(N'2011-12-05T19:24:16.0000000' AS DateTime2), 6, 9, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (239, CAST(N'2011-12-05T19:24:22.0000000' AS DateTime2), CAST(N'2011-12-05T20:07:19.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (240, CAST(N'2011-12-05T20:07:32.0000000' AS DateTime2), CAST(N'2011-12-05T20:07:47.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (241, CAST(N'2011-12-05T20:08:52.0000000' AS DateTime2), CAST(N'2011-12-05T20:09:19.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (242, CAST(N'2011-12-05T20:20:20.0000000' AS DateTime2), CAST(N'2011-12-05T21:06:25.0000000' AS DateTime2), 11, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (243, CAST(N'2011-12-05T21:06:35.0000000' AS DateTime2), CAST(N'2011-12-05T21:06:41.0000000' AS DateTime2), 3, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (244, CAST(N'2011-12-05T21:06:43.0000000' AS DateTime2), CAST(N'2011-12-05T21:07:08.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (245, CAST(N'2011-12-05T21:06:44.0000000' AS DateTime2), CAST(N'2011-12-05T21:07:00.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (246, CAST(N'2011-12-05T21:07:14.0000000' AS DateTime2), CAST(N'2011-12-06T00:38:24.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (247, CAST(N'2011-12-06T00:39:56.0000000' AS DateTime2), CAST(N'2011-12-06T00:40:23.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (248, CAST(N'2011-12-06T00:40:35.0000000' AS DateTime2), CAST(N'2011-12-06T00:40:41.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (249, CAST(N'2011-12-06T00:42:37.0000000' AS DateTime2), CAST(N'2011-12-06T10:07:20.0000000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (250, CAST(N'2011-12-06T11:08:53.0000000' AS DateTime2), CAST(N'2011-12-06T11:09:26.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (251, CAST(N'2011-12-06T11:09:49.0000000' AS DateTime2), CAST(N'2011-12-06T11:09:52.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (252, CAST(N'2011-12-06T11:10:06.0000000' AS DateTime2), CAST(N'2011-12-06T11:10:09.0000000' AS DateTime2), 2, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (253, CAST(N'2011-12-06T11:10:08.0000000' AS DateTime2), CAST(N'2011-12-06T11:11:45.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (254, CAST(N'2011-12-06T11:12:19.0000000' AS DateTime2), CAST(N'2011-12-06T11:25:57.0000000' AS DateTime2), 5, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (255, CAST(N'2011-12-06T11:30:19.0000000' AS DateTime2), CAST(N'2011-12-06T11:33:26.0000000' AS DateTime2), 8, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (256, CAST(N'2011-12-06T11:30:22.0000000' AS DateTime2), CAST(N'2011-12-06T11:30:46.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (257, CAST(N'2011-12-06T11:30:52.0000000' AS DateTime2), CAST(N'2011-12-06T11:31:23.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (258, CAST(N'2011-12-06T11:31:34.0000000' AS DateTime2), CAST(N'2011-12-06T11:32:49.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (259, CAST(N'2011-12-06T11:39:34.0000000' AS DateTime2), CAST(N'2011-12-06T14:37:50.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (260, CAST(N'2011-12-06T14:40:53.0000000' AS DateTime2), CAST(N'2011-12-06T14:41:14.0000000' AS DateTime2), 7, 8, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (261, CAST(N'2011-12-06T14:41:16.0000000' AS DateTime2), CAST(N'2011-12-06T15:00:58.0000000' AS DateTime2), 9, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (262, CAST(N'2011-12-06T14:41:22.0000000' AS DateTime2), CAST(N'2011-12-06T14:51:11.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (263, CAST(N'2011-12-06T14:48:47.0000000' AS DateTime2), CAST(N'2011-12-06T14:48:52.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (264, CAST(N'2011-12-06T14:52:17.0000000' AS DateTime2), CAST(N'2011-12-06T14:52:22.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (265, CAST(N'2011-12-06T14:56:50.0000000' AS DateTime2), CAST(N'2011-12-06T14:56:54.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (266, CAST(N'2011-12-06T15:17:49.0000000' AS DateTime2), CAST(N'2011-12-06T15:18:18.0000000' AS DateTime2), 11, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (267, CAST(N'2011-12-06T15:18:35.0000000' AS DateTime2), CAST(N'2011-12-06T15:20:32.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (268, CAST(N'2011-12-06T15:21:46.0000000' AS DateTime2), CAST(N'2011-12-06T17:11:04.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (269, CAST(N'2011-12-06T17:18:22.0000000' AS DateTime2), CAST(N'2011-12-06T17:18:49.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (270, CAST(N'2011-12-06T17:19:04.0000000' AS DateTime2), CAST(N'2011-12-06T17:19:14.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (271, CAST(N'2011-12-06T17:19:34.0000000' AS DateTime2), CAST(N'2011-12-06T18:06:26.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (272, CAST(N'2011-12-06T18:07:03.0000000' AS DateTime2), CAST(N'2011-12-06T18:07:15.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (273, CAST(N'2011-12-06T18:07:36.0000000' AS DateTime2), CAST(N'2011-12-06T19:22:33.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (274, CAST(N'2011-12-06T19:22:50.0000000' AS DateTime2), CAST(N'2011-12-06T19:22:55.0000000' AS DateTime2), 6, 9, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (275, CAST(N'2011-12-06T19:25:56.0000000' AS DateTime2), CAST(N'2011-12-06T19:26:20.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (276, CAST(N'2011-12-06T19:40:28.0000000' AS DateTime2), CAST(N'2011-12-07T00:07:38.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (277, CAST(N'2011-12-07T00:07:47.0000000' AS DateTime2), CAST(N'2011-12-07T00:07:57.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (278, CAST(N'2011-12-07T00:08:10.0000000' AS DateTime2), CAST(N'2011-12-07T00:54:50.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (279, CAST(N'2011-12-07T00:57:29.0000000' AS DateTime2), CAST(N'2011-12-07T00:57:53.0000000' AS DateTime2), 4, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (280, CAST(N'2011-12-07T00:59:56.0000000' AS DateTime2), CAST(N'2011-12-07T10:45:40.0000000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (281, CAST(N'2011-12-07T10:49:26.0000000' AS DateTime2), CAST(N'2011-12-07T10:49:54.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (282, CAST(N'2011-12-07T10:50:38.0000000' AS DateTime2), CAST(N'2011-12-07T10:50:43.0000000' AS DateTime2), 2, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (283, CAST(N'2011-12-07T10:50:45.0000000' AS DateTime2), CAST(N'2011-12-07T11:04:14.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (284, CAST(N'2011-12-07T11:04:19.0000000' AS DateTime2), CAST(N'2011-12-07T11:04:25.0000000' AS DateTime2), 2, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (285, CAST(N'2011-12-07T11:05:51.0000000' AS DateTime2), CAST(N'2011-12-07T11:11:32.0000000' AS DateTime2), 5, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (286, CAST(N'2011-12-07T11:12:17.0000000' AS DateTime2), CAST(N'2011-12-07T11:15:06.0000000' AS DateTime2), 8, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (287, CAST(N'2011-12-07T11:12:35.0000000' AS DateTime2), CAST(N'2011-12-07T11:12:52.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (288, CAST(N'2011-12-07T11:12:59.0000000' AS DateTime2), CAST(N'2011-12-07T11:13:13.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (289, CAST(N'2011-12-07T11:13:20.0000000' AS DateTime2), CAST(N'2011-12-07T11:17:14.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (290, CAST(N'2011-12-07T11:22:58.0000000' AS DateTime2), CAST(N'2011-12-07T13:56:10.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (291, CAST(N'2011-12-07T14:03:34.0000000' AS DateTime2), CAST(N'2011-12-07T14:03:42.0000000' AS DateTime2), 7, 8, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (292, CAST(N'2011-12-07T14:04:32.0000000' AS DateTime2), CAST(N'2011-12-07T14:22:12.0000000' AS DateTime2), 9, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (293, CAST(N'2011-12-07T14:04:39.0000000' AS DateTime2), CAST(N'2011-12-07T14:13:34.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (294, CAST(N'2011-12-07T14:13:16.0000000' AS DateTime2), CAST(N'2011-12-07T14:13:22.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (295, CAST(N'2011-12-07T14:14:59.0000000' AS DateTime2), CAST(N'2011-12-07T14:15:04.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (296, CAST(N'2011-12-07T14:27:30.0000000' AS DateTime2), CAST(N'2011-12-07T14:27:34.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (297, CAST(N'2011-12-07T14:27:39.0000000' AS DateTime2), CAST(N'2011-12-07T14:27:44.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (298, CAST(N'2011-12-07T14:41:59.0000000' AS DateTime2), CAST(N'2011-12-07T15:28:03.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (299, CAST(N'2011-12-07T15:31:23.0000000' AS DateTime2), CAST(N'2011-12-07T15:31:41.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (300, CAST(N'2011-12-07T15:31:46.0000000' AS DateTime2), CAST(N'2011-12-07T15:32:18.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (301, CAST(N'2011-12-07T15:32:15.0000000' AS DateTime2), CAST(N'2011-12-07T16:11:28.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (302, CAST(N'2011-12-07T16:15:26.0000000' AS DateTime2), CAST(N'2011-12-07T16:21:09.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (303, CAST(N'2011-12-07T16:25:45.0000000' AS DateTime2), CAST(N'2011-12-07T16:25:52.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (304, CAST(N'2011-12-07T18:12:30.0000000' AS DateTime2), CAST(N'2011-12-07T18:12:36.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (305, CAST(N'2011-12-07T18:14:56.0000000' AS DateTime2), CAST(N'2011-12-07T18:14:59.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (306, CAST(N'2011-12-07T18:15:03.0000000' AS DateTime2), CAST(N'2011-12-07T18:15:29.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (307, CAST(N'2011-12-07T18:15:51.0000000' AS DateTime2), CAST(N'2011-12-07T19:21:46.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (308, CAST(N'2011-12-07T19:23:32.0000000' AS DateTime2), CAST(N'2011-12-07T19:23:39.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (309, CAST(N'2011-12-07T19:23:55.0000000' AS DateTime2), CAST(N'2011-12-07T19:24:00.0000000' AS DateTime2), 6, 9, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (310, CAST(N'2011-12-07T19:24:02.0000000' AS DateTime2), CAST(N'2011-12-07T19:24:05.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (311, CAST(N'2011-12-07T19:28:41.0000000' AS DateTime2), CAST(N'2011-12-07T19:28:46.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (312, CAST(N'2011-12-07T20:37:50.0000000' AS DateTime2), CAST(N'2011-12-07T20:37:51.0000000' AS DateTime2), 7, 9, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (313, CAST(N'2011-12-07T20:38:13.0000000' AS DateTime2), CAST(N'2011-12-07T20:38:18.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (314, CAST(N'2011-12-07T20:39:16.0000000' AS DateTime2), CAST(N'2011-12-07T20:39:44.0000000' AS DateTime2), 4, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (315, CAST(N'2011-12-07T20:40:29.0000000' AS DateTime2), CAST(N'2011-12-07T20:42:35.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (316, CAST(N'2011-12-07T20:47:11.0000000' AS DateTime2), CAST(N'2011-12-07T20:47:46.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (317, CAST(N'2011-12-07T20:52:23.0000000' AS DateTime2), CAST(N'2011-12-07T23:19:30.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (318, CAST(N'2011-12-07T23:19:40.0000000' AS DateTime2), CAST(N'2011-12-07T23:19:56.0000000' AS DateTime2), 3, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (319, CAST(N'2011-12-07T23:20:16.0000000' AS DateTime2), CAST(N'2011-12-08T01:32:32.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (320, CAST(N'2011-12-08T01:39:41.0000000' AS DateTime2), CAST(N'2011-12-08T11:14:29.0000000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (321, CAST(N'2011-12-08T11:17:37.0000000' AS DateTime2), CAST(N'2011-12-08T11:17:48.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (322, CAST(N'2011-12-08T11:17:58.0000000' AS DateTime2), CAST(N'2011-12-08T11:18:30.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (323, CAST(N'2011-12-08T11:18:02.0000000' AS DateTime2), CAST(N'2011-12-08T11:18:05.0000000' AS DateTime2), 2, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (324, CAST(N'2011-12-08T11:18:10.0000000' AS DateTime2), CAST(N'2011-12-08T11:18:13.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (325, CAST(N'2011-12-08T11:19:22.0000000' AS DateTime2), CAST(N'2011-12-08T11:24:17.0000000' AS DateTime2), 5, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (326, CAST(N'2011-12-08T11:25:12.0000000' AS DateTime2), CAST(N'2011-12-08T11:28:25.0000000' AS DateTime2), 8, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (327, CAST(N'2011-12-08T11:25:18.0000000' AS DateTime2), CAST(N'2011-12-08T11:25:39.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (328, CAST(N'2011-12-08T11:26:05.0000000' AS DateTime2), CAST(N'2011-12-08T11:26:26.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (329, CAST(N'2011-12-08T11:26:31.0000000' AS DateTime2), CAST(N'2011-12-08T11:28:28.0000000' AS DateTime2), 9, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (330, CAST(N'2011-12-08T11:26:35.0000000' AS DateTime2), CAST(N'2011-12-08T11:28:24.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (331, CAST(N'2011-12-08T11:36:09.0000000' AS DateTime2), CAST(N'2011-12-08T13:41:19.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (332, CAST(N'2011-12-08T14:04:49.0000000' AS DateTime2), CAST(N'2011-12-08T14:05:01.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (333, CAST(N'2011-12-08T14:10:03.0000000' AS DateTime2), CAST(N'2011-12-08T14:10:07.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (334, CAST(N'2011-12-08T16:21:37.0000000' AS DateTime2), CAST(N'2011-12-08T16:21:41.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (335, CAST(N'2011-12-08T16:24:27.0000000' AS DateTime2), CAST(N'2011-12-08T22:13:23.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (336, CAST(N'2011-12-08T22:13:35.0000000' AS DateTime2), CAST(N'2011-12-08T22:13:49.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (337, CAST(N'2011-12-08T22:14:14.0000000' AS DateTime2), CAST(N'2011-12-08T23:12:37.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (338, CAST(N'2011-12-08T23:14:09.0000000' AS DateTime2), CAST(N'2011-12-08T23:14:27.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (339, CAST(N'2011-12-08T23:14:35.0000000' AS DateTime2), CAST(N'2011-12-09T01:03:07.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (340, CAST(N'2011-12-09T01:04:24.0000000' AS DateTime2), CAST(N'2011-12-09T01:05:43.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (341, CAST(N'2011-12-09T01:16:42.0000000' AS DateTime2), CAST(N'2011-12-09T10:49:07.0000000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (342, CAST(N'2011-12-09T10:51:56.0000000' AS DateTime2), CAST(N'2011-12-09T10:52:27.0000000' AS DateTime2), 4, 2, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (343, CAST(N'2011-12-09T10:52:30.0000000' AS DateTime2), CAST(N'2011-12-09T10:52:36.0000000' AS DateTime2), 2, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (344, CAST(N'2011-12-09T10:52:40.0000000' AS DateTime2), CAST(N'2011-12-09T10:52:50.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (345, CAST(N'2011-12-09T10:54:58.0000000' AS DateTime2), CAST(N'2011-12-09T10:58:21.0000000' AS DateTime2), 5, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (346, CAST(N'2011-12-09T11:00:13.0000000' AS DateTime2), CAST(N'2011-12-09T11:02:48.0000000' AS DateTime2), 8, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (347, CAST(N'2011-12-09T11:00:38.0000000' AS DateTime2), CAST(N'2011-12-09T11:00:42.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (348, CAST(N'2011-12-09T11:00:58.0000000' AS DateTime2), CAST(N'2011-12-09T11:01:21.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (349, CAST(N'2011-12-09T11:01:26.0000000' AS DateTime2), CAST(N'2011-12-09T11:01:29.0000000' AS DateTime2), 9, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (350, CAST(N'2011-12-09T11:01:31.0000000' AS DateTime2), CAST(N'2011-12-09T11:03:09.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (351, CAST(N'2011-12-09T11:09:35.0000000' AS DateTime2), CAST(N'2011-12-09T12:32:57.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (352, CAST(N'2011-12-09T12:33:21.0000000' AS DateTime2), CAST(N'2011-12-09T12:42:15.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (353, CAST(N'2011-12-09T12:44:16.0000000' AS DateTime2), CAST(N'2011-12-09T12:44:20.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (354, CAST(N'2011-12-09T16:33:52.0000000' AS DateTime2), CAST(N'2011-12-09T16:33:56.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (355, CAST(N'2011-12-09T16:45:53.0000000' AS DateTime2), CAST(N'2011-12-09T16:59:52.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (356, CAST(N'2011-12-09T17:04:57.0000000' AS DateTime2), CAST(N'2011-12-09T17:05:23.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (357, CAST(N'2011-12-09T17:06:38.0000000' AS DateTime2), CAST(N'2011-12-09T17:59:19.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (358, CAST(N'2011-12-09T17:59:25.0000000' AS DateTime2), CAST(N'2011-12-09T17:59:27.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (359, CAST(N'2011-12-09T18:02:18.0000000' AS DateTime2), CAST(N'2011-12-09T18:19:35.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (360, CAST(N'2011-12-09T18:32:02.0000000' AS DateTime2), CAST(N'2011-12-09T18:32:07.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (361, CAST(N'2011-12-09T18:48:30.0000000' AS DateTime2), CAST(N'2011-12-09T18:48:36.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (362, CAST(N'2011-12-09T18:50:33.0000000' AS DateTime2), CAST(N'2011-12-09T18:50:45.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (363, CAST(N'2011-12-09T19:19:54.0000000' AS DateTime2), CAST(N'2011-12-09T21:04:31.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (364, CAST(N'2011-12-09T21:04:37.0000000' AS DateTime2), CAST(N'2011-12-09T21:04:50.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (365, CAST(N'2011-12-09T21:04:59.0000000' AS DateTime2), CAST(N'2011-12-10T00:16:21.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (366, CAST(N'2011-12-10T00:16:31.0000000' AS DateTime2), CAST(N'2011-12-10T00:16:49.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (367, CAST(N'2011-12-10T00:17:05.0000000' AS DateTime2), CAST(N'2011-12-10T00:46:13.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (368, CAST(N'2011-12-10T00:50:47.0000000' AS DateTime2), CAST(N'2011-12-10T09:26:17.0000000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (369, CAST(N'2011-12-10T09:35:48.0000000' AS DateTime2), CAST(N'2011-12-10T09:36:18.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (370, CAST(N'2011-12-10T09:37:16.0000000' AS DateTime2), CAST(N'2011-12-10T09:37:21.0000000' AS DateTime2), 2, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (371, CAST(N'2011-12-10T09:37:26.0000000' AS DateTime2), CAST(N'2011-12-10T09:45:53.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (372, CAST(N'2011-12-10T09:46:00.0000000' AS DateTime2), CAST(N'2011-12-10T09:46:05.0000000' AS DateTime2), 2, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (373, CAST(N'2011-12-10T09:46:23.0000000' AS DateTime2), CAST(N'2011-12-10T09:46:27.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (374, CAST(N'2011-12-10T09:47:44.0000000' AS DateTime2), CAST(N'2011-12-10T09:52:42.0000000' AS DateTime2), 5, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (375, CAST(N'2011-12-10T09:55:18.0000000' AS DateTime2), CAST(N'2011-12-10T09:55:26.0000000' AS DateTime2), 7, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (376, CAST(N'2011-12-10T09:55:50.0000000' AS DateTime2), CAST(N'2011-12-10T09:59:03.0000000' AS DateTime2), 8, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (377, CAST(N'2011-12-10T09:56:27.0000000' AS DateTime2), CAST(N'2011-12-10T09:56:29.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (378, CAST(N'2011-12-10T09:56:33.0000000' AS DateTime2), CAST(N'2011-12-10T09:56:50.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (379, CAST(N'2011-12-10T09:56:58.0000000' AS DateTime2), CAST(N'2011-12-10T09:58:18.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (380, CAST(N'2011-12-10T09:58:21.0000000' AS DateTime2), CAST(N'2011-12-10T09:58:24.0000000' AS DateTime2), 9, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (381, CAST(N'2011-12-10T10:03:20.0000000' AS DateTime2), CAST(N'2011-12-10T12:34:09.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (382, CAST(N'2011-12-10T12:52:54.0000000' AS DateTime2), CAST(N'2011-12-10T12:53:39.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (383, CAST(N'2011-12-10T13:04:03.0000000' AS DateTime2), CAST(N'2011-12-10T13:04:08.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (384, CAST(N'2011-12-10T17:06:58.0000000' AS DateTime2), CAST(N'2011-12-10T17:07:03.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (385, CAST(N'2011-12-10T17:11:23.0000000' AS DateTime2), CAST(N'2011-12-10T20:16:51.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (386, CAST(N'2011-12-10T20:21:54.0000000' AS DateTime2), CAST(N'2011-12-10T20:23:16.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (387, CAST(N'2011-12-10T20:25:40.0000000' AS DateTime2), CAST(N'2011-12-10T20:25:46.0000000' AS DateTime2), 12, 7, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (388, CAST(N'2011-12-11T00:56:01.0000000' AS DateTime2), CAST(N'2011-12-11T00:56:05.0000000' AS DateTime2), 12, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (389, CAST(N'2011-12-11T01:01:41.0000000' AS DateTime2), CAST(N'2011-12-11T02:26:08.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (390, CAST(N'2011-12-11T02:27:21.0000000' AS DateTime2), CAST(N'2011-12-11T02:28:44.0000000' AS DateTime2), 3, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (391, CAST(N'2011-12-11T02:31:15.0000000' AS DateTime2), CAST(N'2011-12-11T11:57:34.0000000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (392, CAST(N'2011-12-11T12:01:27.0000000' AS DateTime2), CAST(N'2011-12-11T12:01:59.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (393, CAST(N'2011-12-11T12:02:25.0000000' AS DateTime2), CAST(N'2011-12-11T12:02:39.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (394, CAST(N'2011-12-11T12:02:56.0000000' AS DateTime2), CAST(N'2011-12-11T12:18:42.0000000' AS DateTime2), 5, 3, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (395, CAST(N'2011-12-11T12:21:57.0000000' AS DateTime2), CAST(N'2011-12-11T12:25:09.0000000' AS DateTime2), 8, 4, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (396, CAST(N'2011-12-11T12:22:01.0000000' AS DateTime2), CAST(N'2011-12-11T12:22:03.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (397, CAST(N'2011-12-11T12:22:07.0000000' AS DateTime2), CAST(N'2011-12-11T12:23:04.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (398, CAST(N'2011-12-11T12:23:14.0000000' AS DateTime2), CAST(N'2011-12-11T12:25:12.0000000' AS DateTime2), 10, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (399, CAST(N'2011-12-11T12:32:49.0000000' AS DateTime2), CAST(N'2011-12-11T14:26:18.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (400, CAST(N'2011-12-11T14:34:12.0000000' AS DateTime2), CAST(N'2011-12-11T14:34:59.0000000' AS DateTime2), 7, 8, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (401, CAST(N'2011-12-11T14:36:58.0000000' AS DateTime2), CAST(N'2011-12-11T15:00:37.0000000' AS DateTime2), 9, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (402, CAST(N'2011-12-11T14:37:04.0000000' AS DateTime2), CAST(N'2011-12-11T14:37:14.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (403, CAST(N'2011-12-11T14:43:05.0000000' AS DateTime2), CAST(N'2011-12-11T14:44:23.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (404, CAST(N'2011-12-11T14:49:47.0000000' AS DateTime2), CAST(N'2011-12-11T14:50:02.0000000' AS DateTime2), 7, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (405, CAST(N'2011-12-11T15:13:52.0000000' AS DateTime2), CAST(N'2011-12-11T15:13:57.0000000' AS DateTime2), 6, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (406, CAST(N'2011-12-11T15:29:03.0000000' AS DateTime2), CAST(N'2011-12-11T15:30:14.0000000' AS DateTime2), 4, NULL, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (407, CAST(N'2011-12-11T15:41:34.0000000' AS DateTime2), CAST(N'2011-12-11T15:43:30.0000000' AS DateTime2), 3, 5, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (408, CAST(N'2011-12-11T15:43:51.0000000' AS DateTime2), CAST(N'2011-12-12T00:22:50.0000000' AS DateTime2), 11, 6, 1)
GO
INSERT [dbo].[ActivityData] ([ActivityDataId], [StartTime], [EndTime], [SensorLocationId], [ActivityId], [DatasetIndex]) VALUES (409, CAST(N'2011-12-12T00:31:35.0000000' AS DateTime2), CAST(N'2011-12-12T07:22:21.0000000' AS DateTime2), 1, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[ActivityData] OFF
GO
SET IDENTITY_INSERT [dbo].[ActivityPosition] ON 
GO
INSERT [dbo].[ActivityPosition] ([ActivityPositionId], [Position], [XPos], [YPos], [ActivityId], [ConfigId]) VALUES (29, N'Bed', 788, 544, 1, 1)
GO
INSERT [dbo].[ActivityPosition] ([ActivityPositionId], [Position], [XPos], [YPos], [ActivityId], [ConfigId]) VALUES (30, N'Toilet', 990, 192, 2, 1)
GO
INSERT [dbo].[ActivityPosition] ([ActivityPositionId], [Position], [XPos], [YPos], [ActivityId], [ConfigId]) VALUES (31, N'ShowerArea', 947, 595, 3, 1)
GO
INSERT [dbo].[ActivityPosition] ([ActivityPositionId], [Position], [XPos], [YPos], [ActivityId], [ConfigId]) VALUES (32, N'DiningTable', 243, 168, 4, 1)
GO
INSERT [dbo].[ActivityPosition] ([ActivityPositionId], [Position], [XPos], [YPos], [ActivityId], [ConfigId]) VALUES (33, N'Basin', 874, 404, 5, 1)
GO
INSERT [dbo].[ActivityPosition] ([ActivityPositionId], [Position], [XPos], [YPos], [ActivityId], [ConfigId]) VALUES (34, N'Sofa', 498, 89, 6, 1)
GO
INSERT [dbo].[ActivityPosition] ([ActivityPositionId], [Position], [XPos], [YPos], [ActivityId], [ConfigId]) VALUES (35, N'Entrance', 488, 636, 7, 1)
GO
INSERT [dbo].[ActivityPosition] ([ActivityPositionId], [Position], [XPos], [YPos], [ActivityId], [ConfigId]) VALUES (36, N'DiningTable', 243, 168, 8, 1)
GO
INSERT [dbo].[ActivityPosition] ([ActivityPositionId], [Position], [XPos], [YPos], [ActivityId], [ConfigId]) VALUES (37, N'DiningTable', 243, 168, 9, 1)
GO
SET IDENTITY_INSERT [dbo].[ActivityPosition] OFF
GO
INSERT [dbo].[Config] ([ConfigId]) VALUES (1)
GO
INSERT [dbo].[DataSet] ([DataSetIndex], [StartTime], [EndTime]) VALUES (1, CAST(N'2011-11-28T02:27:59.0000000' AS DateTime2), CAST(N'2011-12-12T07:22:21.0000000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[DoorsPosition] ON 
GO
INSERT [dbo].[DoorsPosition] ([DoorsPositionId], [VerticalPosition], [ConfigId]) VALUES (2, 330, 1)
GO
SET IDENTITY_INSERT [dbo].[DoorsPosition] OFF
GO
SET IDENTITY_INSERT [dbo].[Room] ON 
GO
INSERT [dbo].[Room] ([RoomId], [Room]) VALUES (1, N'Bedroom')
GO
INSERT [dbo].[Room] ([RoomId], [Room]) VALUES (2, N'Bathroom')
GO
INSERT [dbo].[Room] ([RoomId], [Room]) VALUES (3, N'Kitchen')
GO
INSERT [dbo].[Room] ([RoomId], [Room]) VALUES (4, N'LivingRoom')
GO
INSERT [dbo].[Room] ([RoomId], [Room]) VALUES (5, N'Entrance')
GO
SET IDENTITY_INSERT [dbo].[Room] OFF
GO
INSERT [dbo].[Room_Activity_Mapping] ([RoomId], [ActivityId]) VALUES (1, 1)
GO
INSERT [dbo].[Room_Activity_Mapping] ([RoomId], [ActivityId]) VALUES (2, 2)
GO
INSERT [dbo].[Room_Activity_Mapping] ([RoomId], [ActivityId]) VALUES (2, 3)
GO
INSERT [dbo].[Room_Activity_Mapping] ([RoomId], [ActivityId]) VALUES (2, 5)
GO
INSERT [dbo].[Room_Activity_Mapping] ([RoomId], [ActivityId]) VALUES (3, 4)
GO
INSERT [dbo].[Room_Activity_Mapping] ([RoomId], [ActivityId]) VALUES (3, 8)
GO
INSERT [dbo].[Room_Activity_Mapping] ([RoomId], [ActivityId]) VALUES (3, 9)
GO
INSERT [dbo].[Room_Activity_Mapping] ([RoomId], [ActivityId]) VALUES (4, 6)
GO
INSERT [dbo].[Room_Activity_Mapping] ([RoomId], [ActivityId]) VALUES (5, 7)
GO
SET IDENTITY_INSERT [dbo].[SensorLocation] ON 
GO
INSERT [dbo].[SensorLocation] ([SensorLocationId], [Location], [SensorTypeId], [RoomId]) VALUES (1, N'Bed', NULL, 1)
GO
INSERT [dbo].[SensorLocation] ([SensorLocationId], [Location], [SensorTypeId], [RoomId]) VALUES (2, N'Cabinet', NULL, 2)
GO
INSERT [dbo].[SensorLocation] ([SensorLocationId], [Location], [SensorTypeId], [RoomId]) VALUES (3, N'Basin', NULL, 2)
GO
INSERT [dbo].[SensorLocation] ([SensorLocationId], [Location], [SensorTypeId], [RoomId]) VALUES (4, N'Toilet', NULL, 2)
GO
INSERT [dbo].[SensorLocation] ([SensorLocationId], [Location], [SensorTypeId], [RoomId]) VALUES (5, N'Shower', NULL, 2)
GO
INSERT [dbo].[SensorLocation] ([SensorLocationId], [Location], [SensorTypeId], [RoomId]) VALUES (6, N'Fridge', NULL, 3)
GO
INSERT [dbo].[SensorLocation] ([SensorLocationId], [Location], [SensorTypeId], [RoomId]) VALUES (7, N'Cupboard', NULL, 3)
GO
INSERT [dbo].[SensorLocation] ([SensorLocationId], [Location], [SensorTypeId], [RoomId]) VALUES (8, N'Toaster', NULL, 3)
GO
INSERT [dbo].[SensorLocation] ([SensorLocationId], [Location], [SensorTypeId], [RoomId]) VALUES (9, N'Cooktop', NULL, 3)
GO
INSERT [dbo].[SensorLocation] ([SensorLocationId], [Location], [SensorTypeId], [RoomId]) VALUES (10, N'Microwave', NULL, 3)
GO
INSERT [dbo].[SensorLocation] ([SensorLocationId], [Location], [SensorTypeId], [RoomId]) VALUES (11, N'Seat', NULL, 4)
GO
INSERT [dbo].[SensorLocation] ([SensorLocationId], [Location], [SensorTypeId], [RoomId]) VALUES (12, N'MainDoor', NULL, 5)
GO
SET IDENTITY_INSERT [dbo].[SensorLocation] OFF
GO
SET IDENTITY_INSERT [dbo].[SensorType] ON 
GO
INSERT [dbo].[SensorType] ([SensorTypeId], [SensorType]) VALUES (1, N'Pressure')
GO
INSERT [dbo].[SensorType] ([SensorTypeId], [SensorType]) VALUES (2, N'Magnetic')
GO
INSERT [dbo].[SensorType] ([SensorTypeId], [SensorType]) VALUES (3, N'PIR')
GO
INSERT [dbo].[SensorType] ([SensorTypeId], [SensorType]) VALUES (4, N'Flush')
GO
INSERT [dbo].[SensorType] ([SensorTypeId], [SensorType]) VALUES (5, N'Electric')
GO
SET IDENTITY_INSERT [dbo].[SensorType] OFF
GO
ALTER TABLE [dbo].[ActivityData]  WITH CHECK ADD  CONSTRAINT [FK_ActivityData_Activity] FOREIGN KEY([ActivityId])
REFERENCES [dbo].[Activity] ([ActivityId])
GO
ALTER TABLE [dbo].[ActivityData] CHECK CONSTRAINT [FK_ActivityData_Activity]
GO
ALTER TABLE [dbo].[ActivityData]  WITH CHECK ADD  CONSTRAINT [FK_ActivityData_DataSet] FOREIGN KEY([DatasetIndex])
REFERENCES [dbo].[DataSet] ([DataSetIndex])
GO
ALTER TABLE [dbo].[ActivityData] CHECK CONSTRAINT [FK_ActivityData_DataSet]
GO
ALTER TABLE [dbo].[ActivityData]  WITH CHECK ADD  CONSTRAINT [FK_ActivityData_SensorLocation] FOREIGN KEY([SensorLocationId])
REFERENCES [dbo].[SensorLocation] ([SensorLocationId])
GO
ALTER TABLE [dbo].[ActivityData] CHECK CONSTRAINT [FK_ActivityData_SensorLocation]
GO
ALTER TABLE [dbo].[ActivityPosition]  WITH CHECK ADD  CONSTRAINT [FK_ActivityPosition_Activity] FOREIGN KEY([ActivityId])
REFERENCES [dbo].[Activity] ([ActivityId])
GO
ALTER TABLE [dbo].[ActivityPosition] CHECK CONSTRAINT [FK_ActivityPosition_Activity]
GO
ALTER TABLE [dbo].[ActivityPosition]  WITH CHECK ADD  CONSTRAINT [FK_ActivityPosition_Config] FOREIGN KEY([ConfigId])
REFERENCES [dbo].[Config] ([ConfigId])
GO
ALTER TABLE [dbo].[ActivityPosition] CHECK CONSTRAINT [FK_ActivityPosition_Config]
GO
ALTER TABLE [dbo].[DoorsPosition]  WITH CHECK ADD  CONSTRAINT [FK_DoorsPosition_Config] FOREIGN KEY([ConfigId])
REFERENCES [dbo].[Config] ([ConfigId])
GO
ALTER TABLE [dbo].[DoorsPosition] CHECK CONSTRAINT [FK_DoorsPosition_Config]
GO
ALTER TABLE [dbo].[Room_Activity_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Room_Activity_Mapping_Activity] FOREIGN KEY([ActivityId])
REFERENCES [dbo].[Activity] ([ActivityId])
GO
ALTER TABLE [dbo].[Room_Activity_Mapping] CHECK CONSTRAINT [FK_Room_Activity_Mapping_Activity]
GO
ALTER TABLE [dbo].[Room_Activity_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Room_Activity_Mapping_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO
ALTER TABLE [dbo].[Room_Activity_Mapping] CHECK CONSTRAINT [FK_Room_Activity_Mapping_Room]
GO
ALTER TABLE [dbo].[SensorLocation]  WITH CHECK ADD  CONSTRAINT [FK_Location_Sensor] FOREIGN KEY([SensorTypeId])
REFERENCES [dbo].[SensorType] ([SensorTypeId])
GO
ALTER TABLE [dbo].[SensorLocation] CHECK CONSTRAINT [FK_Location_Sensor]
GO
ALTER TABLE [dbo].[SensorLocation]  WITH CHECK ADD  CONSTRAINT [FK_Sensor Location_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO
ALTER TABLE [dbo].[SensorLocation] CHECK CONSTRAINT [FK_Sensor Location_Room]
GO
USE [master]
GO
ALTER DATABASE [ActivityDB] SET  READ_WRITE 
GO
