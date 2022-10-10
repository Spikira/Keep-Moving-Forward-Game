-- BIG FLAG, kinda like a goal ring
local entity = ...
local game = entity:get_game()
local map = entity:get_map()

local draw_script = require("scripts/hud/draw_text")

function entity:on_created()
  local x, y, layer = entity:get_position()
  entity:add_collision_test("sprite", function(entity_a, entity_b)
    if entity_b:get_type() == "hero" then
      local rank
      if game:get_money() - 2 * game:get_value("time_penalty") >= 2000 then
        rank = "S"
      elseif game:get_money() - 2 * game:get_value("time_penalty") >= 1500 then
        rank = "A"
      elseif game:get_money() - 2 * game:get_value("time_penalty") >= 1000 then
        rank = "B"
      elseif game:get_money() - 2 * game:get_value("time_penalty") >= 500 then
        rank = "C"
      elseif game:get_money() - 2 * game:get_value("time_penalty") > 0 then
        rank = "D"
      elseif game:get_money() - 2 * game:get_value("time_penalty") == 0 then
        rank = "E"
      elseif game:get_money() - 2 * game:get_value("time_penalty") < 0 then
        rank = "F"
      end
      local rank
      sol.audio.play_sound("victory")
      map:create_custom_entity({
        name = entity:get_name(),
        x = x,
        y = y,
        width = 16,
        height = 16,
        layer = layer,
        direction = 0,
        sprite = "entities/flag/"..entity_b:get_tunic_sprite_id(),
      })
      entity:remove()
      game:set_suspended()
      sol.menu.start(game, draw_script)
      draw_script:print(1, "- "..map:get_id().." -", 160, 32)
      draw_script:print(2, "SCORE: "..game:get_money(), 120, 64)
      draw_script:print(3, "TIME: "..game:get_value("time_penalty"), 120, 72)
      draw_script:print(4, game:get_money().." - 2*"..game:get_value("time_penalty"), 120, 80)
      draw_script:print(5, "RANK: "..rank, 120, 88)
    end
  end)
end
