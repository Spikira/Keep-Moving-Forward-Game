-- || OMECRAM || --
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local m
local dir = 3

local state = 0

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_life(75)
  enemy:set_damage(1)
  enemy:set_size(24, 24)
  enemy:set_origin(12, 21)
  enemy:set_property("invincible", "no_stun")
  enemy:set_hurt_style("boss")
  enemy:set_layer_independent_collisions()
end

function enemy:on_restarted()
  if state == 0 then
    enemy:target(32)
    state = 1
  else
    enemy:square_forme(294)
    state = 0
  end
  sol.timer.start(enemy, 3000, function()
    enemy:summon()
  end)
  sol.timer.start(enemy, 4000, function()
    sprite:set_animation("charge")
    sol.audio.play_sound("cricket")
  end)
  sol.timer.start(enemy, 5000, function()
    enemy:blast()
    sprite:set_animation("walking")
    enemy:restart()
  end)
end

function enemy:strafe(speed)
  dir  = 0
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
    breed = "omedisk",
    layer = 0
  })
end

function enemy:rocket()
  enemy:create_enemy({
    breed = "rocket",
    layer = 0
  })
end

function enemy:square_forme(speed)
  dir = 3
  m = sol.movement.create("straight")
  m:set_speed(speed)
  m:set_smooth(false)
  m:set_angle(dir * math.pi / 2)
  m:start(enemy)
  function m:on_obstacle_reached()
    if dir < 3 then
      dir = dir + 1
    else
      dir = 0
    end
    m:set_angle(dir * math.pi / 2)
    m:start(enemy)
  end
end

function enemy:blast()
  enemy:create_enemy({
    breed = "omecram_blast",
    layer = 0,
    direction = 0
  })
  enemy:create_enemy({
    breed = "omecram_blast",
    layer = 0,
    direction = 1
  })
  enemy:create_enemy({
    breed = "omecram_blast",
    layer = 0,
    direction = 2
  })
  enemy:create_enemy({
    breed = "omecram_blast",
    layer = 0,
    direction = 3
  })
  local fodder = enemy:create_enemy({
    breed = "omedisk",
    layer = 0,
    treasure_name = "heart"
  })
  fodder:remove_life(1)
end

function enemy:target(speed)
  m = sol.movement.create("target")
  m:set_speed(speed)
  m:set_target(hero)
  m:set_ignore_obstacles()
  m:start(enemy)
end

function enemy:on_dying()
  local x, y, layer = enemy:get_position()
  enemy:set_position(x, y, layer + 1)
  game:add_money(1000)
end
