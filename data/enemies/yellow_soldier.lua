-- Yellow soldier, charges straight towards tanks.
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local m

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_life(3)
  enemy:set_damage(1)
end

-- Event called when the enemy should start or restart its movements.
-- This is called for example after the enemy is created or after
-- it was hurt or immobilized.
function enemy:on_restarted()
  sol.timer.start(enemy, 500, function()
    enemy:restart()
  return true
  end)
  if enemy:get_distance(hero) <= 88 then
    local dir =  enemy:get_direction4_to(hero)
    m = sol.movement.create("straight")
    m:set_speed(88)
    m:set_smooth(false)
    if dir == 1 or dir == 3 then
      m:set_angle(dir * math.pi / 2)
      m:start(enemy)
      function m:on_obstacle_reached()
        sol.timer.start(enemy, 500, function()
          enemy:restart()
        end)
      end
    end
  end
end

function enemy:on_dying()
  game:add_money(50)
end
