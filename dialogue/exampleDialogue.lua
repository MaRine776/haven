----------------------------------------------------------------------------------
--
-- exampleDialogue.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local lie
local truth
local choice
local done
local bcg, lieButton, truthButton, whiteBcg
local lieText, truthText, responseTextA, responseTextB, responseTextC, responseTextD, responseTextE, responseTextF, responseTextG
local option1textA, option1textB, option1textC, option2textA, option2textB, option2textC, option3textA, option3textB, option3textC, option4textA, option4textB, option4textC, option5textA, option5textB, option5textC

local liePressed, truthPressed

-- internal, cleans list of topics
local function flushTopics()
	option1textA.text=""
	option1textB.text=""
	option1textC.text=""
	option2textA.text=""
	option2textB.text=""
	option2textC.text=""
	option3textA.text=""
	option3textB.text=""
	option3textC.text=""
	option4textA.text=""
	option4textB.text=""
	option4textC.text=""
	option5textA.text=""
	option5textB.text=""
	option5textC.text=""

	print("Topics cleared")
end

-- internal, cleans response text
local function flushResponse()
	responseTextA.text=""
	responseTextB.text=""
	responseTextC.text=""
	responseTextD.text=""
	responseTextE.text=""
	responseTextF.text=""
	responseTextG.text=""
	end

-- used to add a new response depended on player's own choice in updateResponse()
local function addResponse(textA, textB, textC, textD, textE, textF, textG)

	if textA ~= nil then
		responseTextA.text = textA
	end
	
	if textB ~= nil then
		responseTextB.text = textB
	end

	if textC ~= nil then
		responseTextC.text = textC
	end
	
	if textD ~= nil then
		responseTextD.text = textD
	end
	
	if textE ~= nil then
		responseTextE.text = textE
	end
	
	if textF ~= nil then
		responseTextF.text = textF
	end
	
	if textG ~= nil then
		responseTextG.text = textG
	end
	
	print("Response updated to: " .. tostring(textA) .. tostring(textB) .. tostring(textC) .. tostring(textD) .. tostring(textE) .. tostring(textF) .. tostring(textG))
end

-- used to add a new topic in updateTopics(); option is int = 1~5, telling on witch position from top it is displayed
local function addTopic(option, textA, textB, textC)

	if option == 1 then
		
		if textA ~= nil then
			option1textA.text=textA
		end
		
		if textB ~= nil then
			option1textB.text=textB
		end
		
		if textC ~= nil then
			option1textC.text=textC
		end
	
	elseif option == 2 then
	
		if textA ~= nil then
			option2textA.text=textA
		end
		
		if textB ~= nil then
			option2textB.text=textB
		end
		
		if textC ~= nil then
			option2textC.text=textC
		end
	
	elseif option == 3 then
	
		if textA ~= nil then
			option3textA.text=textA
		end
		
		if textB ~= nil then
			option3textB.text=textB
		end
		
		if textC ~= nil then
			option3textC.text=textC
		end
	
	elseif option == 4 then
	
		if textA ~= nil then
			option4textA.text=textA
		end
		
		if textB ~= nil then
			option4textB.text=textB
		end
		
		if textC ~= nil then
			option4textC.text=textC
		end
	
	else
	
		if textA ~= nil then
			option5textA.text=textA
		end
		
		if textB ~= nil then
			option5textB.text=textB
		end
		
		if textC ~= nil then
			option5textC.text=textC
		end
	
	end

	print("Topic " .. option .. " updated to: " .. tostring(textA) .. tostring(textB) .. tostring(textC))

end

-- updates response due to current value of choice, see dialog construction for help (WIP)
local function updateResponse()
	flushResponse()
	--------------------------------------------------------------------------------
	-- Add all dialogue responses below this
	--------------------------------------------------------------------------------

	if choice == 0 then
		addResponse("This is a test")
	
	elseif choice == 1 then
		addResponse("Indeed it is...")
	
	elseif choice == 2 then
		addResponse("No, it isn't, filthy liar")
	
	elseif choice == 3 then
		choice = 0
		addResponse("And who am I to know?")
		
	else
		choice = 0
		addResponse("You? You are in an ephemeral place detached from", "space and time, and You now know that multiple", "lines could really be displayed here.")
	
	end
	
	--------------------------------------------------------------------------------

end

-- updates topics due to current value of choice, see dialog construction for help (WIP)
local function updateTopics()

	flushTopics()
	--------------------------------------------------------------------------------
	-- Add all dialogue topics below this
	--------------------------------------------------------------------------------

	if choice == 0 then
		
		if truth then
			addTopic(1, "It is")
			
		elseif lie then 
			addTopic(1, "It is")
		
		else
			addTopic(1, "Or is it?")
			addTopic(2, "Where am I?")
			
		end
		
	else
		addTopic(1, "[End]")
	
	end

	
	--------------------------------------------------------------------------------
	
	print("Topics updated, lie = " .. tostring(lie) .. ", truth = " .. tostring(truth))

end

-- logic used to change choice due to current choice, option, truth and lie; consult dialog construction before modification (WIP)
local function topicChosen(option)

	--------------------------------------------------------------------------------
	-- Add all dialogue choices below this
	--------------------------------------------------------------------------------

	if choice == 0 then
		
		if truth then
			choice = 1
			
		elseif lie then 
			choice = 2
		
		else
			if option == 1 then
				choice = 3
			
			else
				choice = 4
			
			end
		
		end
	
	else
		--storyboard.gotoScene( storyboard.getPrevious() )
		done=true
		return
	end


	--------------------------------------------------------------------------------

	print("Topic chosen: " .. option)
	updateResponse()
	updateTopics()
end

-- internal listener for lie button
liePressed = function ()

	print("Lie pressed")

	if truth then
		truth = false
		lie = true
		lieButton:removeSelf()
		lieButton=nil
		lieButton=display.newImage(farBackground, "assets/graphics/dialogue/dialoguePressed.png", system.ResourceDirectory, 800, 30)
		lieButton:addEventListener("tap", liePressed)
		lieText:setTextColor(255,255,255)
		truthButton:removeSelf()
		truthButton=nil
		truthButton=display.newImage(farBackground, "assets/graphics/dialogue/dialogueUnpressed.png", system.ResourceDirectory, 1005, 30)
		truthButton:addEventListener("tap", truthPressed)
		truthText:setTextColor(0,0,0)

	elseif lie then
		lie = false
		lieButton:removeSelf()
		lieButton=nil
		lieButton=display.newImage(farBackground, "assets/graphics/dialogue/dialogueUnpressed.png", system.ResourceDirectory, 800, 30)
		lieButton:addEventListener("tap", liePressed)
		lieText:setTextColor(0,0,0)

	else
		lie = true
		lieButton:removeSelf()
		lieButton=nil
		lieButton=display.newImage(farBackground, "assets/graphics/dialogue/dialoguePressed.png", system.ResourceDirectory, 800, 30)
		lieButton:addEventListener("tap", liePressed)
		lieText:setTextColor(255,255,255)

	end

	updateTopics()

end

-- internal listener for truth button
truthPressed = function ()

	print("Truth pressed")

	if lie then
		truth = true
		lie = false
		lieButton:removeSelf()
		lieButton=nil
		lieButton=display.newImage(farBackground, "assets/graphics/dialogue/dialogueUnpressed.png", system.ResourceDirectory, 800, 30)
		lieButton:addEventListener("tap", liePressed)
		lieText:setTextColor(0,0,0)
		truthButton:removeSelf()
		truthButton=nil
		truthButton=display.newImage(farBackground, "assets/graphics/dialogue/dialoguePressed.png", system.ResourceDirectory, 1005, 30)
		truthButton:addEventListener("tap", truthPressed)
		truthText:setTextColor(255,255,255)

	elseif truth then
		truth = false
		truthButton:removeSelf()
		truthButton=nil
		truthButton=display.newImage(farBackground, "assets/graphics/dialogue/dialogueUnpressed.png", system.ResourceDirectory, 1005, 30)
		truthButton:addEventListener("tap", truthPressed)
		truthText:setTextColor(0,0,0)

	else
		truth = true
		truthButton:removeSelf()
		truthButton=nil
		truthButton=display.newImage(farBackground, "assets/graphics/dialogue/dialoguePressed.png", system.ResourceDirectory, 1005, 30)
		truthButton:addEventListener("tap", truthPressed)
		truthText:setTextColor(255,255,255)

	end

	updateTopics()

end

---------------------------------------------------------------------------------
--
-- internal associate functions
--
---------------------------------------------------------------------------------

local function topic1Chosen()
	topicChosen(1)
	
	if done then
		storyboard.gotoScene( storyboard.getPrevious() )
	end
	
end

local function topic2Chosen()
	topicChosen(2)
	
	if done then
		storyboard.gotoScene( storyboard.getPrevious() )
	end
	
end

local function topic3Chosen()
	topicChosen(3)
		
	if done then
		storyboard.gotoScene( storyboard.getPrevious() )
	end
	
end

local function topic4Chosen()
	topicChosen(4)
	
	if done then
		storyboard.gotoScene( storyboard.getPrevious() )
	end
	
end

local function topic5Chosen()
	topicChosen(5)
	
	if done then
		storyboard.gotoScene( storyboard.getPrevious() )
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
	print("Scene created: exampleDialogue")
	local group = self.view

	-----------------------------------------------------------------------------

	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.

	-----------------------------------------------------------------------------

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	print("Scene viewed: exampleDialogue")
	local group = self.view

	-----------------------------------------------------------------------------

	--INSERT code here (e.g. start timers, load audio, start listeners, etc.)

	-----------------------------------------------------------------------------
	
	--TODO Load NPC data from global _DATA, for every real dialogue
	choice=0

	lie=false
	truth=false
	done=false

	-- currently bcg filled white
	-- TODO find a way to display world screen in bcg, or draw a dialogue portrait for every NPC
	-- could be done by combination of backgrounds representing tilesets and some NPC portraits
	-- that would be awesomesauce to pull it off btw
	whiteBcg = display.newRect( farBackground, 0, 0, 1280, 800 )

	bcg = display.newImage(farBackground, "assets/graphics/dialogue/dialogueHUD.png", system.ResourceDirectory, 0, 0)

	lieButton=display.newImage(farBackground, "assets/graphics/dialogue/dialogueUnpressed.png", system.ResourceDirectory, 800, 30)
	lieText= display.newText(nearBackground, "Lie", 890, 70, AT, 45 )
	lieButton:addEventListener("tap", liePressed)

	truthButton=display.newImage(farBackground, "assets/graphics/dialogue/dialogueUnpressed.png", system.ResourceDirectory, 1005, 30)
	truthText= display.newText(nearBackground, "Truth", 1075, 70, AT, 45 )
	truthButton:addEventListener("tap", truthPressed)

	responseTextA= display.newText(nearBackground, "STARTAAAAAAAAZZAZZZZZZZAAAAAZAAAAZZZZ", 80, 540, AT, 30 )
	responseTextA:setTextColor(255,255,255)
	responseTextB= display.newText(nearBackground, "STARTAAAAAAAAZZAZZZZZZZAAAAAZAAAAZZZZ", 80, 570, AT, 30 )
	responseTextB:setTextColor(255,255,255)
	responseTextC= display.newText(nearBackground, "STARTAAAAAAAAZZAZZZZZZZAAAAAZAAAAZZZZ", 80, 600, AT, 30 )
	responseTextC:setTextColor(255,255,255)
	responseTextD= display.newText(nearBackground, "STARTAAAAAAAAZZAZZZZZZZAAAAAZAAAAZZZZ", 80, 630, AT, 30 )
	responseTextD:setTextColor(255,255,255)
	responseTextE= display.newText(nearBackground, "STARTAAAAAAAAZZAZZZZZZZAAAAAZAAAAZZZZ", 80, 660, AT, 30 )
	responseTextE:setTextColor(255,255,255)
	responseTextF= display.newText(nearBackground, "STARTAAAAAAAAZZAZZZZZZZAAAAAZAAAAZZZZ", 80, 690, AT, 30 )
	responseTextF:setTextColor(255,255,255)
	responseTextG= display.newText(nearBackground, "STARTAAAAAAAAZZAZZZZZZZAAAAAZAAAAZZZZ", 80, 720, AT, 30 )
	responseTextG:setTextColor(255,255,255)

	option1textA= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 165, AT, 30 )
	option1textA:setTextColor(255,255,255)
	option1textA:addEventListener("tap", topic1Chosen)
	option1textB= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 195, AT, 30 )
	option1textB:setTextColor(255,255,255)
	option1textB:addEventListener("tap", topic1Chosen)
	option1textC= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 225, AT, 30 )
	option1textC:setTextColor(255,255,255)
	option1textC:addEventListener("tap", topic1Chosen)

	option2textA= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 280, AT, 30 )
	option2textA:setTextColor(255,255,255)
	option2textA:addEventListener("tap", topic2Chosen)
	option2textB= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 310, AT, 30 )
	option2textB:setTextColor(255,255,255)
	option2textB:addEventListener("tap", topic2Chosen)
	option2textC= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 340, AT, 30 )
	option2textC:setTextColor(255,255,255)
	option2textC:addEventListener("tap", topic2Chosen)
	
	option3textA= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 395, AT, 30 )
	option3textA:setTextColor(255,255,255)
	option3textA:addEventListener("tap", topic3Chosen)
	option3textB= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 425, AT, 30 )
	option3textB:setTextColor(255,255,255)
	option3textB:addEventListener("tap", topic3Chosen)
	option3textC= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 455, AT, 30 )
	option3textC:setTextColor(255,255,255)
	option3textC:addEventListener("tap", topic3Chosen)
	
	option4textA= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 510, AT, 30 )
	option4textA:setTextColor(255,255,255)
	option4textA:addEventListener("tap", topic4Chosen)
	option4textB= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 540, AT, 30 )
	option4textB:setTextColor(255,255,255)
	option4textB:addEventListener("tap", topic4Chosen)
	option4textC= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 570, AT, 30 )
	option4textC:setTextColor(255,255,255)
	option4textC:addEventListener("tap", topic4Chosen)
	
	option5textA= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 625, AT, 30 )
	option5textA:setTextColor(255,255,255)
	option5textA:addEventListener("tap", topic5Chosen)
	option5textB= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 655, AT, 30 )
	option5textB:setTextColor(255,255,255)
	option5textB:addEventListener("tap", topic5Chosen)
	option5textC= display.newText(nearBackground, "STARTAAAAAZAZZZZZZAAZ", 850, 685, AT, 30 )
	option5textC:setTextColor(255,255,255)
	option5textC:addEventListener("tap", topic5Chosen)

	updateResponse()
	updateTopics()

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	print("Scene closed: exampleDialogue")
	local group = self.view

	-----------------------------------------------------------------------------

	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

	-----------------------------------------------------------------------------

	choice=nil
	lie=nil
	truth=nil
	done=nil

	truthButton:removeSelf()
	truthButton=nil
	truthText:removeSelf()
	truthText=nil

	lieButton:removeSelf()
	lieButton=nil
	lieText:removeSelf()
	lieText=nil

	bcg:removeSelf()
	bcg=nil
	whiteBcg:removeSelf()
	whiteBcg=nil
	
	responseTextA:removeSelf()
	responseTextA=nil
	responseTextB:removeSelf()
	responseTextB=nil
	responseTextC:removeSelf()
	responseTextC=nil
	responseTextD:removeSelf()
	responseTextD=nil
	responseTextE:removeSelf()
	responseTextE=nil
	responseTextF:removeSelf()
	responseTextF=nil
	responseTextG:removeSelf()
	responseTextG=nil

	option1textA:removeSelf()
	option1textA=nil
	option1textB:removeSelf()
	option1textB=nil
	option1textC:removeSelf()
	option1textC=nil
	
	option2textA:removeSelf()
	option2textA=nil
	option2textB:removeSelf()
	option2textB=nil
	option2textC:removeSelf()
	option2textC=nil
	
	option3textA:removeSelf()
	option3textA=nil
	option3textB:removeSelf()
	option3textB=nil
	option3textC:removeSelf()
	option3textC=nil
	
	option4textA:removeSelf()
	option4textA=nil
	option4textB:removeSelf()
	option4textB=nil
	option4textC:removeSelf()
	option4textC=nil
	
	option5textA:removeSelf()
	option5textA=nil
	option5textB:removeSelf()
	option5textB=nil
	option5textC:removeSelf()
	option5textC=nil

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	print("Scene destroyed: exampleDialogue")
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