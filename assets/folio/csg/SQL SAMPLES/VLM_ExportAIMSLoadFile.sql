USE [VLM]
GO
if exists (select * from sysobjects where name ='VLM_ExportAIMSLoadFile')
	drop procedure [VLM_ExportAIMSLoadFile]
go

CREATE PROCEDURE [dbo].[VLM_ExportAIMSLoadFile]
	@Loc_ID int , 
	@FromDate Datetime 

AS
BEGIN
	SET NOCOUNT ON;	
	
	-- pre-export lookups:
	
		-- vehicleID -> activityTable.VEHICLE_ID
		update IA
		SET IA.vehicle_ID = RVD.VEHICLE_ID
		from [VLM_Inventory_Activity] IA 
			join  PNP.DBO.RCV_VehData_dat  rvd 
				on IA.BARCODE = RVD.BAR_CODE_VALUE
		WHERE IA.YARD_CODE = @Loc_ID
			AND IA.LOG_DTTM >= @FromDate
	
		-- stock number -> activity table.RECSTOCKNBR			
		update IA
		set RecStockNbr = S.STOCK_NO
		from [VLM_Inventory_Activity] ia JOIN 
		PNP.DBO.VEH_STOCK_DAT S
		ON IA.VEHICLE_ID  = S.VEHICLE_ID	
			
		WHERE IA.YARD_CODE = @Loc_ID
			--AND IA.LOG_DTTM >= @FromDate
	
	-- Note Status enum on handheld is {Set=1, Crush=2, TransferCrush=3}

-- Generate AIMs CSV:

Select 
	IA.Barcode 'c1',	--#1 -- Stock Number (last 6 digits of barcode).  Note: AIM calls it the "Stock Number" but Pick-n-Pull has a separate (more unique) vehicle identifier called "Stock Number".  
	'V'	'c2',			--#2 -- Type.  Should always be "V" for vehicle.
	rv.VEHICLE_VIN 'c3',	--#3 -- VIN.  Not critical but if you have the data, you might as well fill the field.
	rv.YEAR_CODE 'c4',	--#4		-- Vehicle year (2 digits).
	null 'c5',			--#5 -- Model Code.  You can leave this blank.
	isNull( xref.AIMS_MAKE_DESC ,  mdl.[Description] ) 'c6',		-- xlated.make--#6 -- .dbo.VLM_CFJC_AIMS_XREF.AIMS_MAKE_DESC
	isNull( xref.AIMS_MODEL_DESC ,  mk.[Description] ) 'c7',		-- xlated.model--#7 -- .dbo.VLM_CFJC_AIMS_XREF.AIMS_MODEL_DESC
	null 'c8',			--#8 -- Mileage.  You can leave this blank.
	convert(varchar(20),
		dbo.[fsPadLeft](Convert(varchar(4),@LOC_ID), '0', 3) 
		+ '-' +	dbo.[fsPadLeft]( convert(varchar(4), IA.ROW_NO),'0', 4)
		) 'c9', --#9 -- Location.  It should be in the form AAA-BBBB where AAA is the store # and BBBB is the row #, each with zero padding as needed.  Currently users have to fill this data as a single field and they mess up the syntax frequently.  The Tracker parser is a little flexible (ie, we can deal with missing zero padding).
	convert(varchar(1),'') 'c10',				--#10 -- Insurance #.  You can leave this blank.
	IA.LOG_DTTM 'c11',		--#11 -- Date Acquired.  Fill this field (and the next 2) with the date the vehicle was "set" in the yard.
	IA.LOG_DTTM 'c12',		--#12 = #11 -- Date of Title.
	IA.LOG_DTTM 'c13',		--#13 = #11 -- Date Dismantled.
	convert(varchar(1),'') 'c14',				--#14 -- Source Code.  You can leave this blank.
	convert(varchar(1),'') 'c15',				--#15 -- Type of Wreck.  You can leave this blank.
	'S' 'c16',				--#16 -- Salvage/Rebuild.  Should always be "S" for Salvage.
	null 'c17',				--#17 -- Vehicle Cost.  Leave blank.
	null 'c18',				--#18 -- Towing Cost.  Leave blank.
	null 'c19',				--#19 -- Process Cost.  Leave blank.
	null 'c20',				--#20 -- Anticipated Income.  Leave blank.
	null 'c21',				--#21 -- Total Actual Sales.  Leave blank.
	null 'c22',				--#22 -- Unknown.  Leave blank.
	0 'c22a',				--#22 -- Unknown.  Leave blank.
	null 'c22b',				--#22 -- Unknown.  Leave blank.
	Convert(varchar(80),
			isnull(convert(varchar(20),IA.RECSTOCKNBR), '!Err_No_RecNbr')+ ' ' 
			+ isnull( convert(varchar(20), clr.description), '') 
			+ isnull( convert(varchar(40), d1.STYLE), '') 
				)
	as 'desc_1',	--#23 -- Description Line 1.  You should fill this with the "Stock Number", a space, and then the color code.  For example: "10-M03-165 BLACK"
	Convert(varchar(1),'') 'c24',				--#24 -- Description Line 2.  Leave blank.
	Convert(varchar(1),'') 'c25',				--#25 -- Description Line 3.  Leave blank.
	Convert(varchar(1),'') 'c26',				--#26 -- Bought From.  Leave blank.
	Convert(varchar(1),'') 'c27',				--#27 -- Sold To.  Leave blank.
	Convert(varchar(1),null) 'c28',				--#28 -- Unknown.  Leave blank.
	Convert(varchar(1),null) 'c29',				--#29 -- Total Amount Paid.  Leave blank.
	Convert(varchar(1),'') 'c30',				--#30 -- Unknown.  Leave blank.
	Convert(varchar(1),'') 'c31',				--#31 -- Unknown.  Leave blank.
	Convert(varchar(1),'') 'c32',				--#32 -- Unknown.  Leave blank.
	Convert(varchar(1),'') 'C33'				--#33 -- Unknown.  Leave blank
	
	from 
		[VLM_Inventory_Activity] IA 
	join 	pnp.DBO.RCV_VehData_dat  rvd 
		ON IA.VEHICLE_ID = RVD.VEHICLE_ID
	join  pnp.dbo.RCV_Vehicle_Dat rv 	
		on rvd.Vehicle_ID = rv.Vehicle_ID
		
	join pnp.dbo.RCV_Receiving_Dat R 
		on R.Vehicle_ID = rv.Vehicle_ID
	join pnp.dbo.veh_color_pnp clr 
		on rv.color_ID = clr.color_id

	join pnp.dbo.Veh_Vehicle_Dat V
		on ia.vehicle_id = V.vehicle_id 
	join pnp.dbo.veh_Model_REF mdl 
		on v.model_id = mdl.model_ID
	join pnp.dbo.veh_Make_ref mk 
		on mdl.make_ID = mk.make_ID
	
	--	Translate cfjc make & model to Aims m/m descriptions
	 join dbo.VLM_CFJC_AIMS_XREF xref 
		 on mdl.model_ID = xref.CFJC_MODEL_ID
		 
	--- AIMS/CFJC match by year Range
	join [pnp].[dbo].[VEH_MODELYEAR_REF] my
		on mdl.Model_ID = my.Model_ID
		 and Convert(int,my.Year_Code) >= Convert( int, right(xref.Year_From, 2) )
		 and Convert(int,my.Year_Code) <= Convert( int, right(xref.Year_to, 2) )
	
	-- Dataone Style 	 
	left join dbo.VLM_DATAONE_IDP_REF D1 on D1.VIN_Pattern = LEFT(rv.VEHICLE_VIN, 10) 
	
WHERE IA.YARD_CODE = @Loc_ID
			--AND IA.LOG_DTTM >= @FromDate
			and IA.INVENTORY_STATUS_ID = 1 -- only exporting SET records for now. (CRUSH+ post-pilot.)

-- Log unmatchables:

	Insert CFJC_AIMS_TRANSLATION_MISS ( CFJC_MAKE_ID, CFJC_MODEL_ID, RUNDTTM )
	SELECT distinct
		mk.make_ID, v.model_id, GETDATE() 
	from 	[VLM_Inventory_Activity] IA 			
		join pnp.dbo.Veh_Vehicle_Dat V
			on ia.vehicle_id = V.vehicle_id 
		join pnp.dbo.veh_Model_REF mdl on v.model_id = mdl.model_ID
		join pnp.dbo.veh_Make_ref mk on mdl.make_ID = mk.make_ID
		
		--	Translate cfjc make & model to Aims m/m descriptions
		 LEFT join dbo.VLM_CFJC_AIMS_XREF xref 
			 on mdl.model_ID = xref.CFJC_MODEL_ID
			 
		--- AIMS/CFJC match by year Range
		LEFT join [pnp].[dbo].[VEH_MODELYEAR_REF] my
			on mdl.Model_ID = my.Model_ID
			 and Convert(int,my.Year_Code) >= Convert( int, right(xref.Year_From, 2) )
			 and Convert(int,my.Year_Code) <= Convert( int, right(xref.Year_to, 2) )
	
	where	xref.AIMS_Make_desc is null
			or xref.AIMS_Model_desc is null

END


GO


