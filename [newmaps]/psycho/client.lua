-- Seizure resource by MuLTi --
-- [C]opyright, do not remove credits --

local sound
local textimer
local shader, shader2
local enabled = false
local shaderdoing = {}
local fastdoing = false
local shaderfast = {}
local notallowed = {
	["radardisc"] = false,
	["font1"] = false,
	["fist"] = false,
}

local r, g, b = 0, 0, 0

local add1, add2 = -200, 200
local seizurewarning = false



local function checkTextures()
	for index, tex in pairs(engineGetVisibleTextureNames ()) do
		if(enabled) then
			if(shaderdoing[tex] ~= true) and (notallowed[tex] == nil) then
				shaderdoing[tex] = true
				engineApplyShaderToWorldTexture (shader,tex )
			end
		else
			if(shaderdoing[tex] == true) then
				shaderdoing[tex] = false
				engineRemoveShaderFromWorldTexture(shader,tex )
				if(shaderfast[tex] == true) then
					shaderfast[tex] = false
					engineRemoveShaderFromWorldTexture(shader2,tex )
				end
			end
		end
	end
end

local function setFast()
	if(enabled) then
		for index, tex in pairs(engineGetVisibleTextureNames ()) do
			if(shaderdoing[tex] == true) and(shaderfast[tex] ~= true) then
				shaderfast[tex] = true
				engineApplyShaderToWorldTexture (shader2,tex )
			end
		end
	end
end

local function setLow()
	if(enabled) then
		for index, tex in pairs(engineGetVisibleTextureNames ()) do
			if(shaderdoing[tex] == true) and(shaderfast[tex] == true) then
				shaderfast[tex] = false
				engineRemoveShaderFromWorldTexture(shader2,tex )
			end
		end
	end
end

local function toggleSeizure3()
	local shit = 6440
	setTimer(setFast, 6500-shit, 1)
	setTimer(setLow, 8000-shit, 1)
	setTimer(setFast, 9000-shit, 1)
	setTimer(setLow, 10000-shit, 1)
	setTimer(setFast, 11000-shit, 1)
	setTimer(setLow, 12000-shit, 1)
	setTimer(setFast, 13000-shit, 1)
	setTimer(setLow, 14000-shit, 1)
	add1, add2 = -400, 400
	setTimer(function() add1, add2 = -200, 200 end, 14000-shit, 1)
end

local function toggleSeizure1()
	local add = 500
	setFast()
	setTimer(setLow, add, 1)
	add = add+500
	setTimer(setFast, add, 1)
	add = add+500
	setTimer(setLow, add, 1)
	add = add+500
	setTimer(setFast, add, 1)
	add = add+500
	setTimer(setLow, add, 1)
	add = add+500
	setTimer(setFast, add, 1)
	add = add+500
	setTimer(setLow, add, 1)
	add1, add2 = -400, 400
	setTimer(function() add1, add2 = -200, 200 end, add, 1)
end

addEventHandler("onClientResourceStart", getResourceRootElement(), function()	
	-- Seizure Warning - DO NOT REMOVE!!!! THIS IS NOT FUNNY! --
	seizurewarning = true
	setTimer(function()
		sound = playSound("song.mp3", false)
		shader = dxCreateShader ( "shader.fx" )
		shader2 = dxCreateShader ( "shader2.fx" )
		if not(shader) or not(shader2) then outputChatBox("Can't create shader!") return end
		setTimer(function()
			setSoundPosition ( sound, 15 )
			setTimer(function()
				setSoundPosition ( sound, 15 )
				setTimer(toggleSeizure3, 8000, 1)
				setTimer(setFast, 1000, 1)
				setTimer(setFast, 1000, 1)
			end, 31000-15000, 0)
		end, 31000, 1)
		textimer = setTimer(checkTextures, 1000, 0)
		setTimer(toggleSeizure3, 6500, 1)
		setTimer(toggleSeizure1, 15000, 1)
		setTimer(toggleSeizure3, 22000, 1)
		seizurewarning = false
		enabled = true
	end, 5000, 1)
end)

addCommandHandler("seizure", function()
	enabled = not enabled
	if(enabled) then
		setSoundVolume(sound, 1)
	else
		setSoundVolume(sound, 0)
	end
end)


setTimer(function()
	if(r == 0) then
		r, g, b = 255, 255, 255
	else
		r, g, b = 0, 0, 0 
	end
end, 50, 0)

addEventHandler("onClientRender", getRootElement(), function()
	if(enabled == true) then
		local sx, sy = guiGetScreenSize()
		sx, sy = sx/2-300, sy/2-350
		local rand = math.random(0, 1)
		if(rand == 0) then
			dxDrawImage(sx+math.random(add1, add2), sy+math.random(add1, add2), 600, 150, "logo.png", 0, 0, 0, tocolor(r, g, b, 200))
		else
			dxDrawImage(sx-math.random(add1, add2), sy-math.random(add1, add2), 600, 150, "logo.png", 0, 0, 0, tocolor(r, g, b, 200))
		end
	end
	if(seizurewarning == true) then
		local sx, sy = guiGetScreenSize()
		sx, sy = sx/2-200, sy/2-250
		dxDrawImage(sx, sy, 500, 221, "warning.jpg")
	end
end)