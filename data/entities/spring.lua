-- boing!! (idea by magnus, thx!)
local entity = ...
local game = entity:get_game()
local map = entity:get_map()

local sprite = entity:get_sprite()

function entity:on_created()
  entity:add_collision_test("sprite", function(entity_a, entity_b)
    if entity_b:get_type() == "hero" then
      local x, y, layer = entity_b:get_position()
      entity_b:set_position(x, y + 88, layer)
      sprite:set_animation("spring", function()
        sprite:set_animation("stopped")
      end)
    end
  end)
end
