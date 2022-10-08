-- pew.
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local m

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_life(1)
  enemy:set_damage(2)
  enemy:set_property("invincible", "true")
end

-- Event called when the enemy should start or restart its movements.
-- This is called for example after the enemy is created or after
-- it was hurt or immobilized.
function enemy:on_restarted()
  m = sol.movement.create("straight")
  m:set_speed(192)
  m:set_smooth(false)
  m:set_angle(enemy:get_direction4_to(hero))
  m:start(enemy)
  function m:on_finished()
    enemy:remove_life(1)
  end
end

function enemy:on_attacking_hero()
  hero:start_hurt(enemy:get_damage())
  m:stop()
  enemy:remove_life(1)
end