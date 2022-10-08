-- Cyan Golem, fires projectiles.
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local m

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_life(5)
  enemy:set_damage(2)
  enemy:set_pushed_back_when_hurt(false)
end

-- Event called when the enemy should start or restart its movements.
-- This is called for example after the enemy is created or after
-- it was hurt or immobilized.
function enemy:on_restarted()
  enemy:create_enemy({
    breed = "projectile"
  })
  sol.timer.start(enemy, 1000, function()
    enemy:restart()
  end)
end

function enemy:on_dying()
  game:add_money(100)
end
