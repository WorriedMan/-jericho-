addEventHandler ( "onClientResourceStart",  getResourceRootElement(getThisResource()), -- 272
	function ()
		local txd = engineLoadTXD ( "fam2.txd" )
		engineImportTXD ( txd, 232 )
		local dff = engineLoadDFF ( "fam2.dff", 232 )
		engineReplaceModel ( dff, 232 )
		local txd = engineLoadTXD ( "fam1.txd" )
		engineImportTXD ( txd, 225 )
		local dff = engineLoadDFF ( "fam1.dff", 225 )
		engineReplaceModel ( dff, 225 )
			
		local txd4 = engineLoadTXD ( "DS3.txd" )
		engineImportTXD ( txd4, 231 )
		local txd4 = engineLoadDFF ( "DS3.dff", 231 )
		engineReplaceModel ( txd4, 231 )
		local txd4 = engineLoadTXD ( "drova.txd" )
		engineImportTXD ( txd4, 1463 )
		local txd4 = engineLoadDFF ( "drova.dff", 1463 )
		engineReplaceModel ( txd4, 1463 )

		
		local txd4 = engineLoadTXD ( "titan.txd" )
		engineImportTXD ( txd4, 226 )
		local txd4 = engineLoadDFF ( "titan.dff",226 )
		engineReplaceModel ( txd4, 226 )

		
	end)