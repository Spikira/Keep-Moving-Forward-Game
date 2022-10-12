-- Lua script of map metal_base/act_2.
-- This script is executed every time the hero enters this map.

-- Feel free to modify the code below.
-- You can add more events and remove the ones you don't need.

-- See the Solarus Lua API documentation:
-- http://www.solarus-games.org/doc/latest

local map = ...
local game = map:get_game()

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()
  if game:get_value("tunic") == "red" then
    hero:set_tunic_sprite_id("hero/red1")
  end
  if game:get_value("tunic") == "blu" then
    hero:set_tunic_sprite_id("hero/blu1")
  end
  sol.menu.start(game, act_trans)
  sol.menu.start(game, draw_script)
  game:set_suspended()
  draw_script:print("c", map:get_id(), 160, 32)
  sol.timer.start(map, 1500, function()
    game:set_suspended(false)
    sol.menu.stop(act_trans)
    sol.menu.stop(draw_script)
  end)
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end
