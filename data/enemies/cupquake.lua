-- || CUPQUAKE || --
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local m

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_life(25)
  enemy:set_damage(1)
  enemy:set_size(24, 24)
  enemy:set_origin(12, 21)
  enemy:set_property("invincible", "no_stun")
end

function enemy:on_restarted()
  enemy:stafe(0)
  enemy:shoot()
  sol.timer.start(enemy, 1000, function()
    enemy:stafe(2)
    enemy:shoot()
  end)
  sol.timer.start(enemy, 3000, function()
    enemy:stafe(0)
    enemy:super_shoot()
  end)
  sol.timer.start(enemy, 4500, function()
    m:stop()
    sprite:set_animation("charge")
    enemy:set_property("invincible", "true")
    sol.timer.start(enemy, 500, function()
      enemy:set_property("invincible", "true")
      enemy:charge_attack(264)
    end)
  end)
end

function enemy:strafe(speed)
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
    enemy:restart()
  end
end

function enemy:shoot()
  enemy:create_enemy({
    breed = "projectile"
  })
end

function enemy:super_shoot()
  sprite:set_animation("charge", function()
    sprite:set_animation("walking")
    enemy:create_enemy({
      breed = "rocket"
    })
  end)
end

function enemy:charge_attack(speed)
  m = sol.movement.create("straight")
  m:set_speed(speed)
  m:set_smooth(false)
  m:set_angle(enemy:get_angle(hero))
  m:start(enemy)
  function m:on_finished()
    enemy:set_property("invincible", "no_stun")
    sol.timer.start(enemy, 500, function()
      enemy:restart()
    end)
  end
end

function enemy:on_dying()
  game:add_money(1000)
end
