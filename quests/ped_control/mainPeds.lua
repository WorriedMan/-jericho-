function loadMainPeds ()	

			
				-- Охранники Новой Деревни
			
		-- Охранники Новой Деревни
		
		-- Охранники Нового Вегаса
			
		--local buypickup1 = createPickup ( -940.9833984375,1857.2294921875,5,3, 1239 )
		--local ammopickup = createPickup ( 288.0966796875,-109.7119140625,1001.515625, 3, 1274 )
		--local buypickup = createPickup ( 2.3837,-29.0126,1003.5494, 3, 1274 )
		--createMarker ( -572.5166015625,2022.857421875,58.3828125, "cylinder", 2 )       -- dm
	--	createMarker ( -168.669921875,2707.10546875,60.525890350342, "cylinder", 2 )    -- dm
		--createMarker ( -253.77354431152,1495.8074951172,74.01212310791, "cylinder", 2 ) -- DM
		
		
		addEventHandler( 'onClientPedDamage', getRootElement(), 
												function () 
													if getElementData ( source, "npc-ped" ) then
														cancelEvent()
													end
												end	)
end
			
addEventHandler( "onClientResourceStart",  getResourceRootElement(getThisResource()), loadMainPeds);