-- Metal Base Act 1
local map = ...
local game = map:get_game()
local hero = map:get_hero() 

local draw_script = require("scripts/hud/draw_text")
local act_trans = require("scripts/menus/act_trans")

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

  -- sol.menu.start(game, act_trans)
  -- sol.menu.start(game, draw_script)
  -- game:set_suspended()
  -- draw_script:print("c", map:get_id(), 160, 32)
  --  sol.timer.start(map, 1500, function()
    -- game:set_suspended(false)
    -- sol.menu.stop(act_trans)
    -- sol.menu.stop(draw_script)
  -- end)
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

function cyan_golem_sensor:on_activated()
  cyan_golem:set_enabled()
end

function cupquake_sensor:on_activated()
  sol.audio.stop_music()
  game:set_starting_location(map:get_id(), "cupquake_dest")
  cupquake_sensor:set_enabled(false)
  cupquake_npc:set_enabled()
  local m = sol.movement.create("straight")
  local dir = game:get_hero():get_direction()
  m:set_speed(192)
  m:set_smooth(false)
  m:set_max_distance(88)
  m:set_angle(3 * math.pi / 2)
  m:set_ignore_obstacles()
  m:start(cupquake_npc)
  function m:on_finished()
    sol.audio.play_music("time_to_get_serious")
    local camera = map:get_camera()
    camera:set_position_on_screen(-2, 0)
    sol.timer.start(map, 50, function()
      camera:set_position_on_screen(-1, 0)
      sol.timer.start(map, 50, function()
        camera:set_position_on_screen(0, 0)
        sol.timer.start(map, 50, function()
          camera:set_position_on_screen(1, 0)
          sol.timer.start(map, 50, function()
            camera:set_position_on_screen(2, 0)
            sol.timer.start(map, 50, function()
              camera:set_position_on_screen(1, 0)
              sol.timer.start(map, 50, function()
                camera:set_position_on_screen(0, 0)
              end)
            end)
          end)
        end)
      end)
    end)
    cupquake_npc:remove()
    cupquake:set_enabled()
  end
end

function cupquake:on_dead()
  local goal = map:create_custom_entity({
    layer = 0,
    x = 320,
    y = 13,
    width = 16,
    height = 16,
    direction = 0,
    sprite = "entities/flag/hero/grey1",
    model = "big_flag",
  })
  goal:set_property("next", "metal_base/act_2")
  local m = sol.movement.create("straight")
  local dir = game:get_hero():get_direction()
  m:set_speed(192)
  m:set_smooth(false)
  m:set_max_distance(88)
  m:set_angle(3 * math.pi / 2)
  m:set_ignore_obstacles()
  m:start(goal)
  function m:on_finished()
    local camera = map:get_camera()
    camera:set_position_on_screen(-2, 0)
    sol.timer.start(map, 50, function()
      camera:set_position_on_screen(-1, 0)
      sol.timer.start(map, 50, function()
        camera:set_position_on_screen(0, 0)
        sol.timer.start(map, 50, function()
          camera:set_position_on_screen(1, 0)
          sol.timer.start(map, 50, function()
            camera:set_position_on_screen(2, 0)
            sol.timer.start(map, 50, function()
              camera:set_position_on_screen(1, 0)
              sol.timer.start(map, 50, function()
                camera:set_position_on_screen(0, 0)
              end)
            end)
          end)
        end)
      end)
    end)
  end
end
