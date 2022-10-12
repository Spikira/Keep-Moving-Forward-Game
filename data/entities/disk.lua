-- Disk projectiles!
local disk = ...
local game = disk:get_game()
local map = disk:get_map()

local sprite = disk:create_sprite("hero/disk")
local sound

function disk:on_created()
  disk:set_can_traverse_ground("low_wall", true)
  local m = sol.movement.create("straight")
  local dir = game:get_hero():get_direction()
  m:set_speed(192)
  m:set_smooth(false)
  m:set_angle(1 * math.pi / 2)
  m:start(disk)
  sprite:set_animation(map:get_hero():get_tunic_sprite_id())
  disk:set_modified_ground("empty")
  function m:on_obstacle_reached()
    if sound == nil then
      sol.audio.play_sound("fire_ball")
      sound = "played"
    end
    sprite:set_animation("explode")
    sol.timer.start(disk, 100, function()
      disk:remove()
    end)
  end
  disk:add_collision_test("sprite", function(entity_a, entity_b)
    if entity_b:get_type() == "enemy" then
      if entity_b:get_property("invincible") == "true" then
        -- Will eventually do something here, not sure what for now.
      elseif entity_b:get_property("invincible") == "no_stun" then
        if sound == nil then
          sol.audio.play_sound("fire_ball")
          sol.audio.play_sound("boss_hurt")
          entity_b:remove_life(game:get_ability("sword"))
          entity_b:set_property("invincible", "true")
          entity_b:get_sprite():set_animation("hurt")
          sound = "played"
          sol.timer.start(disk, 100, function()
            entity_b:get_sprite():set_animation("walking")
            entity_b:set_property("invincible", "no_stun")
            disk:remove()
          end)
        end
        sprite:set_animation("explode")
        m:stop()
      else
        if sound == nil then
          sol.audio.play_sound("fire_ball")
          sound = "played"
        end
        sprite:set_animation("explode")
        m:stop()
        sol.timer.start(disk, 100, function()
          disk:remove()
        end)
        entity_b:hurt(game:get_ability("sword"))
      end
    end
  end)
end
