-- The money counter shown in the game screen.

local rupees_builder = {}

function rupees_builder:new(game, config)

  local rupees = {}

  rupees.dst_x, rupees.dst_y = config.x, config.y

  rupees.surface = sol.surface.create(128, 12)
  rupees.digits_text = sol.text_surface.create{
    font = "8_bit",
    horizontal_alignment = "left",
  }
  local time = game:get_value("time_penalty") or 0
  rupees.digits_text:set_text("Time:"..time)
  rupees.money_displayed = game:get_value("time_penalty") or 0

  function rupees:check()

    local need_rebuild = false
    local money = game:get_value("time_penalty") or 0

    -- Current money.
    if money ~= rupees.money_displayed then
      need_rebuild = true
      rupees.money_displayed = money
    end

    -- Redraw the surface only if something has changed.
    if need_rebuild then
      rupees:rebuild_surface()
    end

    -- Schedule the next check.
    sol.timer.start(rupees, 40, function()
      rupees:check()
    end)
  end

  function rupees:rebuild_surface()

    rupees.surface:clear()
    rupees.digits_text:set_text("Time:"..rupees.money_displayed)
    rupees.digits_text:draw(rupees.surface, 16, 5)
  end

  function rupees:get_surface()
    return rupees.surface
  end

  function rupees:on_draw(dst_surface)

    local x, y = rupees.dst_x, rupees.dst_y
    local width, height = dst_surface:get_size()
    if x < 0 then
      x = width + x
    end
    if y < 0 then
      y = height + y
    end

    rupees.surface:draw(dst_surface, x, y)
  end

  function rupees:on_started()
    rupees:check()
    rupees:rebuild_surface()
  end

  return rupees
end

return rupees_builder
