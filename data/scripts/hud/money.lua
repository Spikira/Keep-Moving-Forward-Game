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
  rupees.digits_text:set_text("Score:"..game:get_money())
  rupees.money_displayed = game:get_money()

  function rupees:check()

    local need_rebuild = false
    local money = game:get_money()

    -- Current money.
    if money ~= rupees.money_displayed then
      need_rebuild = true
      local increment
      if money > rupees.money_displayed then
        increment = 10
        rupees.money_displayed = rupees.money_displayed + increment
      else
        rupees.money_displayed = money
      end


      -- Play a sound if we have just reached the final value.
      if rupees.money_displayed == money then
        sol.audio.play_sound("shield")

      -- While the counter is scrolling, play a sound every 2 values.
      elseif rupees.money_displayed % 2 == 0 then
        sol.audio.play_sound("shield")
      end
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

    -- Current rupee (counter).
    local max_money = game:get_max_money()
    if rupees.money_displayed == max_money then
      rupees.digits_text:set_font("8_bit")
    else
      rupees.digits_text:set_font("8_bit")
    end
    rupees.digits_text:set_text("Score:"..rupees.money_displayed)
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
