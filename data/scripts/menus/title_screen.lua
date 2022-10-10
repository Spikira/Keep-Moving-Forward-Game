-- Haha ctrl-c, ctr-v go brr!
local title_screen = {}

local surface = sol.surface.create(320, 240)

local title = sol.sprite.create("menus/title_screen/title_screen")
title:set_animation("title")

local timer = nil
local pressed = false

local function draw()
  surface:clear()
  title:draw(surface)
end

function title_screen:on_started()
  surface:set_opacity(255)
  title_screen:start_animation()
  draw()
end

function title_screen:begin()
  draw()
end

function title_screen:finish_him()
  draw()
  sol.timer.start(title_screen, 500, function()
    surface:fade_out()
    sol.timer.start(title_screen, 700, function()
      sol.menu.stop(title_screen)
    end)
  end)
end

function title_screen:start_animation()
  title_screen:begin()
end

function title_screen:on_draw(screen)
  local width, height = screen:get_size()
  surface:draw(screen, 0, 0)
end

function title_screen:on_key_pressed(key)
  if key == "backspace" then
    if sol.game.exists("save1.dat") == true then
      sol.game.delete("save1.dat")
    end
  elseif pressed == false then
    sol.audio.play_sound("switch")
    sol.audio.play_sound("switch_hero")
    title:set_animation("bright")
    sol.timer.start(title_screen, 200, function()
      title:set_animation("title")
      draw()
    end)
    title_screen:finish_him()
  end
  pressed = true
end

return title_screen