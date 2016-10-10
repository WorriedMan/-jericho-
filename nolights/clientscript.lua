addEventHandler("onClientResourceStart", resourceRoot,
    function()
        myShader,tecName = dxCreateShader( "clientshader.fx" )
        myImage = dxCreateTexture( "hurry.png" )
        if myShader and myImage then
            dxSetShaderValue( myShader, "tex0", myImage )
			engineApplyShaderToWorldTexture( myShader, "shad_exp" )
			engineApplyShaderToWorldTexture( myShader, "coronastar" )
            outputChatBox( "Shader using techinque " .. tecName )
        else
            outputChatBox( "Problem - use: debugscript 3" )
        end
    end
)

