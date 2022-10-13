-- Omedisk sprite, but different movements
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local m

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/omedisk")
  enemy:set_life(1)
  enemy:set_damage(1)
  enemy:set_property("invincible", "true")
end

-- Event called when the enemy should start or restart its movements.
-- This is called for example after the enemy is created or after
-- it was hurt or immobilized.
function enemy:on_restarted()
  m = sol.movement.create("straight")
  m:set_speed(128)
  m:set_smooth(false)
  m:set_angle(enemy:get_property("dir") * math.pi / 2)
  m:set_ignore_obstacles()
  m:set_max_distance(196)
  m:start(enemy)
  function m:on_finished()
    enemy:remove()
  end
end
