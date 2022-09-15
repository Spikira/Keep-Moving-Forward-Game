local spikira_logo = {}

local surface = sol.surface.create(320, 240)

local title = sol.sprite.create("menus/spikira/spikira_logo")
title:set_animation("title")

local begun = 0

local timer = nil
local pressed = false

local function draw()
  surface:clear()
  title:draw(surface)
end

function spikira_logo:on_started()
  surface:set_opacity(255)
  spikira_logo:start_animation()
  sol.audio.play_sound("spikira")
  draw()
end

function spikira_logo:begin()
  draw()
end

function spikira_logo:finish_him()
  draw()
  sol.timer.start(spikira_logo, 500, function()
    surface:fade_out()
    sol.timer.start(spikira_logo, 700, function()
      sol.menu.stop(spikira_logo)
    end)
  end)
end

function spikira_logo:start_animation()
  if begun <= 0 then
    spikira_logo:begin()
    timer = sol.timer.start(spikira_logo, 250, function()
      if begun <= 1 then
        spikira_logo:finish_him()
      end
    end)
  end
end

function spikira_logo:on_draw(screen)
  local width, height = screen:get_size()
  surface:draw(screen, 0, 0)
end

function spikira_logo:on_key_pressed(key)
  if pressed == false then
    spikira_logo:finish_him()
  end
  pressed = true
  return true
end

return spikira_logo