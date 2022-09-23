local item = ...

function item:on_created()

  self:set_shadow("small")
  self:set_can_disappear(true)
  self:set_brandish_when_picked(false)
end

function item:on_obtaining(variant, savegame_variable)
  self:get_game():set_suspended()
  self:get_game():add_life(1)
  sol.timer.start(self:get_game(), 250, function()
    self:get_game():set_suspended(false)
  end)
end
