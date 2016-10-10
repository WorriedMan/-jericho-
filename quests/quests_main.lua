GUIEditor_Window = {}
GUIEditor_Button = {}
GUIEditor_Label = {} 

local localPlayer = getLocalPlayer ()

local guiShowed = 0

sold_pos = 0
soldiers_poses_x_nc={}
soldiers_poses_x_nc =
{
-653.6083984375,
-676.681640625,
-752.6416015625,
-876.710937,
-590.6376953125,
}

soldiers_poses_y_nc =
{
2068.6318359375,
2049.6474609375,
2044.125,
1950.5009765625,
2017.2724609375,
}

soldiers_poses_z_nc =
{
60.186485290527,
60.3828125,
60.3828125,
60.119209289551,
60.381847381592,
}

soldiers_poses_x_su={
-265.259765625,
-363.591796875, -- въезд
247.6962890625,
-326.736328125,
256.6767578125,
-349.2197265625,-- въезд
}

soldiers_poses_y_su={
1535.7763671875,
1404.12890625,
1797.5517578125,
1536.7802734375,
1850.0576171875,
1402.376953125,
}

soldiers_poses_z_su={
75.5625,
58.766437530518,
7.4140625,
75.5625,
8.7578125,
58.511966705322,
}

soldiers_poses_x_nv={}
soldiers_poses_x_nv =
{
-322.8994140625,
-176.060546875,
-254.8955078125,
-227.15234375,
-210.267578125,
-223.4775390625,
-249.0634765625,
-301.4482421875,
}

soldiers_poses_y_nv =
{
2672.416015625,
2662.53515625,
2601.2978515625,
2709.890625,
2713.0693359375,
2643.9013671875,
2799.771484375,
2620.0673828125,
}

soldiers_poses_z_nv =
{
62.72730255127,
62.849998474121,
62.858154296875,
62.984329223633,
62.979370117188,
62.96418762207,
62.194034576416,
63.523143768311,
}

local screenWidth,screenHeight = guiGetScreenSize()
time_moving = true

function showQuestWindow ( person, text, var1, var1_do, var2, var2_do, var3, var3_do, var4, var4_do )
	if guiShowed == 0 then
	
	guiShowed = 1

	weight = 380

	if var4 ~= "0" then
		weight = 380
	else
		if var3 ~= "0" then
			weight = 345
		else
			if var2 ~= "0" then
				weight = 310
			else
				weight = 265
			end
		end
	end
	
	GUIEditor_Window[1] = guiCreateWindow(screenWidth/2-320,screenHeight/2-160,640,380,person,false)
	GUIEditor_Button[1] = guiCreateButton(screenWidth/2-310,screenHeight/2+60, 620, 35,var1,false)
	guiSetFont(GUIEditor_Button[1],"default-bold-small")
	GUIEditor_Button[2] = guiCreateButton(screenWidth/2-310,screenHeight/2+100, 620, 35,var2,false)
	guiSetFont(GUIEditor_Button[2],"default-bold-small")
	GUIEditor_Button[3] = guiCreateButton(screenWidth/2-310,screenHeight/2+140, 620, 35,var3,false)
	guiSetFont(GUIEditor_Button[3],"default-bold-small")	
	GUIEditor_Button[4] = guiCreateButton(screenWidth/2-310,screenHeight/2+180, 620, 35,var4,false)
	guiSetFont(GUIEditor_Button[4],"default-bold-small")
	GUIEditor_Label[1] = guiCreateLabel(screenWidth/2-310,screenHeight/2-135, 150, 50,person..":",false)
	guiSetFont(GUIEditor_Label[1],"default-bold-small")
	GUIEditor_Label[2] = guiCreateLabel(screenWidth/2-290,screenHeight/2-115,600,180,text,false)
	guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",true)
	
	guiSetVisible ( GUIEditor_Window[1], true )
	
	showCursor ( true )
	
	guiSetSize ( GUIEditor_Window[1], 640, weight, false )
	
	addEventHandler("onClientGUIClick", GUIEditor_Button[1],
		function ()
			if not time_moving then
				return true
			end
			time_moving = false
			setTimer ( function () time_moving = true end, 1000, 1 )
			guiSetVisible ( GUIEditor_Window[1], false )
			guiSetVisible ( GUIEditor_Label[1], false )
			guiSetVisible ( GUIEditor_Label[2], false )
			guiSetVisible ( GUIEditor_Button[1], false )
			guiSetVisible ( GUIEditor_Button[2], false )
			guiSetVisible ( GUIEditor_Button[3], false )
			guiSetVisible ( GUIEditor_Button[4], false )
			destroyElement (GUIEditor_Window[1])
			destroyElement (GUIEditor_Label[1])
			destroyElement (GUIEditor_Label[2])
			destroyElement (GUIEditor_Button[1])
			destroyElement (GUIEditor_Button[2])
			destroyElement (GUIEditor_Button[3])
			destroyElement (GUIEditor_Button[4])
			showCursor ( false )
			guiShowed = 0
			if var1_do ~= "0" then
				assert(loadstring(var1_do))()
			end
		end
	,false)
	if var2 ~= "0" then
	addEventHandler("onClientGUIClick", GUIEditor_Button[2],
		function ()
			if not time_moving then
				return true
			end
			time_moving = false
			setTimer ( function () time_moving = true end, 1000, 1 )
			guiSetVisible ( GUIEditor_Window[1], false )
			guiSetVisible ( GUIEditor_Label[1], false )
			guiSetVisible ( GUIEditor_Label[2], false )
			guiSetVisible ( GUIEditor_Button[1], false )
			guiSetVisible ( GUIEditor_Button[2], false )
			guiSetVisible ( GUIEditor_Button[3], false )
			guiSetVisible ( GUIEditor_Button[4], false )
			destroyElement (GUIEditor_Window[1])
			destroyElement (GUIEditor_Label[1])
			destroyElement (GUIEditor_Label[2])
			destroyElement (GUIEditor_Button[1])
			destroyElement (GUIEditor_Button[2])
			destroyElement (GUIEditor_Button[3])
			destroyElement (GUIEditor_Button[4])
			showCursor ( false )
			guiShowed = 0
			if var2_do ~= "0" then
				assert(loadstring(var2_do))()
			end
		end
	,false)
	else
		guiSetVisible ( GUIEditor_Button[2], false )
	end
	if var3 ~= "0" then
		addEventHandler("onClientGUIClick", GUIEditor_Button[3],
			function ()
			if not time_moving then
				return true
			end
			time_moving = false
			setTimer ( function () time_moving = true end, 1000, 1 )
			guiSetVisible ( GUIEditor_Window[1], false )
			guiSetVisible ( GUIEditor_Label[1], false )
			guiSetVisible ( GUIEditor_Label[2], false )
			guiSetVisible ( GUIEditor_Button[1], false )
			guiSetVisible ( GUIEditor_Button[2], false )
			guiSetVisible ( GUIEditor_Button[3], false )
			guiSetVisible ( GUIEditor_Button[4], false )
			destroyElement (GUIEditor_Window[1])
			destroyElement (GUIEditor_Label[1])
			destroyElement (GUIEditor_Label[2])
			destroyElement (GUIEditor_Button[1])
			destroyElement (GUIEditor_Button[2])
			destroyElement (GUIEditor_Button[3])
			destroyElement (GUIEditor_Button[4])
				showCursor ( false )
				guiShowed = 0
				if var3_do ~= "0" then
					assert(loadstring(var3_do))()
				end
			end
		,false)
	else
		guiSetVisible ( GUIEditor_Button[3], false )
	end
	if var4 ~= "0" then
		addEventHandler("onClientGUIClick", GUIEditor_Button[4],
			function ()
			if not time_moving then
				return true
			end
			time_moving = false
			setTimer ( function () time_moving = true end, 1000, 1 )
			guiSetVisible ( GUIEditor_Window[1], false )
			guiSetVisible ( GUIEditor_Label[1], false )
			guiSetVisible ( GUIEditor_Label[2], false )
			guiSetVisible ( GUIEditor_Button[1], false )
			guiSetVisible ( GUIEditor_Button[2], false )
			guiSetVisible ( GUIEditor_Button[3], false )
			guiSetVisible ( GUIEditor_Button[4], false )
			destroyElement (GUIEditor_Window[1])
			destroyElement (GUIEditor_Label[1])
			destroyElement (GUIEditor_Label[2])
			destroyElement (GUIEditor_Button[1])
			destroyElement (GUIEditor_Button[2])
			destroyElement (GUIEditor_Button[3])
			destroyElement (GUIEditor_Button[4])
				showCursor ( false )
				guiShowed = 0
				if var4_do ~= "0" then
					assert(loadstring(var4_do))()
				end
			end
		,false)
	else
		guiSetVisible ( GUIEditor_Button[4], false )
	end
	
	setTimer ( checkQuestWindow, 2000, 1 )
	
	end
end

function isQuestWindowNotVisible ()
	if isElement ( GUIEditor_Window[1] ) then
		if GUIEditor_Window[1] then
			if guiGetVisible ( GUIEditor_Window[1] ) then
				return false
			else
				return true
			end
		else
			return true
		end
	else
		return true
	end
end

addEvent( "checkQuestWindowVisible", true )
addEventHandler( "checkQuestWindowVisible", getRootElement(), isQuestWindowNotVisible )

function checkQuestWindowDeath ( )
	if isElement(GUIEditor_Window[1]) then
		if guiGetVisible (  GUIEditor_Window[1] ) then
			guiSetVisible ( GUIEditor_Window[1], false )
			guiSetVisible ( GUIEditor_Label[1], false )
			guiSetVisible ( GUIEditor_Label[2], false )
			guiSetVisible ( GUIEditor_Button[1], false )
			guiSetVisible ( GUIEditor_Button[2], false )
			guiSetVisible ( GUIEditor_Button[3], false )
			guiSetVisible ( GUIEditor_Button[4], false )
			destroyElement (GUIEditor_Window[1])
			destroyElement (GUIEditor_Label[1])
			destroyElement (GUIEditor_Label[2])
			destroyElement (GUIEditor_Button[1])
			destroyElement (GUIEditor_Button[2])
			destroyElement (GUIEditor_Button[3])
			destroyElement (GUIEditor_Button[4])
			showCursor ( false )
			guiShowed = 0
			return true
		end
	end
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), checkQuestWindowDeath )

function checkQuestWindow ()
	if getElementData ( localPlayer, "live-ped" ) == 1 then
		if guiShowed == 0 then	
			triggerServerEvent ( "pedUnLookC", getLocalPlayer() ) 
			setElementData ( localPlayer, "live-ped", 0 )
		else
			setTimer ( checkQuestWindow, 2000, 1 )
		end
	end
end

function testCommandHandler ()

	setElementPosition ( localPlayer, -2274.34765625,2677.4365234375,55.4296875 ) 

end

--addCommandHandler ("kl", testCommandHandler)
	
function testCreateMarker ()
	tunnelMarker_1 = createMarker ( -2274.34765625,2677.4365234375,55.4296875, "corona", 1, 255,255,255 )
	tunnelMarker_2 = createMarker ( -2253.5205078125,2646.0595703125,55.37158203125, "corona", 1, 255,255,255 )
end

--addCommandHandler ("jk", testCreateMarker)	
	
addEventHandler( "onClientResourceStart", getRootElement( ),
    function ( startedRes )
		bindKey ( "E", "down", checkNearQuest ) 
    end
)

talkPositions = {
	{ -652.220703125,1773.6015625,12069.620117188, "talkSecretary()" },
	{ -943.900390625,1947.31640625,5, "talkJohnPochatok()" },
	{ -637.73046875,2067.8916015625,60.3828125, "talkBigBill()" },
	{ -954.361328125,1913.330078125,5, "talkKatyPerry()" },
	{ -795.4423828125,2025.6337890625,60.390625, "talkStanMarsh()" },
	{ -1532.0859375,2601.240234375,55.692333221436, "talkLuisSuarez()" },
	{ -288.9287109375,2690.0185546875,62.8125, "talkMehSoldier()" },
	{ -953.544921875,1871.1142578125,5, "bank_nc_nv_Soldiers_Q()" },
	{ 504.57421875,-69.763671875,998.7578125, "talkKickerNV()" },
	{ 494.525390625,-76.0400390625,998.7578125, "talkBarmanNV()" }
	
}

talkPositionsNC = {
	"bank_nc_nv_Soldiers_Q()",
	"talkLuisSuarez()",
	"talkBigBill()",
	"talkStanMarsh()",
	"talkKatyPerry()",
	"talkJohnPochatok()",
	"talkSecretary()",
	"talkDylan()",
	"talkDoc()",
	"talkGunSeller()",
	"militia_talk_start_NC()",
	"talkRobert()",
	"talkMedic()",
}

talkPositionsSU = {
	"talkRobbins()", 
	"talkPopeye()",
	"talkComradeSU()",
	"talkMinet()",
	"talkSamara()",
	"talkBandit()",
	"talkLizWatfard()",
}

talkPositionsNV = {
	"talkBarmanNV()",
	"talkStrange()",
	"talkKickerNV()",
	"talkMehSoldier()",
	"talkCash()",
	"talkFool()",
	"talkMayorNV()",
	"talkHerbert()",
	"talkArenaBoss()",
}

talkPositionsTP = {
	"talkBobbyTP()",
	"talkMatsy()",
	"talkFreman()",
	"talkLol()",
}

talkPositionsCL = {
	"talkXzibit()",
	"rodg_Carn_Q()",
}

talkPositionsRC = {
	"talkPreston()",
	"talkWilks()",
	"talkSlimFatsy()",
	"talkGun()",
	"talkBonny()",
	"talkBenny()",
	"talkVera()",
	"talkMehRC()",
	"talkGorbov()",
	"talkPerkins()",
}

talkPositionsKL = {
	"talkSyag()",
	"talkRight()",
	"guy_Carn_Q()",
	"talkBakD()",
	"talkChackD()",
	"talkPoul()",
	"talkJer()",
	"talkEdem()",
	"talkLuuk()",
	"talkLisaS()",
	"talkEdemGuard()",
	"talkSallyWilson()",
	"talkJericho()",
	"whis_tell_KL()"
}


talkPositionsHC = {
	"talkRobertHC()",
	"talkWendyHC()",
	"stark_talk_HC()",
	"willy_s_HC()",
	
}

collIdioms = {
	"Коллекционер: Иди своей дорогой",
	"Коллекционер: Не мешай",
	"Коллекционер: Проходи мимо, амиго",
	"Коллекционер: ¿Qué es lo que quieres?",
}

willyIdioms = {
	"Бандит: Говори с Вилли",
	"Бандит: Отвали",
	"Бандит: Проблем хочешь? Мы тебе их легко устроим",
	"Бандит: Иди отсюдова",
	"Бандит: Сейчас пизды получишь",
}

local pause = 0

function checkNearQuest ()
--outputChatBox ( "1" )
	if pause == 0 then
		if not getElementData ( localPlayer, "norLiveKilled" ) then
	--	outputChatBox ( "2" )
			local x,y,z = getElementPosition ( localPlayer )
			pause = 1
			setTimer ( function () pause = 0 end, 3000, 1 )
			if getElementData ( localPlayer, "cshpNPC_p" ) then
				if getElementData ( localPlayer, "cshpNPC_l" ) == 1 then
					sold_pos = getElementData ( localPlayer, "cshpNPC_id" )
					if getElementData ( localPlayer, "cshpNPC_p" ) == 1 then
						meet_nc_Soldiers_Q(x,y,z)
					elseif getElementData ( localPlayer, "cshpNPC_p" ) == 2 then
						meet_su_Soldiers_Q(x,y,z)
					elseif getElementData ( localPlayer, "cshpNPC_p" ) == 3 then
						meet_nv_Soldiers_Q(x,y,z)
					elseif getElementData ( localPlayer, "cshpNPC_p" ) == 5 then
						outputChatBox ( collIdioms[math.random ( 1, #collIdioms )], 255, 255, 255 )
					else
						outputChatBox ( willyIdioms[math.random ( 1, #willyIdioms )], 255, 255, 255 )
						--meet_cl_Soldiers_Q(x,y,z)
					end
				else
					if getElementData ( localPlayer, "cshpNPC_p" ) == 1 then
						assert(loadstring(talkPositionsNC[getElementData ( localPlayer, "cshpNPC_id" )]))()
					elseif getElementData ( localPlayer, "cshpNPC_p" ) == 2 then
						assert(loadstring(talkPositionsSU[getElementData ( localPlayer, "cshpNPC_id" )]))()
					elseif getElementData ( localPlayer, "cshpNPC_p" ) == 3 then
						assert(loadstring(talkPositionsNV[getElementData ( localPlayer, "cshpNPC_id" )]))()
					elseif getElementData ( localPlayer, "cshpNPC_p" ) == 4 then
						assert(loadstring(talkPositionsTP[getElementData ( localPlayer, "cshpNPC_id" )]))()
					elseif getElementData ( localPlayer, "cshpNPC_p" ) == 5 then
						assert(loadstring(talkPositionsCL[getElementData ( localPlayer, "cshpNPC_id" )]))()
					elseif getElementData ( localPlayer, "cshpNPC_p" ) == 6 then
						assert(loadstring(talkPositionsRC[getElementData ( localPlayer, "cshpNPC_id" )]))()
					elseif getElementData ( localPlayer, "cshpNPC_p" ) == 8 then
						assert(loadstring(talkPositionsHC[getElementData ( localPlayer, "cshpNPC_id" )]))()
					else
						assert(loadstring(talkPositionsKL[getElementData ( localPlayer, "cshpNPC_id" )]))()
					end
				end
			end
			-- if controllingPeds[1] then
				-- local xp,xo,xi = getElementPosition ( controllingPeds[1] )
				-- if playerToPointClient ( 1, getElementPosition ( controllingPeds[1] ) ) then
					-- if getElementData ( localPlayer, "quest_nvinsane" ) == 0 then
						-- nv_Insane_Q (x,y,z)
						-- triggerServerEvent ( "pedLookAndStop", getLocalPlayer(), controllingPeds[1] ) 
						-- setElementData ( localPlayer, "ped_dialog", controllingPeds[1] )
						-- setElementData ( localPlayer, "live-ped", 1 )
					-- elseif getElementData ( localPlayer, "quest_nvinsane" ) == 1 then
						-- outputChatBox ("Подсказка: Отправляйтесь к большому камню.", 255,255,255 )
						-- outputChatBox ("Чудак: Яяя будууу ждать тебя у большого кааамня в полдееень!", 255,255,255 )		
					-- end
					-- return true
				-- end
			-- end
		end
	end
end

function talkStrange ()
	if getElementData ( localPlayer, "quest_ring" ) == 3 then
		strange_s_ring ()
	elseif getElementData ( localPlayer, "quest_ring" ) == 6 then
		outputChatBox ( 'Странник: Она ушла, но будь осторожен, Самара может вернутся', 255, 255, 255 )
	else
		outputChatBox ( 'Странник: Иди своей дорогой', 255, 255, 255 )
	end
end

function talkHerbert ()
	if getElementData ( localPlayer, "quest_her" ) == 0 then
		her_quest_start ()
	elseif getElementData ( localPlayer, "quest_her" ) == 2 then
		her_found ()
	end
end

function talkSamara ()
	if getElementData ( localPlayer, "quest_ring" ) == 1 then
		samara_quest_start ()
	elseif getElementData ( localPlayer, "quest_ring" ) == 5 then
		samara_quest_s_finale ()
	end
end

function talkJericho ()
	jericho_talk_KL ()
end

function talkSallyWilson ()
	sally_talk_KL ()
end

function talkEdemGuard ()
	outputChatBox ( "Охранник: Уйдите со сцены", 255, 255, 255 )
end

function talkLisaS ()
	outputChatBox ( "Лиза Симпсон: Какой-же он красавчик!", 255, 255, 255 )
end

function talkLuuk ()
	outputChatBox ( "Люк Скайуокер: Дельные вещи этот мужик говорит", 255, 255, 255 )
end

function talkEdem ()
	outputChatBox ( "Джон Генри Эдем: Мы сделаем Кламат ведущим поселением", 255, 255, 255 )
end

function talkJer ()
	mayor_talk_KL ()
end

function talkPoul ()
	jer_talk_KL ()
end

function talkChackD ()
	cdan_talk_KL ()
end

function talkBakD ()
	bdan_talk_KL ()
end

function talkRight ()
	local quest = getElementData ( localPlayer, "quest_prob" )
	if quest == 0 then
		right_s_KL ()
	elseif quest == 3 then
		right_med_KL ()
	elseif quest == 5 then
		right_fin_KL ()
	elseif quest == 6 or quest == 7 then
		outputChatBox ( "Боб Райт: Как же я обожаю устрицы и мертвых Великих Ханов!", 255,255,255 )
	else
		outputChatBox ( "Боб Райт: Приходи, как выполнишь мое задание", 255,255,255 )
	end
end

function talkSyag ()
	syag_talk_KL ()
end

function talkPerkins ()
	perk_talk_RC()
end


function talkGorbov ()
	gorbov_talk_RC()
end

function talkVera ()
	vera_talk_RC()
end

function talkMehRC ()
	if getElementData ( localPlayer, "quest_meh" ) == 0 then
		meh_gen_start_RC ()
	elseif getElementData ( localPlayer, "quest_meh" ) == 7 then
		meh_finish_RC ()
	elseif getElementData ( localPlayer, "quest_meh" ) == 8 then
		outputChatBox ( "Механик: Спасибо, что хоть пытался помочь" )
	else
		meh_gen_if_RC ()
	end
end

function talkBenny ()
	benny_talk_Meh ()
end

function talkBonny ()
	bonny_talk_RC ()
end

function talkGun ()
	gun_talk_RC ()
end

function talkSlimFatsy ()
	fatsy_talk_RC ()
end

function talkWilks ()
	wilks_talk_RC()
end

function talkPreston () 
	praston_talk_RC()
end

function talkRobert ()
	if getElementData ( localPlayer, "quest_robert" ) == 0 then
		robert_quest_start()
	elseif getElementData ( localPlayer, "quest_robert" ) == 2 and exports.inventory:getPlayerItemByID ( 92 ) then
		robert_craft_disassembld()
	elseif getElementData ( localPlayer, "quest_robert" ) == 4 then
		local glass = exports.inventory:getItemAmount (90)
		if glass > 0 then
			robert_craft_finish_done()
		else
			robert_craft_finish_start ()		
		end
	elseif getElementData ( localPlayer, "quest_robert" ) == 6 then
		local glass = exports.inventory:getItemAmount (90)
		if glass > 0 then
			robert_craft_finish_done()
		else
			outputChatBox ( 'Роберт Мэйфлауэр: Приходите, когда у вас будут новые очки.', 255, 255, 255 )
			return true
		end
	elseif getElementData ( localPlayer, "quest_robert" ) < 6 then
		outputChatBox ( 'Роберт Мэйфлауэр: Приходите, когда выполните мое поручение.', 255, 255, 255 )
	else
		robert_learning()
	end
end

function talkXzibit ()
	--local shovelID = exports.inventory:getItemAmount (28)
	if getElementData ( localPlayer, "quest_vehicle" ) == 0 then
		if getElementData ( localPlayer, "vehowner" ) then
			xzbt_veh_start_CL()
		else
			xzbt_veh_start_nv_CL()
		end
--	elseif getElementData ( localPlayer, "quest_vehicle" ) == 1 then
	--	xzbt_veh_1st_CL()
	elseif getElementData ( localPlayer, "quest_vehicle" ) == 1 then
		xzbt_veh_vodka_CL()
	elseif getElementData ( localPlayer, "quest_vehicle" ) == 3 then
		local spinach = exports.inventory:getItemAmount (17)
		if spinach > 0 then
			xzbt_veh_v_yes_CL()
		else
			xzbt_veh_v_no_CL()
		end
	else
		xzbt_talk_NV()
	end
end

function talkBarmanNV ()
	if getElementData ( localPlayer, "quest_findtp" ) == 0 then
		barman_find_start_NV()
	elseif getElementData ( localPlayer, "quest_findtp" ) == 3 then
		barman_find_finish_NV()
	else
		barman_talk_NV()
	end
end

function talkDoc()
	doc_submarine_talk()
end

function talkBobbyTP ()
	if getElementData ( localPlayer, "quest_findtp" ) == 1 or getElementData ( localPlayer, "quest_findtp" ) == 2 then
		bobby_find_TP ()
	else
		bobby_talk_TP ()
	end
end

function talkMatsy ()
	matsy_talk_TP ()
end

function talkFreman ()
	local coins = exports.inventory:getItemAmount (21)
	if getElementData ( localPlayer, "quest_coins" ) == 0 and getElementData ( localPlayer, "quest_findtp" ) == 1 then
		freeman_find_and_coins_TP ()
		return true
	end
	if getElementData ( localPlayer, "quest_coins" ) == 0 then
		freeman_coins_TP ()
		return true
	end
	if getElementData ( localPlayer, "quest_findtp" ) == 1 then
		freeman_find_TP ()
		return true
	end
	if getElementData ( localPlayer, "quest_meh" ) == 1 then
		freeman_meh_TP ()
		return true
	end
	if coins > 1 then
		freeman_coins_sell_TP ()
		return true 
	end
	freeman_talk_TP ()
end

function talkSecretary ()	
	local quest_main_st = getElementData (localPlayer, "quest_main_st" )
	local quest_main = getElementData (localPlayer, "quest_main" )
	if quest_main_st == 1 and quest_main == 1 then
		secr_start_Main_Q ()
		return true
	elseif quest_main_st == 2 and quest_main == 2 then
		secr_finish_first_Main_Q ()
		return true
	elseif quest_main_st == 6 and quest_main < 3 then
		secr_drunk_start_Main_Q ()
		return true
	elseif quest_main_st == 6 and quest_main == 3 and getElementData ( localPlayer, "Zombie kills" ) > 49 then
		secr_zkilled_start_Main_Q ()
		return true
	else
		outputChatBox ("Эми Макдональд: Извини, у меня дел по горло, если ты понимаешь о чем я говорю", 255,255,255 )
	end
end

function talkPopeye ()	
	local quest_main_st = getElementData (localPlayer, "quest_main_st" )
	local quest_main = getElementData (localPlayer, "quest_main" )
	if quest_main_st == 7 and quest_main == 1 then
		popeye_start_Main_Q ()
		return true
	elseif quest_main_st == 11 and quest_main == 1 then
		pop_uf_start_Main_Q ()
		return true
	else
		outputChatBox ("Моряк Попай: Ешь шпинат.", 255,255,255 )
	end
end

function talkComradeSU ()	
	local quest_main_st = getElementData (localPlayer, "quest_main_st" )
	local quest_main = getElementData (localPlayer, "quest_main" )
	if quest_main_st == 7 and quest_main == 2 then
		comrade_start_Main_Q ()
		return true
	elseif quest_main_st == 8 and quest_main == 6 then
		comrade_indiana_Main_Q ()
		return true
	elseif quest_main_st == 9 and quest_main == 1 and getElementData ( localPlayer, "totalbunks" ) > 7 then
		comrade_destroy_b_Main_Q ()
		return true
	elseif quest_main_st == 10 and quest_main == 1 then
		comrade_sat_quest_Main_Q ()
		return true
	else
		comrade_talk_SU ()
	end
end

function talkMinet ()
	local quest_main_st = getElementData (localPlayer, "quest_main_st" )
	local quest_main = getElementData (localPlayer, "quest_main" )
	if quest_main_st == 8 and quest_main == 1 then
		minet_start_Main_Q ()
		return true
	elseif quest_main_st == 8 and quest_main == 2 then
		if getElementData ( localPlayer, "onmission" ) == false then
			minet_restart_q8s1 ()
			return true
		end
	elseif quest_main_st == 8 and quest_main == 3 then
		minet_start2_Main_Q ()
		return true
	elseif quest_main_st == 8 and quest_main == 4 then
		if getElementData ( localPlayer, "onmission" ) == false then
			minet_restart_q8s2 ()
			return true
		end
	elseif quest_main_st == 8 and quest_main == 5 then
		minet_finish_Main_Q ()
		return true
	else
		outputChatBox ("Катерина Минет: Проходите мимо, гражданин.", 255,255,255 )
	end
end

function talkMayorNV ()
	local quest_main_st = getElementData (localPlayer, "quest_main_st" )
	local quest_main = getElementData (localPlayer, "quest_main" )
	if quest_main_st == 11 and quest_main == 2 then
		mayor_start_Main_Q ()
		return true
	else
		outputChatBox ("Сэм Смит: Я занят.", 255,255,255 )
	end
end

function talkFool()
	local quest = getElementData (localPlayer, "quest_nvinsane" )
	if quest == 0 then
		nv_Insane_Q ()
	elseif quest == 3 then
		nv_fin_Insane_Q ()
	elseif quest == 4 then
		outputChatBox ("Чудак: Яяя ууууедууу из гооороодаа в блиижайшеее врееемяяя", 255,255,255 )		
	else
		outputChatBox ("Чудак: Яяя будууу ждать тебя у большого кааамня в полдееень!", 255,255,255 )		
	end
end


function talkBigBill ()
	big_bill_Main_Q ()
end

function talkKatyPerry ()
	katy_perry_Main_Q ()
end

function talkStanMarsh ()
	stan_marsh_Main_Q ()
end

function talkLuisSuarez ()
	luis_suarez_Main_Q ()
end

function talkMehSoldier()
	meh_nv_Soldiers_Q ()
end

function talkDylan()
	if getElementData ( localPlayer, "detective_quest" ) == 4 then
		dylan_first_done_Carn_Q ()
	else	
		dylan_Carn_Q ()
	end
end

function talkRobbins()
	if getElementData ( localPlayer, "quest_meh" ) == 2 then
		rob_meh_Carn_Q ()
	else
		rob_Carn_Q ()
	end
end

function talkCash()
	if getElementData ( localPlayer, "quest_meh" ) == 4 then
		cash_meh_Carn_Q ()
	elseif getElementData ( localPlayer, "quest_meh" ) == 6 then
		cash_shet_Carn_Q ()
	else
		cash_Carn_Q ()
	end
end

function talkJohnPochatok ()
	if getElementData (localPlayer, "quest_main" ) == 0 then
		start_Main_Q ()
		return true
	else
		poch_edu_other_start ()
	end
end

controllingPeds = {}

function sendPedsToPlayersC ( nv_insane )
	--outputChatBox ( "2" )
	local xp, xy, xz = getElementPosition ( nv_insane )
	nv_insane_text = exports.dtext:create3DText ( xp, xy, xz+1.5, "Чудак", 255, 255, 255, 255, "nvp" )
	setTimer ( update3DTexts, 50, 0 )
	controllingPeds = {
		nv_insane,
	}
end
addEvent( "sendPedsToPlayers", true )
addEventHandler( "sendPedsToPlayers", getRootElement(), sendPedsToPlayersC )

function update3DTexts ( )
	local xp, xy, xz = getElementPosition ( controllingPeds[1] )
	setElementPosition ( nv_insane_text, xp, xy, xz+1.5 )
end

function playerToPointClient( radius, x, y, z )
    if radius and x and y and z then
        return getDistanceBetweenPoints3D( x, y, z, getElementPosition( localPlayer ) ) <= radius
    end
    return false
end
