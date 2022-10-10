-- || CUPQUAKE || --
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local m

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_life(100)
  enemy:set_damage(1)
  enemy:set_size(24, 24)
  enemy:set_origin(12, 21)
  enemy:set_property("invincible", "no_stun")
end

function enemy:on_restarted()
  enemy:strafe(32)
  enemy:shoot()
  sol.timer.start(enemy, 1000, function()
    enemy:strafe(32)
    enemy:shoot()
  end)
  sol.timer.start(enemy, 3000, function()
    enemy:strafe(32)
    enemy:super_shoot()
  end)
  sol.timer.start(enemy, 4500, function()
    m:stop()
    sprite:set_animation("charge")
    sol.audio.play_sound("cricket")
    enemy:set_property("invincible", "true")
    sol.timer.start(enemy, 500, function()
      enemy:set_property("invincible", "true")
      enemy:charge_attack(192)
    end)
  end)
end

function enemy:strafe(speed)
  local dir  = 0
  m = sol.movement.create("straight")
  m:set_speed(speed)
  m:set_angle(dir * math.pi / 2)
  m:set_smooth(false)
  m:start(enemy)
  function m:on_obstacle_reached()
    if dir == 0 then
      dir = 2
    elseif dir == 2 then
      dir = 0
    end
    m:set_angle(dir * math.pi / 2)
    m:start(enemy)
  end
end

function enemy:shoot()
  enemy:create_enemy({
    breed = "shuriken"
  })
end

function enemy:super_shoot()
  enemy:create_enemy({
    breed = "rocket"
  })
end

function enemy:charge_attack(speed)
  m = sol.movement.create("straight")
  m:set_speed(speed)
  m:set_smooth(false)
  m:set_angle(enemy:get_angle(hero))
  m:start(enemy)
  sol.timer.start(enemy, 1000, function()
    enemy:set_property("invincible", "no_stun")
    enemy:restart()
  end)
end

function enemy:on_dying()
  game:add_money(1000)
end
