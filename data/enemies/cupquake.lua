-- || CUPQUAKE || --
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local m

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_life(35)
  enemy:set_damage(1)
  enemy:set_size(24, 24)
  enemy:set_origin(12, 21)
  enemy:set_property("invincible", "no_stun")
  enemy:set_hurt_style("boss")
end

function enemy:on_restarted()
  enemy:strafe(32)
  enemy:shoot()
  sol.timer.start(enemy, 1000, function()
    enemy:shoot()
  end)
  sol.timer.start(enemy, 2000, function()
    enemy:strafe(64)
  end)
  sol.timer.start(enemy, 3000, function()
    enemy:super_shoot()
  end)
  sol.timer.start(enemy, 5000, function()
    m:stop()
    sprite:set_animation("charge")
    sol.audio.play_sound("cricket")
    enemy:set_property("invincible", "true")
    sol.timer.start(enemy, 1000, function()
      enemy:set_property("invincible", "true")
      enemy:charge_attack(144)
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
  m:set_angle(enemy:get_direction8_to(hero) * math.pi / 4)
  m:start(enemy)
  function m:on_obstacle_reached()
    local camera = map:get_camera()
    camera:set_position_on_screen(-2, 0)
    sol.timer.start(map, 50, function()
      camera:set_position_on_screen(-1, 0)
      sol.timer.start(map, 50, function()
        camera:set_position_on_screen(0, 0)
        sol.timer.start(map, 50, function()
          camera:set_position_on_screen(1, 0)
          sol.timer.start(map, 50, function()
            camera:set_position_on_screen(2, 0)
            sol.timer.start(map, 50, function()
              camera:set_position_on_screen(1, 0)
              sol.timer.start(map, 50, function()
                camera:set_position_on_screen(0, 0)
              end)
            end)
          end)
        end)
      end)
    end)
    m:stop()
    enemy:set_property("invincible", "no_stun")
    enemy:restart()
  end
end

function enemy:on_dying()
  local x, y, layer = enemy:get_position()
  enemy:set_position(x, y, layer + 1)
  game:add_money(1000)
end
