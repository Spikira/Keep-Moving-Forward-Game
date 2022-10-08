-- Purple Sludge, circles with the power of purp-
local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local m

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_life(5)
  enemy:set_damage(1)
end

-- Event called when the enemy should start or restart its movements.
-- This is called for example after the enemy is created or after
-- it was hurt or immobilized.
function enemy:on_restarted()
  local bool_x = false
  m = sol.movement.create("circle")
  -- m:set_speed(42)
  m:set_center(enemy)
  m:set_radius(4)
  m:set_angle_from_center(math.pi)
  if math.random(0,1) == 0 then
    bool_x = true
  end
  m:set_clockwise(bool_x)
  m:set_angular_speed(24)
  m:start(enemy)
end

function enemy:on_dying()
  game:add_money(150)
end
