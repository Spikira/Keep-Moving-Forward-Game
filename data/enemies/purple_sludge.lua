-- Purple Sludge, circles with the power of purp-
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local m

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_life(5)
  enemy:set_damage(1)
  m = sol.movement.create("circle")
  m:set_speed(42)
  m:set_radius(16)
  m:start(enemy)
end

-- Event called when the enemy should start or restart its movements.
-- This is called for example after the enemy is created or after
-- it was hurt or immobilized.
function enemy:on_restarted()
end

function enemy:on_dying()
  game:add_money(50)
end
