SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[SP_GET_ADAPTATION_AREAS]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROC [dbo].[SP_GET_ADAPTATION_AREAS]
	@WEBURL NVARCHAR(4000)
AS
BEGIN 
	DECLARE @ADPT_AREA_NID INT

	SET @ADPT_AREA_NID = (SELECT AREA_NID FROM ADAPTATIONS WHERE ONLINE_URL = @WEBURL)

	IF @ADPT_AREA_NID = -1
		BEGIN
			SELECT * FROM (
			SELECT TOP 10000 AREANID, AREANAME, AREAID, PARENTNID FROM AREAS 
				WHERE PARENTNID = -1			
				ORDER BY AREANAME) A
				UNION ALL
			SELECT * FROM (
				SELECT TOP 10000 AREANID, AREANAME, AREAID, PARENTNID 
				FROM AREAS
				WHERE AREALEVEL = 2 AND AREANID IN (SELECT DISTINCT AREA_NID FROM ADAPTATIONS WHERE AREA_NID>0)
				ORDER BY AREANAME
			) B
		END
	ELSE
		BEGIN
			SELECT AREANID, AREANAME, AREAID, PARENTNID FROM AREAS 
			WHERE AREANID = @ADPT_AREA_NID OR PARENTNID = @ADPT_AREA_NID
			ORDER BY AREANAME
		END
END
' 
END
