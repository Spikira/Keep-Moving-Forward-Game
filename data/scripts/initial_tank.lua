-- Removes diagonal and backwards movement, also sword loading.
local game = sol.main.get_metatable("game")

function game:on_command_pressed(command)
  if command == "up" then
    if self:is_command_pressed("left") then
      self:simulate_command_released("up")   
    end   
    if self:is_command_pressed("right") then
      self:simulate_command_released("up")   
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