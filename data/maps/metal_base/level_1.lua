-- Metal Base Act 1
local map = ...
local game = map:get_game()
local hero = map:get_hero() 

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()
  if game:get_value("tunic") == "red" then
    hero:set_tunic_sprite_id("hero/red1")
  end
  if game:get_value("tunic") == "blu" then
    hero:set_tunic_sprite_id("hero/blu1")
  end
  gate:set_enabled(false)
  gate_2:set_enabled(false)
  gate_3:set_enabled(false)
  sludge:set_enabled(false)
  sludge_2:set_enabled(false)
  sludge_3:set_enabled(false)
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()
  -- Time Penalty
  sol.timer.start(map, 1000, function()
    local x = game:get_value("time_penalty")
    game:set_value("time_penalty", x + 1)
    x = game:get_value("time_penalty")
  return true
  end)
  function cyan_golem:on_dead()
    gate:set_enabled()
    gate_2:set_enabled()
    gate_3:set_enabled()
  end
  function purple_sludge:on_dead()
    sludge:set_enabled()
    sludge_2:set_enabled()
    sludge_3:set_enabled()
  end
end

function cupquake_sensor:on_activated()
  cupquake_sensor:set_enabled(false)
  local m = sol.movement.create("straight")
  local dir = game:get_hero():get_direction()
  m:set_speed(192)
  m:set_smooth(false)
  m:set_angle(3 * math.pi / 2)
  m:start(cupquake_npc)
  function m:on_finished()
    cupquake_npc:remove()
    cupquake:set_enabled()
  end
end