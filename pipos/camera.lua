local camerasPos = {
	{ -277.4181213378, 1098, 25, -8.8,1098,27, 500, 500, 0 },
	--{ -193, 1002, 29, -191, 1185, 27, 500, 500, 0 },
	{ -1559.2082519531, 497.25, 18, -1559, 1042, 17, 500, 500, 0 },
	--{ 2057.82, 825, 27, 2056, 1649, 25, 500, 500, 0 },
	{ -419.7, 1570.6, 86, -141, 1526, 84, -500, -500, 0 }, 
	{ -1334, 2735, 77, -1550, 2539, 74, 24, 62, -20 },
	{ 2321, -140, 76, 2320, 74, 26, 0,0,0 },
	{ 2349, -1610, 7, 2220, -1559, 3, 0, 0, 0 },
}

local progress = 0
local currentPoses = math.random ( 1, #camerasPos )
local faded = false

function flyCamera()
		progress = progress+0.0002
		if progress > 0.96 and not faded then
			fadeCamera ( false )
			faded = true
		end
		if progress > 0.99 then
			currentPoses = math.random ( 1, #camerasPos )
			fadeCamera ( true )
			progress = 0
			faded = false
			changeX, changeY, changeZ = camerasPos[currentPoses][7], camerasPos[currentPoses][8], camerasPos[currentPoses][9]
			xp, yp, zp, xlat, ylat, zlat = camerasPos[currentPoses][1],camerasPos[currentPoses][2],camerasPos[currentPoses][3],camerasPos[currentPoses][4],camerasPos[currentPoses][5],camerasPos[currentPoses][6]
		end
		local x,y,z = interpolateBetween ( xp, yp, zp, xlat, ylat, zlat, progress, "Linear" )
		local x2,y2,z2 = xlat, ylat, zlat
		if changeX ~= 0 or changeY ~= 0 or changeZ ~= 0 then
			x2,y2,z2 = interpolateBetween ( xlat, ylat, zlat, xlat+changeX, ylat+changeY, zlat+changeZ, progress, "Linear" )
		end
		setCameraMatrix ( x,y,z,x2,y2,z2)
end

function setCameraFly ()
	progress = math.random (0,0.6)
	xp, yp, zp, xlat, ylat, zlat = camerasPos[currentPoses][1],camerasPos[currentPoses][2],camerasPos[currentPoses][3],camerasPos[currentPoses][4],camerasPos[currentPoses][5],camerasPos[currentPoses][6]
	changeX, changeY, changeZ = camerasPos[currentPoses][7], camerasPos[currentPoses][8], camerasPos[currentPoses][9]
	addEventHandler ( "onClientRender", root, flyCamera )
	fadeCamera(true)
end
