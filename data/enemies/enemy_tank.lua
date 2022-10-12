-- IT'S RED VERSUS RED AND BLU VERSUS BLU... IT'S I AGAINST I, I AGAINST YOU...
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local movement

function enemy:on_created()

  sprite = enemy:create_sprite("enemies/" .. entity_b:get_tunic_sprite_id())
  enemy:set_life(15)
  enemy:set_damage(1)
end

-- Event called when the enemy should start or restart its movements.
-- This is called for example after the enemy is created or after
-- it was hurt or immobilized.
function enemy:on_restarted()

  movement = sol.movement.create("target")
  movement:set_target(hero)
  movement:set_speed(48)
  movement:start(enemy)
end
