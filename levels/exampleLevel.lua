----------------------------------------------------------------------------------
--
-- exampleLevel.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local playX, playY, dx, dy
local moveTimer
local pad

local map = {}
setmetatable(map, {__index = nil})

local tile = {}

function tile:coords(x,y)
	self.x=x
	self.y=y
end

local tilemap

function tile:new(row, col)
	local object ={}
	setmetatable(object, { __index = tile })
	local type = tilemap[row][col]
	
	if type == 1 then
		object.path="assets/graphics/tiles/tileGrassB.jpg"
		
	else
		object.path="assets/graphics/tiles/tileGrassA.jpg"
		
	end
	
	object:coords((col-1)*50-playX,(row-1)*50-playY)
	object.visible=false
	object.image=nil
	
	return object
end

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

local function drawTiles()
	for i = 1, #map, 1  do
			
		if map[i].image then
			((map[i]).image):removeSelf()
			map[i].image=nil
				
		end
			
		map[i]:coords(map[i].x-dx,map[i].y-dy)
			
		if map[i].x>-100 and map[i].x<1400 and map[i].y>-100 and map[i].y<900 then
			map[i].image=display.newImage(farBackground, map[i].path, map[i].x*display.contentScaleX, map[i].y*display.contentScaleY, true)
			map[i].image:scale(display.contentScaleX, display.contentScaleY)
			
		end
	end
	
	print("Map redrawn, scaleX = " .. display.contentScaleX .. ", scaleY = " .. display.contentScaleY)
end

local function redrawTiles()
	if dx~=0 or dy~=0 then
		drawTiles()
		
	end
end

local function disposeTiles()
	for i = 1, #map, 1  do
		if map[i].image then
			((map[i]).image):removeSelf()
			map[i].image=nil
				
		end
	end
end

local function updateV(event)
		if event.x>1024 and event.x<1280 and event.y>272 and event.y<536 then
			if event.x>1024 and event.x<1088 then
				dx=-2*_SPEED
				
			elseif event.x>=1088 and event.x<1152 then
				dx=-_SPEED
				
			elseif event.x>=1152 and event.x<1216 then
				dx=_SPEED
				
			elseif event.x>=1216 and event.x<1280 then
				dx=2*_SPEED
	
			end
			if event.y>272 and event.y<336 then
				dy=-2*_SPEED
				
			elseif event.y>=336 and event.y<400 then
				dy=-_SPEED
				
			elseif event.y>=400 and event.y<464 then
				dy=_SPEED
				
			elseif event.y>=464 and event.y<536 then
				dy=2*_SPEED
				
			end
			if dx~=0 and dy~=0 then
				dx=dx*0.71
				dy=dy*0.71
				
			end
			
		else
			dx=0
			dy=0
		
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
	playX=0
	playY=0
	dx=0
	dy=0
	tilemap = { {1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
				{1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
				{1,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
				{1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
				{1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
				{1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
				{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
				{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
				{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1} }
	
	initMap()
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	print("Scene viewed: exampleLevel")
	local group = self.view
	
	-----------------------------------------------------------------------------
		
	--	TODO INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------

	drawTiles()
	moveTimer = timer.performWithDelay( 10, redrawTiles, 0)
	
	pad = display.newImage(nearBackground, "assets/graphics/hud/pad.png", 1024, 272)
	--pad.numTouches=0
	function pad:touch(event)
		
		if event.phase=="began" then
			print("Event " .. event.name .. " begun")
			updateV(event)
			
		elseif event.phase=="moved" then
			print("Event " .. event.name .. " moved")
			if event.x>1028 and event.x<1276 and event.y>274 and event.y<514 then
				updateV(event)
			else
				print("Event " .. event.name .. " moved outside controller")
				dx=0
				dy=0
			
			end
		
		elseif event.phase=="ended" or event.phase=="cancelled" then
			print("Event " .. event.name .. " ended")
			dx=0
			dy=0
		
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
	
	pad:removeSelf()
	pad=nil
	
	disposeTiles()
	
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	print("Scene destroyed: exampleLevel")
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	TODO INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	
	map=nil
	playX=nil
 	playY=nil
	dx=nil
	dy=nil
	tile=nil
	tilemap=nil
	
end


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