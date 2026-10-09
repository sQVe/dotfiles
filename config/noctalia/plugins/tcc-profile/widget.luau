--!nonstrict
-- Bar indicator for the active TUXEDO Control Center profile. tccd is the only
-- source of truth: plugging in or unplugging resets a manual choice to the
-- state profile, so the glyph polls instead of trusting the last click.

local HELPER = "/home/sqve/scripts/noctalia/tcc-profile.sh"
local POLL_MS = 2000
local TIMEOUT_MS = 5000

local GLYPHS = {
  Max = "bolt",
  Eco = "leaf",
  Quiet = "ear-off",
}

local function show(name)
  barWidget.setGlyph(GLYPHS[name] or "help")
  barWidget.setGlyphColor(name == "Max" and "primary" or "on_surface")
  barWidget.setTooltip(name)
end

local function refresh()
  noctalia.runAsync(HELPER .. " get", function(result)
    if result == nil or result.exitCode ~= 0 then
      show("unknown")
      return
    end

    show(noctalia.string.trim(tostring(result.stdout or "")))
  end, TIMEOUT_MS)
end

local function switch(direction)
  noctalia.runAsync(HELPER .. " " .. direction, function(result)
    if result ~= nil and result.exitCode == 0 then
      show(noctalia.string.trim(tostring(result.stdout or "")))
    end
  end, TIMEOUT_MS)
end

function update()
  refresh()
  noctalia.setUpdateInterval(POLL_MS)
end

function onClick()
  switch("next")
end

function onRightClick()
  switch("prev")
end

update()
