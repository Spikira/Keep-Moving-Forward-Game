-- Hub area
local map = ...
local game = map:get_game()
local hero = map:get_hero() 

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()
  game:set_command_keyboard_binding("down", nil)
  game:set_command_joypad_binding("down", nil)
  game:set_command_keyboard_binding("item_1", nil)
  game:set_command_joypad_binding("item_1", nil)
  game:set_command_keyboard_binding("item_2", nil)
  game:set_command_joypad_binding("item_2", nil)
  hero:set_tunic_sprite_id("hero/grey1")
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()
  function red_sensor:on_activated()
    hero:set_tunic_sprite_id("hero/red1")
  end

  function blu_sensor:on_activated()
    hero:set_tunic_sprite_id("hero/blu1")
  end
end
