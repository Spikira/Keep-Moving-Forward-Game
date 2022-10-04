-- DEATH TO ALL.
local game_meta = sol.main.get_metatable("game")

function game_meta:on_game_over_started()
  local game = self
  local map = game:get_map()
  local hero = game:get_hero()
  sol.audio.stop_music()
  game:set_suspended()
  local camera = self:get_map():get_camera()
  local x = -1
  sol.timer.start(self, 50, function()
    camera:set_position_on_screen(x, 0)
    if x <= 1 then
      x = x + 1
    else
      x = -1
    end
  return true
  end)
  sol.timer.start(self, 1000, function()
    sol.audio.play_sound("electrified")
    game:set_money(0)
    game:start()
  end)
end