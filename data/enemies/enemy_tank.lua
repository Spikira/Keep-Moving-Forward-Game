-- IT'S RED VERSUS RED AND BLU VERSUS BLU... IT'S I AGAINST I, I AGAINST YOU...
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local m
local dir = 0

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/" .. hero:get_tunic_sprite_id())
  enemy:set_life(15)
  enemy:set_damage(1)
  enemy:set_property("invincible", "no_stun")
end

function enemy:on_restarted()
  enemy:strafe()
  sol.timer.start(enemy, 500, function()
    enemy:shoot()
    enemy:restart()
  end)
end

function enemy:shoot()
  enemy:create_enemy({
    breed = "disk"
  })
end

function enemy:strafe()
  m = sol.movement.create("straight")
  m:set_speed(88)
  m:set_angle(dir * math.pi / 2)
  m:set_smooth(false)
  m:start(enemy)
  function m:on_obstacle_reached()
    if dir == 0 then
      dir = 2
    elseif dir == 2 then
      dir = 0
    end
    enemy:strafe()
  end
end

function enemy:on_dying()
  game:remove_money(1000)
end
