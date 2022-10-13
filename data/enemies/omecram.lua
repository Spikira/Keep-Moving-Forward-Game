-- || OMECRAM || --
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local m

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_life(50)
  enemy:set_damage(1)
  enemy:set_size(24, 24)
  enemy:set_origin(12, 21)
  enemy:set_property("invincible", "no_stun")
  enemy:set_hurt_style("boss")
end

function enemy:on_restarted()
  enemy:target(24)
  sol.timer.start(enemy, 1000, function()
    enemy:target(48)
    enemy:shoot()
  end)
  sol.timer.start(enemy, 2000, function()
    m:stop()
    enemy:super_shoot()
  end)
  sol.timer.start(enemy, 3000, function()
    enemy:target(24)
    enemy:shoot()
  end)
  sol.timer.start(enemy, 3500, function()
    sprite:set_animation("charge")
    sol.audio.play_sound("cricket")
    enemy:set_property("invincible", "true")
    m:stop()
  end)
  sol.timer.start(enemy, 4000, function()
    enemy:rocket()
    enemy:set_property("invincible", "no_stun")
    enemy:charge_attack(88)
    sprite:set_animation("walking")
  end)
  sol.timer.start(enemy, 5000, function()
    enemy:restart()
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

function enemy:summon()
  enemy:create_enemy({
    breed = "omedisk"
  })
end

function enemy:rocket()
  enemy:create_enemy({
    breed = "rocket"
  })
end

function enemy:square_forme(speed)
  local dir  = 0
  m = sol.movement.create("straight")
  m:set_speed(speed)
  m:set_smooth(false)
  m:set_angle(dir * math.pi / 2)
  m:start(enemy)
  function m:on_obstacle_reached()
    if dir < 3 then
      dir = dir + 1
    end
    m:set_angle(dir * math.pi / 2)
    m:start(enemy)
  end
end

function enemy:blast()
  local e0 = enemy:create_enemy({
    breed = "omecram_blast"
  })
  e0:set_property("dir", "0")
  local e1 = enemy:create_enemy({
    breed = "omecram_blast"
  })
  e1:set_property("dir", "1")
  local e3 = enemy:create_enemy({
    breed = "omecram_blast"
  })
  e3:set_property("dir", "3")
  local e4 = enemy:create_enemy({
    breed = "omecram_blast"
  })
  e4:set_property("dir", "4")
end

function enemy:target(speed)
  m = sol.movement.create("target")
  m:set_speed(speed)
  m:set_target(hero)
  m:start(enemy)
end

function enemy:on_dying()
  local x, y, layer = enemy:get_position()
  enemy:set_position(x, y, layer + 1)
  game:add_money(1000)
end
