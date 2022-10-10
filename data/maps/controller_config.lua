-- Controls configuration.
local map = ...
local game = map:get_game()
local hero = map:get_hero()

local state = "up"

local ready = false

local draw_script = require("scripts/hud/draw_text")

function map:on_started()
  game:set_hud_enabled(false)
  hero:freeze()
  hero:set_tunic_sprite_id("hero/grey1")
  sol.menu.start(map, draw_script)
  draw_script:print(1, "- CONTROLS CONFIGURATION -", 160, 32)
  -- draw_script:print(1, "abcdefghijklmnopqrstuvwxyz", 160, 32)
  -- draw_script:print(1, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 160, 32)
  game:set_command_keyboard_binding("up", nil)
  game:set_command_keyboard_binding("left",nil)
  game:set_command_keyboard_binding("down", nil)
  game:set_command_keyboard_binding("right", nil)
  game:set_command_keyboard_binding("action", nil)
  game:set_command_keyboard_binding("pause", nil)
  game:set_command_keyboard_binding("attack", nil)
  game:set_command_keyboard_binding("item_1", nil)
  game:set_command_keyboard_binding("item_2", nil)
end

function map:on_opening_transition_finished()
  sol.timer.start(map, 500, function()
    ready = true
    draw_script:print(3, state, 184, 64)
  end)
  draw_script:print(2, "PRESS A NEW KEY FOR: ", 120, 64)
end

function game:on_key_pressed(key)
  if ready == true then
    if key == game:get_command_keyboard_binding("up") or 
    key == game:get_command_keyboard_binding("left") or 
    key == game:get_command_keyboard_binding("right") or 
    key == game:get_command_keyboard_binding("pause") or 
    key == game:get_command_keyboard_binding("attack") then
      sol.audio.play_sound("wrong3")
    else
      game:set_command_keyboard_binding(state, key)
      if state == "up" then
        draw_script:print(4, state..": "..game:get_command_keyboard_binding(state), 64, 120)
        state = "left"
        draw_script:print(3, state, 184, 64)
      elseif state == "left" then
        draw_script:print(5, state..": "..game:get_command_keyboard_binding(state), 64, 132)
        state = "right"
        draw_script:print(3, state, 184, 64)
      elseif state == "right" then
        draw_script:print(6, state..": "..game:get_command_keyboard_binding(state), 64, 144)
        state = "pause"
        draw_script:print(3, state, 184, 64)
      elseif state == "pause" then
        draw_script:print(7, state..": "..game:get_command_keyboard_binding(state), 64, 156)
        state = "attack"
        draw_script:print(3, state, 184, 64)
      elseif state == "attack" then
        ready = false
        draw_script:print(8, state..": "..game:get_command_keyboard_binding(state), 64, 168)
        draw_script:print(3, "", 0, 0)
        draw_script:print(2, "KEEP MOVING FORWARD!", 160, 64)
        sol.timer.start(map, 2000, function()
          draw_script:print(2, "YOU CAN NEVER TURN BACK!", 160, 64)
          sol.timer.start(map, 2000, function()
            draw_script:print(2, "THERE IS NO BACK BUTTON!", 160, 64)
            sol.timer.start(map, 2000, function()
              draw_script:print(2, "BE CAREFUL OUT THERE!", 160, 64)
              sol.timer.start(map, 2000, function()
                hero:teleport("hub", nil)
                sol.menu.stop(draw_script)
                game:set_starting_location("hub", nil)
              end)
            end)
          end)
        end)
      end
    end
  end
return false
end