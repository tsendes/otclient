-- Defining empty variables to be used as scoped visible
clickerButton = nil
clickerControlsWindow = nil
clickBox = nil

-- Initial position for screen as
pos_init={}

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
  -- Make it visible
  clickerControlsWindow:setOn(true)
  clickerButton:setOn(true)
  
  -- Set screen focus to this module
  clickerControlsWindow:focus()
  
  -- Load initial x and y coordinates
  table.insert(pos_init, clickerControlsWindow:getX())
  table.insert(pos_init, clickerControlsWindow:getY())
end

-- Random a new position for clickerButton object
function random_new_position()
  -- Defining position structure as {x,y} coordinates
  local new_pos = {
    x=math.random(pos_init[1]+30,pos_init[1]+350),
    y=math.random(pos_init[2]+30,pos_init[2]+350)
  }
  clickerButton:setPosition(new_pos)
end

-- Redefine pos_init after repositioning miniwindow
function base_reposition()
  pos_init={clickerControlsWindow:getX(),
            clickerControlsWindow:getY()}
  random_new_position()
end

-- Goodbye cruel world
function terminate()
  clickerControlsWindow:hide()
  clickerButton:setOn(false)
   -- Free everything then proceed disconnecting this module from game
  clickerButton:destroy()
  clickBox:destroy()
  clickerControlsWindow:destroy()

  disconnect(g_game, {
    onGameStart = online,
    onGameEnd = offline,
  })
  -- Now we're ready to go
end

