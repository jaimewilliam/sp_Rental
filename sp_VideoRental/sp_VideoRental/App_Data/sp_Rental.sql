USE [master]
GO
/****** Object:  Database [VideoRental]    Script Date: 3/10/2020 11:21:50 PM ******/
CREATE DATABASE [VideoRental]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VideoRental', FILENAME = N'C:\Users\Gerald Alzaga\VideoRental.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'VideoRental_log', FILENAME = N'C:\Users\Gerald Alzaga\VideoRental_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [VideoRental] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VideoRental].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VideoRental] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VideoRental] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VideoRental] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VideoRental] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VideoRental] SET ARITHABORT OFF 
GO
ALTER DATABASE [VideoRental] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VideoRental] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VideoRental] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VideoRental] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VideoRental] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VideoRental] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VideoRental] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VideoRental] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VideoRental] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VideoRental] SET  DISABLE_BROKER 
GO
ALTER DATABASE [VideoRental] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VideoRental] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VideoRental] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VideoRental] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VideoRental] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VideoRental] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VideoRental] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VideoRental] SET RECOVERY FULL 
GO
ALTER DATABASE [VideoRental] SET  MULTI_USER 
GO
ALTER DATABASE [VideoRental] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VideoRental] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VideoRental] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VideoRental] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [VideoRental] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [VideoRental] SET QUERY_STORE = OFF
GO
USE [VideoRental]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [VideoRental]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](100) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Genres]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[GenreID] [int] IDENTITY(1,1) NOT NULL,
	[GenreName] [nvarchar](100) NULL,
 CONSTRAINT [PK_Genres] PRIMARY KEY CLUSTERED 
(
	[GenreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Movies]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movies](
	[MovieID] [int] IDENTITY(1,1) NOT NULL,
	[MovieName] [nvarchar](100) NULL,
	[GenreFK] [int] NULL,
	[CustomerFK] [int] NULL,
 CONSTRAINT [PK_Movies] PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RentalHeader]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentalHeader](
	[RentalID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerFK] [int] NULL,
	[DateRented] [datetime] NULL,
	[MovieFK] [int] NULL,
	[DateReturned] [datetime] NULL,
 CONSTRAINT [PK_RentalHeader] PRIMARY KEY CLUSTERED 
(
	[RentalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RentedMovies]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentedMovies](
	[RentedID] [int] IDENTITY(1,1) NOT NULL,
	[MovieFK] [int] NULL,
	[DateReturned] [datetime] NULL,
	[RentalFK] [int] NULL,
 CONSTRAINT [PK_RentedMovies] PRIMARY KEY CLUSTERED 
(
	[RentedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  StoredProcedure [dbo].[DELETERentalHeader]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DELETERentalHeader]
	-- Add the parameters for the stored procedure here
	@RentalID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM RentalHeader
	WHERE RentalID = @RentalID
END

GO
/****** Object:  StoredProcedure [dbo].[DELETERentedMovies]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DELETERentedMovies] 
	-- Add the parameters for the stored procedure here
	@RentedID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		DELETE FROM RentedMovies
		WHERE RentedID = @RentedID
END
GO
/****** Object:  StoredProcedure [dbo].[DELETERentedMoviesbyRentalFK]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DELETERentedMoviesbyRentalFK]
	-- Add the parameters for the stored procedure here
	@RentalFK int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM RentedMovies
	WHERE RentalFK = @RentalFK
END

GO
/****** Object:  StoredProcedure [dbo].[DisplayRecords]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DisplayRecords] 
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		RentalHeader.RentalID,
		Customers.CustomerName,
		RentalHeader.DateRented
	  FROM RentalHeader
	  INNER JOIN Customers ON RentalHeader.CustomerFK = Customers.CustomerID
END

GO
/****** Object:  StoredProcedure [dbo].[INSERTRentalHeader]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[INSERTRentalHeader]
	-- Add the parameters for the stored procedure here
	@CustomerFK int = NULL,
	@DateRented datetime = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO RentalHeader(CustomerFK, DateRented)
	VALUES(@CustomerFK, @DateRented)
	RETURN SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[INSERTRentedMovies]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[INSERTRentedMovies] 
	-- Add the parameters for the stored procedure here
	@MovieFK int = null,
	@DateReturned datetime= null,
	@RentalFK int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO RentedMovies (MovieFK, DateReturned, RentalFK)
	VALUES (@MovieFK, @DateReturned, @RentalFK)
END

GO
/****** Object:  StoredProcedure [dbo].[SELECTCustomers]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SELECTCustomers]
	-- Add the parameters for the stored procedure here
	@CustomerFK int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@CustomerFK IS null)
	BEGIN
	SELECT *
	FROM Customers
	END

	ELSE

	BEGIN
	SELECT *
	FROM Customers
	WHERE CustomerID = @CustomerFK
	END

END
GO
/****** Object:  StoredProcedure [dbo].[SELECTGenres]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SELECTGenres]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Genres
END

GO
/****** Object:  StoredProcedure [dbo].[SELECTMovies]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SELECTMovies]
	-- Add the parameters for the stored procedure here
	@MovieId int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@MovieId IS	null)
	BEGIN
	SELECT * FROM Movies
	END

	ELSE

	BEGIN
	SELECT * FROM Movies
	WHERE MovieID = @MovieId
	END

END

GO
/****** Object:  StoredProcedure [dbo].[SELECTRentalHeader]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SELECTRentalHeader] 
	-- Add the parameters for the stored procedure here
	@id int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM RentalHeader
	WHERE RentalID = @id
END

GO
/****** Object:  StoredProcedure [dbo].[SELECTRented]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SELECTRented] 
	-- Add the parameters for the stored procedure here
	@id int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		Movies.MovieID,
		Movies.MovieName,
		Movies.GenreFK,
		Genres.GenreName,
		RentedMovies.RentedID,
		RentedMovies.DateReturned,
		RentedMovies.RentalFK
	  FROM Movies
	  INNER JOIN Genres ON Movies.GenreFK = Genres.GenreID
	  INNER JOIN RentedMovies ON Movies.MovieID = RentedMovies.MovieFK
	  WHERE RentedMovies.RentalFK = @id
END
GO
/****** Object:  StoredProcedure [dbo].[UPDATERentalHeader]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UPDATERentalHeader] 
	-- Add the parameters for the stored procedure here
	@RentalID int,
	@CustomerFK int,
	@DateRented datetime = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE RentalHeader
	SET CustomerFK = @CustomerFK, DateRented = @DateRented
	WHERE RentalID = @RentalID
END

GO
/****** Object:  StoredProcedure [dbo].[UPDATERentedMovies]    Script Date: 3/10/2020 11:21:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UPDATERentedMovies] 
	-- Add the parameters for the stored procedure here
	@RentedID int,
	@MovieFK int,
	@DateReturned datetime = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE RentedMovies
	SET MovieFK = @MovieFK, DateReturned = @DateReturned
	WHERE RentedID = @RentedID
END

GO
USE [master]
GO
ALTER DATABASE [VideoRental] SET  READ_WRITE 
GO
