----------------------------------------------------------------------------------
--
-- exampleMenu.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local buttonS, textS, buttonD, textD, buttonB, textB, bcg, buttonDe, textDe, buttonE, textE

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
	print("Scene created: exampleMenu")
	local group = self.view

	-----------------------------------------------------------------------------

	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.

	-----------------------------------------------------------------------------

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	print("Scene viewed: exampleMenu")
	local group = self.view

	-----------------------------------------------------------------------------

	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)

	-----------------------------------------------------------------------------

	local function startTap( event )
		print( "object tapped = "..tostring(event.target) )
		storyboard.gotoScene( "levels.exampleLevel" )
	end

	local function dialogueTap( event )
		print( "object tapped = "..tostring(event.target) )
		storyboard.gotoScene( "dialogue.exampleDialogue" )
	end

	local function battleTap( event )
		print( "object tapped = "..tostring(event.target) )
		storyboard.gotoScene( "battle.exampleBattle" )
	end

	local function debugTap( event )
		print( "object tapped = "..tostring(event.target) )

	end

	local function exitTap( event )
		print( "object tapped = "..tostring(event.target) )
		os.exit()
	end
	
	

	bcg = display.newImage(nearBackground, "assets/graphics/menus/menuBack.jpg", system.ResourceDirectory, 0, 0)

	buttonS = display.newImage(nearBackground, "assets/graphics/menus/menuButton2.png", system.ResourceDirectory, 512, 44)
	textS = display.newText(nearBackground, "Start", 595, 80, AT, 45 )
	buttonS:addEventListener("tap",startTap)

	buttonD = display.newImage(nearBackground, "assets/graphics/menus/menuButton2.png", system.ResourceDirectory, 512, 172)
	textD = display.newText(nearBackground, "Dialogue", 550, 210, AT, 45 )
	buttonD:addEventListener("tap",dialogueTap)

	buttonB = display.newImage(nearBackground, "assets/graphics/menus/menuButton2.png", system.ResourceDirectory, 512, 300)
	textB = display.newText(nearBackground, "Battle", 580, 338, AT, 45 )
	buttonB:addEventListener("tap",battleTap)

	buttonDe = display.newImage(nearBackground, "assets/graphics/menus/menuButton2.png", system.ResourceDirectory, 512, 428)
	textDe = display.newText(nearBackground, "Debug", 575, 466, AT, 45 )
	buttonDe:addEventListener("tap",debugTap)

	buttonE = display.newImage(nearBackground, "assets/graphics/menus/menuButton2.png", system.ResourceDirectory, 512, 556)
	textE = display.newText(nearBackground, "Exit", 600, 590, AT, 45 )
	buttonE:addEventListener("tap",exitTap)



end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	print("Scene closed: exampleMenu")
	local group = self.view

	-----------------------------------------------------------------------------

	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

	-----------------------------------------------------------------------------

	buttonS:removeSelf()
	buttonS=nil
	textS:removeSelf()
	textS=nil

	buttonD:removeSelf()
	buttonD=nil
	textD:removeSelf()
	textD=nil
	
	buttonB:removeSelf()
	buttonB=nil
	textB:removeSelf()
	textB=nil
	
	buttonDe:removeSelf()
	buttonDe=nil
	textDe:removeSelf()
	textDe=nil
	
	buttonE:removeSelf()
	buttonE=nil
	textE:removeSelf()
	textE=nil
	
	bcg:removeSelf()
	bcg=nil

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	print("Scene destroyed: exampleMenu")
	local group = self.view

	-----------------------------------------------------------------------------

	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)

	-----------------------------------------------------------------------------

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