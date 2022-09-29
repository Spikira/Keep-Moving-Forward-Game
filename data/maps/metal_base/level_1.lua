-- Metal Base Act 1
local map = ...
local game = map:get_game()
local hero = map:get_hero() 

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()
  function red_sensor:on_activated()
    hero:set_tunic_sprite_id("hero/red1")
  end
  function blu_sensor:on_activated()
    hero:set_tunic_sprite_id("hero/blu1")
  end
  gate:set_enabled(false)
  gate_2:set_enabled(false)
  gate_3:set_enabled(false)
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()
  -- Time Penalty
  sol.timer.start(map, 1000, function()
    local x = game:get_value("time_penalty") or 0
    game:set_value("time_penalty", x + 1)
    x = game:get_value("time_penalty")
  return true
  end)
  function cyan_golem:on_dead()
    gate:set_enabled()
    gate_2:set_enabled()
    gate_3:set_enabled()
  end
end
