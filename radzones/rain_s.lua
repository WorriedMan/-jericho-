local rainCloudsCFG = {
	{ x = 195, y = 1913, radius = 500, still = true },
	{ x = 1694, y = -729.4404296875, radius = 500 },
	{ x = 850, y = -1401, radius = 600 },
	{ x = -240, y = -1397, radius = 500 },
	{ x = -678, y = -2131, radius = 500 },
}

local rainClouds = {}

function createRainClouds ()
	for i, cloud in ipairs ( rainCloudsCFG ) do
		local rainCircle = createColCircle ( cloud.x, cloud.y, cloud.radius )
		setElementData ( rainCircle, 'rainCircle', true )
		setElementData ( rainCircle, 'radius', cloud.radius )
		setElementData ( rainCircle, 'moving', not still )
		table.insert ( rainClouds, rainCircle )
	end
	setTimer ( moveRainClouds, 1800000, 0 )
end

function moveRainClouds ()
	for i, cloud in ipairs ( rainClouds ) do
		if isElement ( cloud ) then
			if getElementData ( cloud, "moving" ) then
				local x, y, z = getElementPosition ( cloud )
				x, y = x+math.random(-10,10), y+math.random(-10,10)
				if x < -3000 or x > 3000 then x, y = 0, 0 end
				if y < -3000 or y > 3000 then x, y = 0, 0 end
				setElementPosition ( cloud, x, y, z )
			end
		else
			table.remove ( rainClouds, i )
		end
	end
end

createRainClouds ()