-- FWOOSHM WAKOWASH! whimp...
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local m

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_life(1)
  enemy:set_damage(1)
  enemy:set_property("invincible", "true")
  enemy:set_treasure("heart")
end

-- Event called when the enemy should start or restart its movements.
-- This is called for example after the enemy is created or after
-- it was hurt or immobilized.
function enemy:on_restarted()
  m = sol.movement.create("straight")
  m:set_speed(96)
  m:set_smooth(false)
  m:set_angle(enemy:get_angle(hero))
  local dir4 = m:get_direction4()
  sprite:set_direction(dir4)
  m:start(enemy)
  function m:on_obstacle_reached()
    enemy:remove_life(1)
    local camera = enemy:get_map():get_camera()
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

function enemy:on_attacking_hero()
  hero:start_hurt(enemy:get_damage())
  m:stop()
  enemy:remove_life(1)
  local camera = enemy:get_map():get_camera()
  camera:set_position_on_screen(-1, 0)
  sol.timer.start(enemy, 50, function()
    camera:set_position_on_screen(0, 0)
    sol.timer.start(enemy, 50, function()
      camera:set_position_on_screen(1, 0)
      sol.timer.start(enemy, 50, function()
        camera:set_position_on_screen(0, 0)
      end)
    end)
  end)
end
