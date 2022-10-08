-- Controls configuration.
local map = ...
local game = map:get_game()
local hero = map:get_hero()
local text_surface = sol.surface.create(320, 240)
local title = sol.text_surface.create{
  font = "8_bit",
  horizontal_alignment = "center",
}
local main_text = sol.text_surface.create{
  font = "8_bit",
  horizontal_alignment = "left",
}
local command = sol.text_surface.create{
  font = "8_bit",
  horizontal_alignment = "left",
}

function map:on_started()
  text_surface:clear()
  game:set_hud_enabled(false)
  hero:freeze()
  hero:set_tunic_sprite_id("hero/grey1")
  title:set_text("- Controls Configuration -")
  title:draw(text_surface, 160, 32)
end

function map:on_opening_transition_finished()
  main_text:set_text("Press a new key for: ")
  main_text:draw(text_surface, 120, 64)
end
