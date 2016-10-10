
--[[

    Resource:   bank (written by 50p)
    Version:    2.3
    
    Filename:   bank.gui.client.lua

]]

version = "2.3"

g_localPlayer = getLocalPlayer()
g_root = getRootElement()
local g_this_root = getResourceRootElement( getThisResource() )

local g_editHandlers = { }

addEventHandler( "onClientResourceStart", g_this_root, 
	function( theResource )
	if theResource == getThisResource() then 
			local tempLbl

			bankWnd = guiCreateWindow( 10, 250, 250, 250, "", false )
			guiWindowSetMovable( bankWnd, false )
			guiWindowSetSizable( bankWnd, false )
			
			tempLbl = guiCreateLabel( 0.08, 0.12, 1, 1, "Держатель:", true, bankWnd )
				guiSetFont( tempLbl, "default-bold-small" )
			clientname_lbl = guiCreateLabel( 0.3, 0.12, 0.62, 1, "", true, bankWnd )
			guiLabelSetHorizontalAlign( clientname_lbl, "right" )
			tempLbl = guiCreateLabel( 0.08, 0.24, 1, 1, "Баланс:", true, bankWnd )
				guiSetFont( tempLbl, "default-bold-small" )
			clientbalance_lbl = guiCreateLabel( 0.3, 0.24, 0.62, 1, "", true, bankWnd )
			guiLabelSetColor( clientbalance_lbl, 0, 255, 0 )
			guiLabelSetHorizontalAlign( clientbalance_lbl, "right" )
			
			tabPanel = guiCreateTabPanel( 0, 0.4, 1, 0.46, true, bankWnd )

			withdrawTab = { }
			withdrawTab.tab = guiCreateTab( "Снять", tabPanel )
			withdrawTab.amount_lbl = guiCreateLabel( 0.03, 0.09, 1, 1, "Сумма:", true, withdrawTab.tab )
				guiSetFont( withdrawTab.amount_lbl, "default-bold-small" )
			withdrawTab.amount = guiCreateEdit( 0.28, 0.05, 0.7, 0.25, "", true, withdrawTab.tab )
				guiSetFont( withdrawTab.amount, "default-bold-small" )
				guiEditSetMaxLength( withdrawTab.amount, 8 )
			withdrawTab.button = guiCreateButton( 0.018, 0.71, 0.45, 0.25, "Снять", true, withdrawTab.tab )
				guiSetFont( withdrawTab.button, "default-bold-small" )
			withdrawTab.withdrawall_button = guiCreateButton( 0.498, 0.71, 0.48, 0.25, "Снять все", true, withdrawTab.tab )
				guiSetFont( withdrawTab.withdrawall_button, "default-bold-small" )
				guiSetProperty( withdrawTab.button, "HoverTextColour", "FFFFFF00" )
				guiSetProperty( withdrawTab.withdrawall_button, "HoverTextColour", "FFFFFF00" )
			addEventHandler( "onClientGUIClick", withdrawTab.button, performBankAction )
			addEventHandler( "onClientGUIClick", withdrawTab.withdrawall_button, withdrawAll )
			
			depositTab = { }
			depositTab.tab = guiCreateTab( "Положить", tabPanel )
			depositTab.amount_lbl = guiCreateLabel( 0.03, 0.09, 1, 1, "Сумма:", true, depositTab.tab )
				guiSetFont( depositTab.amount_lbl, "default-bold-small" )
			depositTab.amount = guiCreateEdit( 0.28, 0.05, 0.7, 0.25, "", true, depositTab.tab )
				guiSetFont( depositTab.amount, "default-bold-small" )
				guiEditSetMaxLength( depositTab.amount, 8 )
			depositTab.button = guiCreateButton( 0.018, 0.71, 0.45, 0.25, "Положить", true, depositTab.tab )
				guiSetFont( depositTab.button, "default-bold-small" )
			depositTab.depositall_button = guiCreateButton( 0.498, 0.71, 0.48, 0.25, "Положить все", true, depositTab.tab )
				guiSetFont( depositTab.depositall_button, "default-bold-small" )
				guiSetProperty( depositTab.button, "HoverTextColour", "FF00FF00" )
				guiSetProperty( depositTab.depositall_button, "HoverTextColour", "FF00FF00" )
			addEventHandler( "onClientGUIClick", depositTab.button, performBankAction )
            addEventHandler( "onClientGUIClick", depositTab.depositall_button, depositAll )
				
			tempLbl = guiCreateLabel( .06, .89, .5, .1, "version: "..version, true, bankWnd )
				guiSetFont( tempLbl, "default-bold-small" )
			
			quit_btn = guiCreateButton( 0.5, 0.87, 0.5, 0.2, "Выйти", true, bankWnd )
				guiSetProperty( quit_btn, "HoverTextColour", "FFFF0000" )
				guiSetFont( quit_btn, "default-bold-small" )
			addEventHandler( "onClientGUIClick", quit_btn, 
				function()
                    if source == quit_btn then
                        guiSetVisible( bankWnd, false )
                        guiSetVisible( warningBox, false )
                        showCursor( false )
                        guiSetInputEnabled( false )
                    end
				end
			)
			
			-- hide just created windows
			guiSetVisible( bankWnd, false )
		end
	end
)

function showWarningMessage( message )
	local x, y = guiGetScreenSize()
	if not warningBox then
		warningBox = guiCreateWindow( x*.5-150, y*.5-65, 300, 120, "Ошибка", false )
			guiWindowSetSizable( warningBox, false )
		warningImage = guiCreateStaticImage( 10, 30, 60, 60, ":bank/client/warning.png", false, warningBox )
		--outputChatBox( tostring( warningImage ) );
		warningMessage = guiCreateLabel( 100, 40, 180, 60, "", false, warningBox )
		warningOk = guiCreateButton( 130, 90, 70, 20, "Ок", false, warningBox )
		addEventHandler( "onClientGUIClick", warningOk, function() guiSetVisible( warningBox, false ) end )
	else
		guiSetPosition( warningBox, x*.5-150, y*.5-65, false )
		guiSetVisible( warningBox, true )
	end
	guiSetText( warningMessage, message )
	guiBringToFront( warningBox )
end
addEvent( "bank_showWarningMessage", true )
addEventHandler( "bank_showWarningMessage", g_localPlayer, showWarningMessage )

function performBankAction( )
	local amount = nil
	if source == withdrawTab.button then
		amount = tonumber( guiGetText( withdrawTab.amount ) )
		if amount == nil then
			showWarningMessage( "Введите сумму\nкоторую хотите снять!" )
        elseif amount < 0 then
            showWarningMessage( "Нельзя вводить отрицательные значения!" )
		else
			triggerServerEvent( "bank_withdrawMoney", g_localPlayer, g_localPlayer, amount )
		end
	elseif source == depositTab.button then
		amount = tonumber( guiGetText( depositTab.amount ) )
		if amount == nil then
			showWarningMessage( "Введите сумму\nкоторую хотите положить!" )
        elseif amount < 0 then
            showWarningMessage( "Нельзя вводить отрицательные значения!" )
		else
			triggerServerEvent( "bank_depositMoney", g_localPlayer, g_localPlayer, amount )
		end
	elseif source == transferTab.button then
		local to_who = guiGetText( transferTab.to )
		amount = tonumber( guiGetText( transferTab.amount ) )
		if to_who == nil or to_who == false or to_who == "" then
			showWarningMessage( "Введите ник игрока\nкоторому предназначаются\nденьги!" )
		elseif amount == nil then 
			showWarningMessage( "Введите сумму\nyou want to transfer!" )
        elseif amount < 0 then
            showWarningMessage( "Нельзя вводить отрицательные значения!" )
		else
			local money_receiver = getPlayerFromNick( to_who )
			if money_receiver == g_localPlayer then
				showWarningMessage( "Вы не можете первести деньги\nсебе!" )
			elseif money_receiver ~= g_localPlayer then
				triggerServerEvent( "bank_transferMoney", g_localPlayer, g_localPlayer, money_receiver, amount )
			else
				showWarningMessage( "Игрок \"".. to_who .."\"\nне в сети!" )
			end
		end
	end
end

function show_MyBankAccountWnd( name, money, bankname, bank, atm )
	showCursor( true )
	guiSetText( clientname_lbl, name )
    guiSetText( bankWnd, bankname )
	guiSetText( clientbalance_lbl, "$ " .. tostring( money ) )
	guiSetVisible( bankWnd, true )
	guiBringToFront( bankWnd );
	guiSetInputEnabled( true )
	guiSetEnabled( depositTab.tab, ( ( atm == true ) or ( atm == "true") ) and true or false )
	local r,g,b = getPlayerNametagColor( g_localPlayer )
	if r < 80 and g < 80 and b < 80 then -- if color is too dark, set it to white
		r, g, b = 250, 250, 250
	end
	guiLabelSetColor( clientname_lbl, r, g, b )
end
addEvent( "bank_showBankAccountWnd", true )
addEventHandler( "bank_showBankAccountWnd", g_localPlayer, show_MyBankAccountWnd )

function hide_MyBankAccountWnd( )
	guiSetVisible( bankWnd, false )
	showCursor( false )
	guiSetInputEnabled( false )
end
addEvent( "bank_hideBankAccountWnd", true )
addEventHandler( "bank_hideBankAccountWnd", g_localPlayer, hide_MyBankAccountWnd )

function updateMyBalance( currBalance )
	guiSetText( clientbalance_lbl, "$ "..tostring( currBalance ) )
	--outputDebugString( "Client got the new balance: ".. currBalance );
end
addEvent( "bank_updateMyBalance", true )
addEventHandler( "bank_updateMyBalance", g_localPlayer, updateMyBalance )

function withdrawAll()
    if source == withdrawTab.withdrawall_button then
        triggerServerEvent( "bank_withdrawMoney", g_localPlayer, g_localPlayer, 'all' )
    end
end

function depositAll()
    if source == depositTab.depositall_button then
        triggerServerEvent( "bank_depositMoney", g_localPlayer, g_localPlayer, 'all' )
    end
end

function transferAll()
    if source == transferTab.transferall_button then
    	local to_who = guiGetText( transferTab.to )
    	local amount = tonumber( guiGetText( transferTab.amount ) )
    	if to_who == nil or to_who == false or to_who == "" then
    		showWarningMessage( "Введите ник игрока\nкоторому предназначаются\nденьги!" )
    	else
    		local money_receiver = getPlayerFromNick( to_who )
    		if money_receiver == g_localPlayer then
    			showWarningMessage( "Вы не можете первести деньги\nсебе!" )
    		elseif money_receiver ~= g_localPlayer then
    			triggerServerEvent( "bank_transferMoney", g_localPlayer, g_localPlayer, money_receiver, 'all' )
    		else
    			showWarningMessage( "Игрок \"".. to_who .."\"\nне в сети!" )
    		end
        end
    end
end

