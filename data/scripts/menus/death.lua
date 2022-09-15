-- DEATH TO ALL.
local game_meta = sol.main.get_metatable("game")

function game_meta:on_game_over_started()
  local game = self
  local map = game:get_map()
  local hero = game:get_hero()
  sol.audio.stop_music()
  game:set_money(0)
  game:start()
end