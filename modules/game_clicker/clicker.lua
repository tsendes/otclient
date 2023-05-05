-- Defining empty variables to be used as scoped visible
clickerButton = nil
clickerControlsWindow = nil
buttonCancel = nil

-- Initial position for screen as
pos_init={}
movement=1

-- Initial configurations for this module
function init()
  -- Connect with game module
  connect(g_game, {
    onGameStart = online,
    onGameEnd = offline,
  })
  -- Create window
  clickerControlsWindow = g_ui.displayUI('clicker', 
                                         modules.game_interface.getRightPanel())
  -- Create button object gathered from .otui
  clickerButton = clickerControlsWindow:getChildById('clickBox')
  buttonCancel = clickerControlsWindow:getChildById('buttonCancel')
  -- Make it visible
  clickerControlsWindow:setOn(true)
  clickerButton:setOn(true)
  
  -- Set screen focus to this module
  clickerControlsWindow:focus()
  
  -- Load initial x and y coordinates
  table.insert(pos_init, clickerControlsWindow:getX())
  table.insert(pos_init, clickerControlsWindow:getY())

  clickerControlsWindow.onMouseRelease=base_reposition
end

-- Wait a second
function wait(seconds)
  local start = os.time()
  repeat until os.time() > start + seconds
end

--
function moveLeft(time)
  local windowX = clickerControlsWindow:getX()
  local windowY = clickerControlsWindow:getY()
  local buttonX = clickerButton:getX()
  local buttonY = clickerButton:getY()

  while(movement)
  do
    if (buttonX + 30) <= windowX then
      buttonX = windowX + 350
      buttonY -= 30
    end
    if (buttonY + 30) <= windowY then
      buttonY = windowY + 350
    end

    wait(1)
  end
end

-- Random a new position for clickerButton object
function random_new_position()
  -- Defining position structure as {x,y} coordinates
  local new_pos = {
    x=math.random(pos_init[1]+30, pos_init[1]+350),
    y=math.random(pos_init[2]+30, pos_init[2]+350)
  }
  clickerButton:setPosition(new_pos)
end

-- Redefine pos_init after repositioning miniwindow
function base_reposition()
  
  pos_init[1]=clickerControlsWindow:getX()
  pos_init[2]=clickerControlsWindow:getY()
end

-- Goodbye cruel world
function terminate()
  clickerControlsWindow:hide()
  clickerButton:setOn(false)
  -- Disable movement event
  movement=0
   -- Free everything then proceed disconnecting this module from game
  clickerButton:destroy()
  buttonCancel:destroy()
  clickerControlsWindow:destroy()

  disconnect(g_game, {
    onGameStart = online,
    onGameEnd = offline,
  })
  -- Now we're ready to go
end

