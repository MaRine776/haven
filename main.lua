-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

--[[
if (system.getInfo("environment")=="simulator") then
	require("debugger")()
end
]]--


local storyboard = require "storyboard"

--Player's speed
_SPEED=0.26

--Size of tiles, currently 50, will be set to 64 after new tiles are done
_TILESIZE=64

print("Initialize...")

-- public table containing data for all game scenes and objects
_DATA ={}
setmetatable(_DATA, {__index=nil})
_DATA.player={}
setmetatable(_DATA.player, {__index=nil})

-- TODO constructor, to read from the save file, when it's called (from menu, to support multiple save files)
-- maybe setmetatable() there, to prevent too much data from loading at once, yet that could tax ram too much

-- load main menu
storyboard.gotoScene( "menus.exampleMenu" )

-- handle device events
local function onSystemEvent( event )

    local eventType = event.type
	-- TODO
    if ( eventType == "applicationSuspend" ) then
        --perform all necessary actions for when the device suspends the application, i.e. during a phone call
    elseif ( eventType == "applicationResume" ) then
        --perform all necessary actions for when the app resumes from a suspended state
    end
end

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):

-- render groups
farBackground = display.newGroup()
nearBackground = display.newGroup()
foreground = display.newGroup()
display.setDefault( "textColor", 0, 0, 0 )

if "Win" == system.getInfo( "platformName" ) then
    AT = "Apolonia TT"
elseif "Android" == system.getInfo( "platformName" ) then
    AT = "AT"
end


local myTextObject = display.newText(foreground, "pre-alpha 0.0.5", 0, 0, AT, 45 )

-- event listeners

Runtime:addEventListener( "system", onSystemEvent ) 
