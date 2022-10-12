-- DISKS.
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local m

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  sprite:set_animation(map:get_hero():get_tunic_sprite_id())
  enemy:set_life(1)
  enemy:set_damage(1)
  enemy:set_property("invincible", "true")
end

-- Event called when the enemy should start or restart its movements.
-- This is called for example after the enemy is created or after
-- it was hurt or immobilized.
function enemy:on_restarted()
  m = sol.movement.create("straight")
  m:set_speed(192)
  m:set_smooth(false)
  m:set_angle(enemy:get_angle(hero))
  m:start(enemy)
  function m:on_obstacle_reached()
    enemy:get_sprite():set_animation("explode")
    sol.timer.start(enemy, 100, function()
      enemy:remove()
    end)
  end
end

function enemy:on_attacking_hero()
  hero:start_hurt(enemy:get_damage())
  m:stop()
  enemy:get_sprite():set_animation("explode")
  sol.timer.start(enemy, 100, function()
    enemy:remove()
  end)
end
