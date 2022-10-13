-- Credits
local map = ...
local game = map:get_game()
local hero = map:get_hero()

local draw_script = require("scripts/hud/draw_text")

function map:on_started()
  game:set_hud_enabled(false)
  hero:freeze()
  hero:set_tunic_sprite_id("hero/grey1")
  sol.menu.start(map, draw_script)
  draw_script:print(1, "- CREDITS -", 160, 32)
end

function map:on_opening_transition_finished()
  sol.timer.start(map, 500, function()
    draw_script:print(2, "SPIKIRA: DIRECTION, PRODUCTION, CODE, ART, MUSIC", 160, 120)
  end)
end
