-- boing!! (idea by magnus, thx!)
local entity = ...
local game = entity:get_game()
local map = entity:get_map()

local sprite = entity:get_sprite()

function entity:on_created()
  entity:add_collision_test("sprite", function(entity_a, entity_b)
    if entity_b:get_type() == "hero" then
      local x, y, layer = entity_b:get_position()
      for a = 1, 0, 11 do
        if entity_b:test_obstacles(x, y - 88 + (8 * a), layer) == false then
          entity_b:set_position(x, y - 88 + (8 * a), layer)
        else
          a = a + 1
        end
      end
      sprite:set_animation("spring", function()
        sprite:set_animation("stopped")
      end)
    end
  end)
end
