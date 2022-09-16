-- Metal Base Act 1
local map = ...
local game = map:get_game()
local hero = map:get_hero() 

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()
  game:set_value("time_penalty", 0)
  function red_sensor:on_activated()
    hero:set_tunic_sprite_id("hero/red1")
  end
  function blu_sensor:on_activated()
    hero:set_tunic_sprite_id("hero/blu1")
  end
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()
  -- Time Penalty
  sol.timer.start(map, 1000, function()
    game:set_value("time_penalty", game:get_value("time_penalty") + 1)
  return true
  end)
end
