
local width, height = guiGetScreenSize( );
local enable = false;
local keys = { 
	"vehicle_right", "vehicle_left", 
	"vehicle_look_right", "vehicle_look_left",
	"special_control_right", "special_control_left",
	"left", "right",
};

addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource() ),
	function( )
		bindKey( "backspace", "up", enableHorizontalFlip );
	end
)

function renderEffect( )
	dxSetRenderTarget( );
	dxUpdateScreenSource( screenSrc );
	dxDrawImage( 0, 0, width, height, screenShader );
end

function enableHorizontalFlip( )
	enable = not enable;
	if enable then
		screenShader = dxCreateShader( "horizontal_flip.fx" );
		screenSrc = dxCreateScreenSource( width, height );
		if screenShader and screenSrc then
			for _, key in pairs( keys ) do
				bindKey( key, "both", invertedKeys );
				toggleControl( key, false );
			end
			dxSetShaderValue( screenShader, "ScreenTexture", screenSrc );
			addEventHandler( "onClientHUDRender", getRootElement( ), renderEffect );
		end
		
	else
		if screenShader and screenSrc then
			for _, key in pairs( keys ) do
				unbindKey( key, "both", invertedKeys );
				toggleControl( key, true );
			end
			destroyElement( screenShader );
			destroyElement( screenSrc );
			screenShader, screenSrc = nil, nil;
			removeEventHandler( "onClientHUDRender", getRootElement( ), renderEffect );
		end
	end
end

function invertedKeys( key, state )
	local s,e = key:find( "right" ) and key:find( "right" ) or key:find("left" );
	local dir = key:sub( s, e );
	local newkey = key:gsub( dir, ( dir == "right" and "left" or "right" ) );
	local enabledControl = ( state == "down" and true or false )
	setControlState( newkey, enabledControl );
end
