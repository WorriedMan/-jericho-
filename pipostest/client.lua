outputDebugString('pipostest started')

exports.pipos:createPipWindow ( {x = 200, y = 200, width = 300, height = 400, alpha = 150, name = "addItemToHouseWindow" } )
showCursor(true)

local itemsCategories = {
	"Картины",
	"Двери",
	"Кровати",
	"Электроника",
	"Разное"
}

local items = {
	{"Картина 1",cat = 1},
	{"Картина 2",cat = 1},
	{"Картина 3",cat = 1},
	{"Картина 4",cat = 1},
	{"Картина 5",cat = 1},
	{"Картина 6",cat = 1},
	{"Картина 7",cat = 1},
	{"Картина 8",cat = 1},
	{"Картина 9",cat = 1},
	{"Картина 10",cat = 1},
	{"Картина 11",cat = 1},
	{"Картина 12",cat = 1},
	{"Картина 13",cat = 1},
	{"Картина 14",cat = 1},
}

exports.pipos:createPipList ( {x=10,y=10,width = 280,height = 300,name = "addItemToHouseList",parent="addItemToHouseWindow"} )
for i, v in ipairs ( itemsCategories ) do
	local count = exports.pipos:pipListAddItem({parent="addItemToHouseList",label=v})
	exports.pipos:pipListSetItemData("addItemToHouseList",count,"catNum",i)
end
exports.pipos:createPipButton ( {x=10,y=360,width = 280,height = 30,name = "closeItemHouseWindow",itext= "Закрыть", parent="addItemToHouseWindow",alignX = "center",alignY="center",showBack=true} )


addEvent ( "pipos:listClicked", false )
function listClicked ( list, listTable, selectedRow )
	local catNum = exports.pipos:pipListGetItemData(list,selectedRow,"catNum")
	outputDebugString("catNum "..tostring(catNum))
	if catNum then
		exports.pipos:pipListClear(list)
		for i, v in ipairs ( items ) do
			if v.cat == catNum then
				exports.pipos:pipListAddItem({parent="addItemToHouseList",label=v[1],data={["itemID"] = i}})
			end
		end
	end
	
end
addEventHandler ( "pipos:listClicked", getRootElement(), listClicked )