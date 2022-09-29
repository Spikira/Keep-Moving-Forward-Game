-- Checkpoint flag
local entity = ...
local game = entity:get_game()
local map = entity:get_map()

function entity:on_created()
  local x, y, layer = entity:get_position()
  local destination = map:create_destination({
    name = entity:get_name(),
    x = x,
    y = y,
    layer = layer,
    direction = 1,
  })
  entity:add_collision_test("sprite", function(entity_a, entity_b)
    if entity_b:get_type() == "hero" then
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
      game:set_starting_location(map, destination)
    end
  end)
end
