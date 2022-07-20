-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

--creating a variable to keep track of amount of taps
local tapCount = 0

-- an iomage API that has the ability to resize and scale the image 
local background = display.newImageRect( "background.png", 360, 570 )
--placing the background in the center of the screen
--The default position within solar 2D is 0,0 (the uper left corner )
background.x = display.contentCenterX
background.y = display.contentCenterY

--displaying the amouunt of balloon taps
--newText an API that creates a text object 
local tapText = display.newText( tapCount, display.contentCenterX, 20, native.systemFont, 40)
--changing the colour of the count text
tapText:setFillColor( 0, 0, 0 )

--loading the platform 
local platform =display.newImageRect( "platform.png", 300, 50 )
platform.x = display.contentCenterX
platform.y = display.contentHeight-25

--loading balloon
local balloon = display.newImageRect( "balloon.png", 112, 112)
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
-- reducing the opacity of the ballon
balloon.alpha = 0.8

--adding physics using Box2D
-- loading Box2D into app
local physics = require( "physics" )
--starting the physics 
physics.start()
-- adding a physical "body" to paltform variable and than telling to treat as a static image( isnt affected by gravity or other physcical forces)
physics.addBody( platform, "static" )
-- dynmaic object, affected by gravity and will respond to collisions 
physics.addBody( balloon, "dynamic" , { radius=50 , bounce=0.3 } )

--using function to be able to interact with the balloon
local function pushBalloon()
  -- applys a "push" to the object in any direction
  -- the two parameters unducate the amount of direction force that will be applied the first number is the x and the seconds is the y
  balloon:applyLinearImpulse( 0 , -0.75, balloon.x, balloon.y )
  tapCount = tapCount + 1
  tapText.text = tapCount
end

--using events to create interactivity
balloon:addEventListener( "tap", pushBalloon )