SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GET_SITEMAP_DATA]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROC [dbo].[SP_GET_SITEMAP_DATA]
AS
BEGIN
 SELECT * FROM DBO.DI_SEARCH_RESULTS
END

' 
END
ELSE
BEGIN
EXEC dbo.sp_executesql @statement = N'

ALTER PROC [dbo].[SP_GET_SITEMAP_DATA]
AS
BEGIN
 SELECT * FROM DBO.DI_SEARCH_RESULTS
END

' 
END
GO