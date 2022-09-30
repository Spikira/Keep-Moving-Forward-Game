-- Checkpoint flag
local entity = ...
local game = entity:get_game()
local map = entity:get_map()

function entity:on_created()
  local x, y, layer = entity:get_position()
  entity:add_collision_test("sprite", function(entity_a, entity_b)
    if entity_b:get_type() == "hero" then
      self:get_game():set_suspended()
      self:get_game():add_life(2)
      sol.timer.start(self:get_game(), 250, function()
        self:get_game():set_suspended(false)
      end)
      sol.audio.play_sound("frost")
      map:create_custom_entity({
        name = entity:get_name(),
        x = x,
        y = y,
        layer = layer,
        direction = 1,
        sprite = "entities/"..entity_b:get_tunic_sprite_id(),
      })
      entity:remove()
      game:set_starting_location(map, "check"..entity:get_name())
    end
  end)
end
