-- Omedisk, a servant of Omecram
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
end

-- Event called when the enemy should start or restart its movements.
-- This is called for example after the enemy is created or after
-- it was hurt or immobilized.
function enemy:on_restarted()
  local speed = 16
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  m = sol.movement.create("target")
  m:set_speed(speed)
  m:set_smooth(false)
  m:set_target(hero)
  m:set_ignore_obstacles()
  m:start(enemy)
  sol.timer.start(enemy, 500, function()
    speed = speed + 16
    m:set_speed(speed)
    m:start(enemy)
  return speed <= 48
  end)
  sol.timer.start(enemy, 1500, function()
    m = sol.movement.create("straight")
    m:set_speed(128)
    m:set_smooth(false)
    m:set_angle(enemy:get_angle(hero))
    m:set_ignore_obstacles()
    m:set_max_distance(320)
    m:start(enemy)
    function m:on_finished()
      enemy:remove()
    end
  end)
end
