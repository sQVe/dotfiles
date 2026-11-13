-- Vim-style keys, added on top of the default bindings.

local pan_step = 50

local function pan(dx, dy)
  local position = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(position.x + dx, position.y + dy)
end

-- Viewer: hjkl pans, n/p switch images, g/G jump to first/last.
swayimg.viewer.on_key("h", function() pan(pan_step, 0) end)
swayimg.viewer.on_key("l", function() pan(-pan_step, 0) end)
swayimg.viewer.on_key("k", function() pan(0, pan_step) end)
swayimg.viewer.on_key("j", function() pan(0, -pan_step) end)
swayimg.viewer.on_key("n", function() swayimg.viewer.open("next") end)
swayimg.viewer.on_key("p", function() swayimg.viewer.open("prev") end)
swayimg.viewer.on_key("g", function() swayimg.viewer.open("first") end)
swayimg.viewer.on_key("Shift+g", function() swayimg.viewer.open("last") end)
swayimg.viewer.on_key("0", function() swayimg.viewer.reset() end)
swayimg.viewer.on_key("q", function() swayimg.exit() end)

-- Scroll pans like a document: wheel down shows the lower part of the image.
-- Ctrl+scroll zooms at the mouse, as in the default handler.
swayimg.viewer.on_scroll(function(modifiers, horizontal, vertical)
  if modifiers == "Ctrl" then
    if vertical then
      local mouse = swayimg.get_mouse_pos()
      local scale = swayimg.viewer.scale
      swayimg.viewer.set_abs_scale(scale - scale * vertical / 10.0, mouse.x, mouse.y)
    end
    return
  end

  pan(-math.floor(horizontal * pan_step), -math.floor(vertical * pan_step))
end)

-- Gallery: hjkl moves the selection, g/G and Ctrl-d/Ctrl-u jump.
swayimg.gallery.on_key("h", function() swayimg.gallery.select("left") end)
swayimg.gallery.on_key("j", function() swayimg.gallery.select("down") end)
swayimg.gallery.on_key("k", function() swayimg.gallery.select("up") end)
swayimg.gallery.on_key("l", function() swayimg.gallery.select("right") end)
swayimg.gallery.on_key("g", function() swayimg.gallery.select("first") end)
swayimg.gallery.on_key("Shift+g", function() swayimg.gallery.select("last") end)
swayimg.gallery.on_key("Ctrl+d", function() swayimg.gallery.select("pgdown") end)
swayimg.gallery.on_key("Ctrl+u", function() swayimg.gallery.select("pgup") end)
swayimg.gallery.on_key("q", function() swayimg.exit() end)
