-- This script draws text, cuz idk how to do it straight from map script.
local draw_script = {}

local text_1 = sol.text_surface.create{
  font = "8_bit",
  horizontal_alignment = "center",
  vertical_alignment = "top",
}

local text_2 = sol.text_surface.create{
  font = "8_bit",
  horizontal_alignment = "center",
  vertical_alignment = "top",
}

local text_3 = sol.text_surface.create{
  font = "8_bit",
  horizontal_alignment = "left",
  vertical_alignment = "top",
}

local text_4 = sol.text_surface.create{
  font = "8_bit",
  horizontal_alignment = "left",
  vertical_alignment = "top",
}

function draw_script:print(n, t, x, y)
  if n == 1 then
    text_1:set_text(t)
    text_1:set_xy(x, y)
  elseif n == 2 then
    text_2:set_text(t)
    text_2:set_xy(x, y)
  elseif n == 3 then
    text_3:set_text(t)
    text_3:set_xy(x, y)
  elseif n == 4 then
    text_4:set_text(t)
    text_4:set_xy(x, y)
  end
end

function draw_script:on_draw(dst_surface)
  text_1:draw(dst_surface)
  text_2:draw(dst_surface)
  text_3:draw(dst_surface)
  text_4:draw(dst_surface)
end

function draw_script:unprint(n)
  if n == 1 then
    text_1:fade_out()
  elseif n == 2 then
    text_2:fade_out()
  elseif n == 3 then
    text_3:fade_out()
  elseif n == 4 then
    text_4:fade_out()
  end
end

return draw_script