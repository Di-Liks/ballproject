---------------------------------------------------------------------------
-- This file is the main node wich bind and handle project functionality --
---------------------------------------------------------------------------
-- TODO: add audio
-- TODO: add create records.txt file with value 0 if this file does not exist (in function entryPoint())
-- TODO: add particles and green shade on the background for more beautifull gaming process
-- NOTE: maybe we should add listeners for pause and continue game for leave application event

local Main = {}
local GameScene = require "Game";
local RecordScreen = require "HUD.NewRecord";
local GameOverScreen = require "HUD.GameOver";
local WelcomeScreen = require "Screens.Welcome";


--- Variables
local record = 0;
local record_filepath = system.pathForFile("record.txt", system.DocumentsDirectory);


--- Local executable
local function entryPoint()
  local file, error_string = io.open(record_filepath, "r")
  if not file then
      assert(nil, "File error: " .. error_string);
  else
    -- read record
    record = file:read("*n");
    io.close(file);

    -- say hello
    WelcomeScreen.sayHello();

    -- > start particles
    -- > start background shade animation
  end
  file = nil;
end
entryPoint();


--- Functions for external calls
function Main.gameOver(score)
  -- force scene to show results screen and stop game
  GameScene.pause();
  if score > record then
    RecordScreen.show(record);
  else
    GameOverScreen.show(record);
  end

  -- save record
  local file, error_string = io.open(record_filepath, "w");
  if not file then
      assert(nil, "File error: " .. error_string);
  else
    file:write(tostring(record));
    io.close(file);
  end
  file = nil;
end

function Main.restratGame()
  GameScene.restart();
end

function Main.showGame()
  GameScene.show();
end

return Main;
