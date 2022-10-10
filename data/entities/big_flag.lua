-- BIG FLAG, kinda like a goal ring
local entity = ...
local game = entity:get_game()
local map = entity:get_map()

function entity:on_created()
  local x, y, layer = entity:get_position()
  entity:add_collision_test("sprite", function(entity_a, entity_b)
    if entity_b:get_type() == "hero" then
      sol.audio.play_sound("victory")
      map:create_custom_entity({
        name = entity:get_name(),
        x = x,
        y = y,
        width = 16,
        height = 16,
        layer = layer,
        direction = 1,
        sprite = "entities/flag/"..entity_b:get_tunic_sprite_id(),
      })
      entity:remove()
    end
  end)
end
