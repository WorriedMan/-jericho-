addEventHandler("onClientResourceStart", resourceRoot,
    function()
        myShader,tecName = dxCreateShader( "clientshader.fx" )
        myImage = dxCreateTexture( "hurry.png" )
        if myShader and myImage then
            dxSetShaderValue( myShader, "tex0", myImage )
			-- engineApplyShaderToWorldTexture( myShader, "dt_road*" )
			-- engineApplyShaderToWorldTexture( myShader, "newtreeleaves*" )
			-- engineApplyShaderToWorldTexture( myShader, "pinelo*" )
			-- engineApplyShaderToWorldTexture( myShader, "planta*" )
			-- engineApplyShaderToWorldTexture( myShader, "newtreed256*" )
			-- engineApplyShaderToWorldTexture( myShader, "kb_ivy*" )
			-- engineApplyShaderToWorldTexture( myShader, "sm_pinetreebit*" )
			-- engineApplyShaderToWorldTexture( myShader, "tree*" )
			-- engineApplyShaderToWorldTexture( myShader, "cypress*" )
			-- engineApplyShaderToWorldTexture( myShader, "kbtree4*" )
			-- engineApplyShaderToWorldTexture( myShader, "trunk3*" )
			-- engineApplyShaderToWorldTexture( myShader, "elm_treegrn*" )
			-- engineApplyShaderToWorldTexture( myShader, "cedar*" )
			-- engineApplyShaderToWorldTexture( myShader, "oakleaf*" )
			-- engineApplyShaderToWorldTexture( myShader, "pinebranch*" )
			engineApplyShaderToWorldTexture( myShader, "coral" )
			engineApplyShaderToWorldTexture( myShader, "shad_exp" )
			engineApplyShaderToWorldTexture( myShader, "coronastar" )
			engineApplyShaderToWorldTexture( myShader, "cj_ped_torso" )
		--	engineApplyShaderToWorldTexture( myShader, "bullethitsmoke*" )
	--		engineApplyShaderToWorldTexture( myShader, "monsterb92wheel64", myImage )
            outputChatBox( "Shader using techinque " .. tecName )
        else
            outputChatBox( "Problem - use: debugscript 3" )
        end
    end
)

