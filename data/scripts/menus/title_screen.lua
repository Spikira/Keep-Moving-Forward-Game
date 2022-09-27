-- Haha ctrl-c, ctr-v go brr!
local title_screen = {}

local surface = sol.surface.create(320, 240)

local title = sol.sprite.create("menus/title_screen/title_screen")
title:set_animation("title")

local begun = 0

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
  if begun <= 0 then
    title_screen:begin()
    timer = sol.timer.start(title_screen, 250, function()
      if begun <= 1 then
        title_screen:finish_him()
      end
    end)
  end
end

function title_screen:on_draw(screen)
  local width, height = screen:get_size()
  surface:draw(screen, 0, 0)
end

function title_screen:on_key_pressed(key)
  if pressed == false then
    title_screen:finish_him()
  end
  pressed = true
  return true
end

return title_screen