local maxmarks = 0
workmark={}
playerworkmark={}
playerworkblip={}
addEventHandler ( "onResourceStart", getResourceRootElement(),
function ()
  local root = xmlLoadFile ("jobs.xml")
  local houseroot = xmlFindChild (root,"work",0)
  if (houseroot) then
    for i,v in ipairs (xmlNodeGetChildren(houseroot)) do
      local x = xmlNodeGetAttribute (v,"posX")
      local y = xmlNodeGetAttribute (v,"posY")
      local z = xmlNodeGetAttribute (v,"posZ")
      workmark[i]={x,y,z}
      maxmarks = maxmarks + 1
    end
    outputDebugString ("Work pos loaded!")
  end
	ncWorkPickup = createPickup ( -728.4619140625,2069.6240,60.3347, 3, 1239 )
	nvWorkPickup = createPickup ( -271.740234375,2691.828125,62.6875, 3, 1239 )
	scWorkPickup = createPickup ( -289.326171875,1493.103515625,76.124565124512, 3, 1239 )
end
)

function workPickup(player)
	if getElementData ( player, "workfindtype" ) == 0 then
		if source == ncWorkPickup then
			exports.pipboy:addInfoBox("Толстушке Бэтси нужен человек, который привезет ей несколько пачек чая для похудания", 4, player )
			exports.pipboy:addInfoBox("Чтобы принять эту работу, нажмите E", 3, player )
			bindKey ( player, "E", "down", startFindWork )
			local colshape = getElementColShape ( source )
			setElementData ( player, "workShape", source )
			addEventHandler( "onElementColShapeLeave", player, workPickupLeave ) 
		elseif source == nvWorkPickup then
			exports.pipboy:addInfoBox("Старый Генри ищет смелого парня, который смог бы найти для него пару колод карт", 4, player )
			exports.pipboy:addInfoBox("Чтобы принять эту работу, нажмите E", 3, player )
			bindKey ( player, "E", "down", startFindWork )
			local colshape = getElementColShape ( source )
			setElementData ( player, "workShape", source )
			addEventHandler( "onElementColShapeLeave", player, workPickupLeave ) 
		elseif source == scWorkPickup then
			exports.pipboy:addInfoBox("Отец Фифан ищет помошника, который добудет для него несколько библий", 4, player )
			exports.pipboy:addInfoBox("Чтобы принять эту работу, нажмите E", 4, player )
			bindKey ( player, "E", "down", startFindWork )
			local colshape = getElementColShape ( source )
			setElementData ( player, "workShape", source )
			addEventHandler( "onElementColShapeLeave", player, workPickupLeave ) 
		end
	end
end

addEventHandler ( "onPickupUse", getRootElement(), workPickup )

function workPickupLeave (colshape)
	if getElementData ( source, "workShape" ) then
		local shape = getElementData ( source, "workShape")
		if shape == colshape then
			removeEventHandler( "onElementColShapeLeave", source, workPickupLeave ) 
			setElementData ( source, "workShape", false )
			unbindKey ( source, "E", "down", startFindWork )
		end
	end
end

function startFindWork ( source, cmd )
	if  getElementData ( source, "workfindtype" ) == 0 then
		unbindKey ( hitElement, "E", "down", startFindPlace )
		if exports.sweetyRP:playerToPoint( source, 10, -728.4619140625,2069.6240,60.3347 ) then
		    setElementData ( source, "workfindtype", 1 )
		elseif exports.sweetyRP:playerToPoint( source, 10, -271.740234375,2691.828125,62.6875 ) then
	    	setElementData ( source, "workfindtype", 2 )
		elseif exports.sweetyRP:playerToPoint( source, 10, -289.326171875,1493.103515625,76.124565124512 ) then
	     	setElementData ( source, "workfindtype", 3 )
		end
		local work = math.random(1, maxmarks)
		local x = workmark[work][1]
		local y = workmark[work][2]
		local z = workmark[work][3]
		exports.pipboy:addInfoBox( "Вы получили на карту PIPBOY отметку, с примерным положением цели",4,source )
		exports.pipboy:addMapIcon( x,y,z,3,"Цель",source )
		playerworkmark[getElementData(source,"playerid")] = createMarker ( x, y, z, "checkpoint", 3, 255, 102, 204, 0, source )
		setElementVisibleTo ( playerworkmark[getElementData(source,"playerid")], source )
		setElementData ( source, "markerLink", playerworkmark[getElementData(source,"playerid")] )
		addEventHandler( "onMarkerHit", playerworkmark[getElementData(source,"playerid")], workPlaceHit )
		addEventHandler( "onMarkerLeave", playerworkmark[getElementData(source,"playerid")], workPlaceLeave )
		addEventHandler ( "onPlayerQuit", source, quitWorkingPlayer )
		--outputChatBox ("Подсказка: Нажмите кнопку F11 для открытия карты", source, 255,255,255 )
		playerworkblip[getElementData(source, "playerid")] = createBlipAttachedTo ( playerworkmark[getElementData(source,"playerid")], 37, 2, 255, 0, 0, 255, 0, 99999, source )
	end
end

addCommandHandler ( "jtw", startFindWork )

function workPlaceHit( hitElement, matchingDimension )
	if getElementType ( hitElement ) == "player" then
		local targetMarker = getElementData(hitElement,"markerLink")
		if targetMarker then
			if isElement ( targetMarker ) then
				if targetMarker == source then
					exports.pipboy:addInfoBox( "Нажмите кнопку У для поиска",3,hitElement )
					bindKey ( hitElement, "E", "down", startFindPlace )
				end
			end
		end
	end
end

function workPlaceLeave( hitElement, matchingDimension )
	if getElementType ( hitElement ) == "player" then
		local targetMarker = getElementData(source,"markerLink")
		if targetMarker then
			if isElement ( targetMarker ) then
				if targetMarker == source then
					unbindKey ( hitElement, "E", "down", startFindPlace )
				end
			end
		end
	end
end


function startFindPlace ( source, key )
	if getElementData ( source, "workfindtype" ) ~= nil and getElementData ( source, "workfindtype" ) ~= 0 then
		local x, y, z = getElementPosition ( playerworkmark[getElementData(source,"playerid")] )
		if exports.sweetyRP:playerToPoint( source, 10, x, y, z ) then
   			local find = math.random(1, 10)
   			if find > 2 then
				if getElementData ( source, "workfindtype" ) == 1 then
                    exports.pipboy:addInfoBox( "Вы нашли несколько пачек чая для похудания! Награда: 250$",3,source )
                    givePlayerMoney ( source, 250 )
					--exports.relations:addRelation ( 1, 5 )
				elseif getElementData ( source, "workfindtype" ) == 2 then
				    exports.pipboy:addInfoBox( "Вы нашли несколько колод игральных карт! Награда: 350$",3,source )
					--exports.relations:addRelation ( 3, 5 )
				    givePlayerMoney ( source, 350 )
				elseif getElementData ( source, "workfindtype" ) == 3 then
				    exports.pipboy:addInfoBox( "Вы нашли библию! Награда: 150$",3,source)
					--exports.relations:addRelation ( 2, 5 )
				    givePlayerMoney ( source, 150 )
				end
			else
			    exports.pipboy:addInfoBox( "Здесь ничего нету, наверное вас обманули...",3,source)
			end
			unbindKey ( source, "E", "down", startFindPlace )
  			setElementData ( source, "workfindtype", 0 )
			exports.pipboy:deleteMapIconByText( "Цель",source )
  			destroyElement ( playerworkmark[getElementData(source, "playerid")] )
  			destroyElement ( playerworkblip[getElementData(source, "playerid")] )
			playerworkmark[getElementData(source, "playerid")] = nil
			playerworkblip[getElementData(source, "playerid")] = nil
		else
		    exports.pipboy:addInfoBox( "Здесь ничего нет",2,source )
		end
	end
end

function quitWorkingPlayer ( quitType )
	local playerid = getElementData(source, "playerid")
	local marker = playerworkmark[playerid]
	local blip = playerworkblip[playerid]
	if isElement ( marker ) then
		playerworkmark[playerid] = nil
		destroyElement ( marker )
	end
	if isElement ( blip ) then
		playerworkblip[playerid] = nil
		destroyElement ( blip )
	end
end

addCommandHandler ( "findp", startFindPlace )



	