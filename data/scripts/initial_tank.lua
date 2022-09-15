-- Removes diagonal and backwards movement, also sword loading.
local game = sol.main.get_metatable("game")

function game:on_command_pressed(command)
  if command == "up" then
    if self:is_command_pressed("left") then
      self:simulate_command_released("left")   
    end   
    if self:is_command_pressed("right") then
      self:simulate_command_released("right")   
    end
  end
  if command == "down" then
    self:simulate_command_released("down")    
  end
  if command == "left" then
    if self:is_command_pressed("up") then
      self:simulate_command_released("up")   
    end   
  end
  if command == "right" then
    if self:is_command_pressed("up") then
      self:simulate_command_released("up")
    end    
  end
  if command == "attack" then
    self:simulate_command_released("attack")
  end
end

local hero = sol.main.get_metatable("hero")

function hero:on_state_changed(state)
local x, y, layer = self:get_position()
  if state == ("sword swinging") then
    self:get_map():create_custom_entity({
      direction = self:get_direction(),
      x = x,
      y = y - 8,
      layer = layer,
      width = 8,
      height = 8,
      model = "disk"
    })
  end
end

return true