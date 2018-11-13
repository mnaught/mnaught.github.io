USE [VLM]
GO

/****** Object:  StoredProcedure [dbo].[VLM_PNPStatusUpdate__PNP]    Script Date: 06/24/2010 12:26:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[VLM_PNPStatusUpdate__PNP]
	
	@Yard_code int, 	
	@Barcode varchar(30),
	@OperFirstName  varchar(75),
	@OperLastName varchar(75),
	@ChangeDttm datetime ,	
	@StatusID int 
	-- Note incoming vlm handheld status ids 1-set, 2-crush, 3-xfercrush; 
	-- These are xlated out to pnp_wf_Status id's <12,15,20> here.
	
AS
BEGIN
	
	SET NOCOUNT ON;

	-- Update Status and append note.

    -- a) get VehicleId (barcode)    
    -- b) update CFJC Status
	-- c) update CFJC notes
	
	declare @Vehicle_id int	
	declare @YardName varchar(100)
	declare @D1Style varchar(200)
	declare @D1Model varchar(100)
	
	-- a ) 
	--------------------------------------------
		-- in: :Loc_code, barcode
		-- out: vehicleId's
		
	SELECT	@Vehicle_id = ISNULL(rdat.Vehicle_ID, -1),
			@YardName	= isnull (y.Name, ''),
			@D1Style	= isnull (D1.Style, ''),
			@D1Model	= isnull (D1.Model, '')
			
	from pnp.dbo.rcv_vehdata_dat rdat
			join pnp.dbo.veh_vehicle_dat vdat
			on rdat.vehicle_ID = vdat.vehicle_id	
			join pnp.dbo.YRD_Yard_pnp y on vdat.yard_id = y.yard_id		
			join pnp.dbo.rcv_Vehicle_dat rvd	on rvd.vehicle_Id = vdat.vehicle_Id
			left join dbo.VLM_DATAONE_IDP_REF D1 on D1.VIN_Pattern = LEFT(rvd.VEHICLE_VIN, 10) 
		where 		
			y.code = @Yard_code and 
			rdat.BAR_CODE_VALUE = @Barcode
			
			

	 if @Vehicle_id = -1
	
	
	begin
		declare @msg varchar(255)
		select @msg =  'Unrecognized barcode value [' + @Barcode + '] loc_code [' + convert(varchar(20), @Yard_code)
		
		raiserror ( @msg,
						16,
						1
					)
		return
	end		

	-- b) update status
	--------------------------------------------
	
	
	-- Note Status enum on handheld is {Set=1, Crush=2, TransferCrush=3}
	-- This is translated here to the VEH_WFStatus domain: (SET=12, Crush=15,TransferCrush=20}
	
	/*
	wfstatus_id DESCRIPTION
	----------- --------------------
	12          SET
	15          CRUSHED
	20          TRANSFERCRUSH (NEW VALUE)
	*/
	
	-- hh status enum -> wf_statusID	
	declare @VEH_WF_StatusID int 
	
	select @VEH_WF_StatusID = 		
		Case @StatusID 
			WHEN 1 then 12
			when 2 then 15
			WHEN 3 then 20
		end
		
	if (@StatusID > 0) and (@Vehicle_id != -1)
	begin
		-- Set status.	
		UPDATE pnp.dbo.VEH_VEHICLE_DAT 
		SET WFSTATUS_ID = @VEH_WF_StatusID
		where Vehicle_id = @Vehicle_id	
	end
	
	-- c) exec addNote, 
	--------------------------------------------	
	DECLARE @statusLabel varchar(255)

	select	@statusLabel = [DESCRIPTION]	
	from	pnp.dbo.VEH_WFSTATUS_PNP
	where	wfstatus_id = @VEH_WF_StatusID
	

if  (@Vehicle_id != -1)
begin
	-- formatting

	DECLARE @RC int
	DECLARE @vehicleid int
	DECLARE @userid int
	DECLARE @note varchar(255)

	Set @vehicleid = @Vehicle_id
	select @userid = 55 
	
	
	-- pre:  vehicleID is not null,
	-- 
	set @note = 'VLM Processing:  ' + @statusLabel 
				+ ' by ' + @OperFirstName + ' ' + @OperLastName
				+ Convert(varchar(20), @ChangeDttm)
				+ ' ' + @YardName
				--+ ' ' + '[' + @D1Style + ']' 
				--+ ' ' + '[' + @D1Model + ']' 
				
	exec @rc = [pnp].[dbo].[AddNote] @vehicleid, @userid, @note	
	
end

end


GO


