
local explosions = {
	"SparksFlash",
	"Sparks7",
	"Sparks6",
	"Sparks5",
	"Sparks4",
	"Sparks3",
	"Sparks2",
	"Sparks",
	"sparkdebris4",
	"sparkdebris3",
	"sparkdebris2",
	"sparkdebris1",
	"Smokesparks3",
	"Smokesparks2",
	"Smokesparks",
	"SmokeEX9",
	"SmokeEX8",
	"SmokeEX7",
	"SmokeEX6",
	"SmokeEX5",
	"SmokeEX4",
	"SmokeEX3",
	"SmokeEX2",
	"SmokeEX",
	"smoke1",
	"smoke2",
	"smoke3",
	"smoke4",
	"smoke5",
	"smoke6",
	"smoke7",
	"smoke8",
	"smoke9",
	"smoke10",
	"smoke11",
	"smoke12",
	"smoke13",
	"smoked1",
	"smoked2",
	"smoked3",
	"smoked4",
	"muzzle1",
	"muzzle2",
	"muzzle3",
	"muzzle4",
	"light1",
	"light2",
	"light3",
	"inferno1",
	"inferno2",
	"GunFlash4",
	"GunFlash3",
	"GunFlash2",
	"GunFlash1",
	"fireball1",
	"fireball2",
	"fireball3",
	"fireball4",
	"fireball5",
	"fireball6",
	"fireball7",
	"fireball8",
	"fireball9",
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
	
		for i, v in ipairs ( explosions ) do
			local shader, tecName = dxCreateShader( "clientshader.fx" )
			
			local theShader = dxCreateShader( "material/effect.fx" )
			local theTexture = dxCreateTexture( "material/fireball6.png" )
			dxSetShaderValue(theShader,"gTexture",theTexture)
			engineApplyShaderToWorldTexture(theShader,"fireball6")
			
			local image = dxCreateTexture( v..".png" )
			dxSetShaderValue( shader, "gTexture", image )
			engineApplyShaderToWorldTexture( shader, v )
			--if not shader or not image then
				outputDebugString('loaded '..tostring(v))
			--end
		end
       
			outputDebugString('loadde all')
    end
)

