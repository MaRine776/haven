----------------------------------------------------------------------------------
--
-- exampleLevel.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local playX, playY, dx, dy
local moveTerrainTimer, drawTilesTimer
local pad
local prevTime
local moving
local direction 

-- TODO read player data from global _DATA (done?)
local player = {}
setmetatable(player, {__index = _DATA.player})

local map = {}
setmetatable(map, {__index = nil})

local tile = {}

-- method for tile object, to update coordinates
function tile:coords(x,y)
	self.x=x
	self.y=y
end

local tilemap

-- constructor for tile class (includes tileset declaration per se, eg. graphics chosen;
-- could be changed or moved outside constructor
function tile:new(row, col)
	local object ={}
	setmetatable(object, { __index = tile })
	local type = tilemap[row][col]
	
	if type == 1 or type == -1 then
		object.path="assets/graphics/tiles/tileGrassB.jpg"
		
	else
		object.path="assets/graphics/tiles/tileGrassA.jpg"
		
	end
	
	if type < 1 then
		object.border = true
		
	end
	
	object:coords((col-1)*_TILESIZE-playX,(row-1)*_TILESIZE-playY)
	object.visible=false
	object.image=nil
	
	return object
end

-- displayed map initialization, fills table with new anonymus tile objects
local function initMap()
	print("Map initializing...")
	
	local z = 1
	for i = 1, #tilemap, 1  do
		for j=1, #tilemap[i], 1 do
			map[z]=tile:new(i,j)
			z=z+1
			
		end
	end

	print("Map initialized")
end

-- draws tiles to screen, used also by redrawTiles()
local function drawTiles(dt)

	for i = 1, #map, 1  do
			
		if map[i].image then
			((map[i]).image):removeSelf()
			map[i].image=nil
				
		end
			
		map[i].visable=false
		map[i]:coords(map[i].x-dx*dt,map[i].y-dy*dt)
			
		if map[i].x>-100 and map[i].x<display.viewableContentWidth+100 and map[i].y>-100 and map[i].y<display.viewableContentHeight+100 then
			map[i].image=display.newImage(farBackground, map[i].path, map[i].x*display.contentScaleX, map[i].y*display.contentScaleY, true)
			map[i].image:scale(display.contentScaleX, display.contentScaleY)
			
			map[i].visable=true

		end
	end
	
	print("Map redrawn, scaleX = " .. display.contentScaleX .. ", scaleY = " .. display.contentScaleY)
end

-- checks for collisions and stops all movement involved
local function checkCollision()
	for i = 1, #map, 1  do
		if map[i].border and map[i].visable then
			local midX=(map[i].x+_TILESIZE*0.5)*display.contentScaleX
			local midY=(map[i].y+_TILESIZE*0.5)*display.contentScaleY
			local dist=math.sqrt(math.pow(midX-640,2)+math.pow(midY-400,2))
			
			if dist<=112 then
				print("Collided on x=" .. midX .. " y=" .. midY)

				if math.abs(midX-640)<math.abs(midY-400) then
					if dy~=0 then
						if math.abs(midY-400) < math.abs(midY-400+dy) then
							dy=0
							
						end
					end
				else
					if dx~=0 then
						if math.abs(midX-640) < math.abs(midX-640+dx) then
							dx=0
							
						end
					end
				end
			end
		end
	end
end

-- redraws tiles; distinction made to preserve processing time
local function enterFrame( event )
	local curTime = event.time
	local dt = curTime - prevTime
	prevTime = curTime

	if dx~=0 or dy~=0 then
		checkCollision()
		drawTiles(dt)
	
	end
end

-- clears map
local function disposeTiles()
	for i = 1, #map, 1  do
		if map[i].image then
			((map[i]).image):removeSelf()
			map[i].image=nil
				
		end
	end
end

----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	print("Scene created: exampleLevel")
	local group = self.view

	-----------------------------------------------------------------------------
		
	--	TODO CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
	prevTime=system.getTimer()
	playX=0
	playY=0
	dx=0
	dy=0
	tilemap = { {2,2,1,1,1,2,1,1,1,1,2,2,2,2,2,1,1,1,1,2,2,2,2,2,1,1,2},
				{2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2},
				{2,2,0,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,2},
				{2,2,0,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,2},
				{2,0,0,1,2,2,2,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,2},
				{2,0,1,1,1,2,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,0,2},
				{2,0,1,1,1,2,1,1,1,1,1,2,2,2,1,1,1,1,1,1,1,1,1,1,1,0,2},
				{2,0,1,1,1,2,1,1,1,1,1,1,2,2,1,1,1,1,1,1,1,1,1,1,2,-1,2},
				{2,0,1,1,1,1,1,1,1,1,1,2,2,1,1,1,1,1,1,1,1,1,1,1,1,0,2},
				{2,0,0,0,1,1,1,1,1,1,1,1,2,2,2,1,1,1,1,1,1,1,1,1,1,1,0,2},
				{2,2,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,2},
				{2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
				{2,2,2,2,2,2,2,1,1,1,2,2,2,2,1,1,1,1,1,2,1,2,2,2,1,1,2} }
	
	initMap()
	direction = "down"
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	print("Scene viewed: exampleLevel")
	local group = self.view
	-----------------------------------------------------------------------------
		
	--	TODO INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------

	drawTiles(1)
	local pSx=32*display.contentScaleX
	local pSy=32*display.contentScaleY
	
	player.image = display.newImage(nearBackground, "assets/graphics/sprites/player.png", 640-pSx, 400-pSy, true)
	player.image:scale(display.contentScaleX, display.contentScaleY)
	
	pad = display.newImage(foreground, "assets/graphics/hud/pad2.png", 896, 144)
	--pad.numTouches=0
	function pad:touch(event)
		local dist=math.sqrt(math.pow(event.x-1152,2)+math.pow(event.y-400,2))
		print("Event " .. event.name .. " phase: " .. event.phase .. " distance: " .. dist)

		if dist<=128 and (event.phase=="began" or event.phase=="moved" ) then
			if dist<25 then
				dx=0
				dy=0
				moving=false
				
			else
				local deltaX, deltaY
				deltaX=(event.x-1152)
				deltaY=(event.y-400)
				if math.abs(deltaX) <= 17 then
					dx=0
					
				else
					dx=2*0.008*deltaX*_SPEED
					moving=true
					
				end
				if math.abs(deltaY) <= 17 then
					dy=0
					
				else
					dy=2*0.008*deltaY*_SPEED
					moving=true
					
				end
				print("Event resolved: deltaX=" .. deltaX .. " deltaY=" .. deltaY)
			end
		
		elseif dist>128 or event.phase=="ended" or event.phase=="cancelled" then
			dx=0
			dy=0
			moving=false
		
		end		
	end
	pad:addEventListener( "touch", pad )
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	print("Scene closed: exampleLevel")
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	TODO INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	
	player.image:removeSelf()
	player.image=nil
	
	pad:removeSelf()
	pad=nil
	
	physics.stop()
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	print("Scene destroyed: exampleLevel")
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	TODO INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	
	disposeTiles()
	
	map=nil
	playX=nil
 	playY=nil
	dx=nil
	dy=nil
	tile=nil
	tilemap=nil
	
end

Runtime:addEventListener( "enterFrame", enterFrame )

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene