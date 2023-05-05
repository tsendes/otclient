-- defining empty variables to be used
clickerButton = nil
clickerControlsWindow = nil
clickBox = nil

-- Initial position for screen as
pos_init={0, 0}

-- Initial configurations for this module
function init()
  connect(g_game, {
    onGameStart = online,
    onGameEnd = offline,
  })
  clickerControlsWindow = g_ui.displayUI('clicker', modules.game_interface.getRightPanel())
  clickerButton = clickerControlsWindow:getChildById('clickBox')
  clickerControlsWindow:setOn(true)
  clickerControlsWindow:focus()
  clickerButton:setOn(true)
  
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
  self.random_new_position()
end

-- Goodbye cruel world
function terminate()

  clickerControlsWindow:hide()
  clickerButton:setOn(false)
   -- Free everything then proceed disconnecting this module from game
  clickerButton:destroy()
  clickerControlsWindow:destroy()
  clickBox:destroy()

  disconnect(g_game, {
    onGameStart = online,
    onGameEnd = offline,
  })
  -- Now we're ready to go
end

