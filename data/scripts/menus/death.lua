-- DEATH TO ALL.
local game_meta = sol.main.get_metatable("game")

function game_meta:on_game_over_started()
  local game = self
  local map = game:get_map()
  local hero = game:get_hero()
  sol.audio.stop_music()
  game:set_suspended()
  local camera = self:get_map():get_camera()
  camera:set_position_on_screen(-1, 0)
  sol.timer.start(self, 50, function()
    camera:set_position_on_screen(0, 0)
    sol.timer.start(self, 50, function()
      camera:set_position_on_screen(1, 0)
      sol.timer.start(self, 50, function()
        camera:set_position_on_screen(0, 0)
      end)
    end)
  return true
  end)
  sol.timer.start(self, 1000, function()
    sol.audio.play_sound("electrified")
    game:set_money(0)
    game:set_value("time_penalty", 0)
    game:start()
  end)
end