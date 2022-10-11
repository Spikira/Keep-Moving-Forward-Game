-- Act transitions
local act_trans = {}

local title = sol.sprite.create("menus/act_trans")

function act_trans:on_draw(dst_surface)
  title:draw(dst_surface)
end

return act_trans