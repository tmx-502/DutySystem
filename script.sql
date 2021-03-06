CREATE DATABASE [db_zbxt]
GO
USE [db_zbxt]
GO
/****** Object:  Table [dbo].[Duty]    Script Date: 2021/1/5 8:43:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Duty](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UNumber] [char](6) NULL,
	[UName] [nvarchar](50) NULL,
	[DutyTime] [date] NULL,
	[IsWeekend] [nvarchar](50) NULL,
	[UGroup] [nchar](10) NULL,
	[IsEat] [nchar](10) NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TUsers]    Script Date: 2021/1/5 8:43:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TUsers](
	[UNumber] [char](6) NULL,
	[UName] [nvarchar](10) NULL,
	[UPwd] [varchar](20) NULL,
	[USex] [nchar](1) NULL,
	[UPhone] [char](11) NULL,
	[URole] [nvarchar](10) NULL,
	[UAddTime] [datetime] NULL,
	[UGroup] [nvarchar](10) NULL,
	[UAmount] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TUsers] ADD  CONSTRAINT [DF_TUsers_UAmount]  DEFAULT ((0)) FOR [UAmount]
GO
insert into [dbo].[TUsers]([UNumber],[UName],[UPwd],[USex],[UPhone],[URole],[UAddTime],[UGroup],[UAmount]) values(1234,'法外狂徒张三','4321','女','13812345678','管理员','2021-01-01 08:00:00','车检一组',1);
insert into [dbo].[Duty]([UNumber],[UName],[DutyTime],[IsWeekend],[UGroup],[IsEat]) values(1234,'法外狂徒张三','2020-01-01','元旦','软件一组','是');