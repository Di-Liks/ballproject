---------------------------------------------------------------------------
--                               Welcome HUD                             --
---------------------------------------------------------------------------

local WelcomeHUD = {}
local Main = require "main";

--- Functions for external calls
function WelcomeHUD.sayHello()
  local  title = display.newText({
    text = "TOUCH TO PLAY",
    font = "Fonts/Montserrat-Thin.otf",
    fontSize = 93
  });
  title.x = display.contentCenterX;
  title.y = display.contentCenterY;
  title:setFillColor( 0.9, 0.9, 0.9 );
  title.alpha = 0;

  local function onObjectTouched(event)
    if event.phase == "ended" then
      local function onAnimationComplete()
        Main.showGame();
        display.remove( title );
        title = nil;
      end

      -- fade animation
      transition.to(title, {
        time = 700,
        alpha = 0,
        y = display.contentCenterY - 35,
        transition = easing.inOutQuad,
        onComplete = onAnimationComplete
      });

      -- remove listening
      title:removeEventListener("touch", onObjectTouched);
    end
  end

  -- fadeIn animation
  transition.fadeIn(title, {
    time = 1500,
    transition = easing.inOutQuad,
    onComplete = function()
      title:addEventListener("touch", onObjectTouched);
    end
  });
end

return WelcomeHUD;
