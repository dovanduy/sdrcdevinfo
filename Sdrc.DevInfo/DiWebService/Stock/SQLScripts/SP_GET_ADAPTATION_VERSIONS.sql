SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_GET_ADAPTATION_VERSIONS]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROC [dbo].[SP_GET_ADAPTATION_VERSIONS]
AS
BEGIN
	SELECT * FROM DBO.ADAPTATIONVERSION
END' 
END
