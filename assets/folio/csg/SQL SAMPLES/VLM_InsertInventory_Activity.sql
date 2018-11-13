USE [VLM]
GO

/****** Object:  StoredProcedure [dbo].[VLM_InsertInventory_Activity]    Script Date: 06/22/2010 08:21:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

if exists (select * from sysobjects where name = 'VLM_InsertInventory_Activity')
	drop procedure VLM_InsertInventory_Activity
go

--region [dbo].[VLM_InsertInventory_Activity]

------------------------------------------------------------------------------------------------------------------------
-- Procedure Name: [dbo].[VLM_InsertInventory_Activity]
-- Date Generated: Monday, June 14, 2010
------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[VLM_InsertInventory_Activity]
	@RECSTOCKNBR varchar(20),
	@BARCODE varchar(30),
	@YARD_CODE int,
	@DEVICE_LOGIN_ID varchar(75),
	@LOG_DTTM datetime,
	@OPER_FIRSTNAME varchar(75),
	@OPER_LASTNAME varchar(75),
	@ROW_NO int,
	@INVENTORY_STATUS_ID int,
	@VLM_PROCESSING_DTTM datetime,
	@VLM_SERVICE_ACCOUNT varchar(255)
AS

SET NOCOUNT ON


if not exists (
	select * 
	from [VLM_Inventory_Activity] 
	where 
		barcode =  @BARCODE and
		LOG_DTTM =  @LOG_DTTM and
		YARD_CODE = @YARD_CODE
		)
Begin

INSERT INTO [dbo].[VLM_Inventory_Activity] (
	[RECSTOCKNBR],
	[BARCODE],
	[YARD_CODE],
	[DEVICE_LOGIN_ID],
	[LOG_DTTM],
	[OPER_FIRSTNAME],
	[OPER_LASTNAME],
	[ROW_NO],
	[INVENTORY_STATUS_ID],
	[VLM_PROCESSING_DTTM],
	[VLM_SERVICE_ACCOUNT],
	[VLM_PROCESSING_STATUS]
) VALUES (
	@RECSTOCKNBR,
	@BARCODE,
	@YARD_CODE,
	@DEVICE_LOGIN_ID,
	@LOG_DTTM,
	@OPER_FIRSTNAME,
	@OPER_LASTNAME,
	@ROW_NO,
	@INVENTORY_STATUS_ID,
	@VLM_PROCESSING_DTTM,
	@VLM_SERVICE_ACCOUNT,
	'UNPROCESSED'
)
End
--endregion


GO


