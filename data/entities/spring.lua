-- boing!! (idea by magnus, thx!)
local entity = ...
local game = entity:get_game()
local map = entity:get_map()

local sprite = entity:get_sprite()

function entity:on_created()
  entity:add_collision_test("sprite", function(entity_a, entity_b)
    if entity_b:get_type() == "hero" then
      local m = sol.movement.create("straight")
      m:set_speed(192)
      m:set_smooth(false)
      m:set_max_distance(192)
      m:set_angle(3 * math.pi / 2)
      m:start(entity_b)
      sprite:set_animation("spring", function()
        sprite:set_animation("stopped")
      end)
      function m:on_finished()
        entity_b:unfreeze()
      end
    end
  end)
end
