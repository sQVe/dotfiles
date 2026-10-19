--!nonstrict
-- Bar indicator for the active TUXEDO Control Center profile. tccd is the only
-- source of truth: plugging in or unplugging resets a manual choice to the
-- state profile, so the glyph polls instead of trusting the last click.
--
-- tccd can take seconds to answer under load, so a click shows its target at
-- once and polls are ignored until tccd has the last profile clicked.

local HELPER = "/home/sqve/scripts/noctalia/tcc-profile.sh"
local POLL_MS = 2000
local GET_TIMEOUT_MS = 5000
local SET_TIMEOUT_MS = 15000

local CYCLE = { "Max", "Work", "Eco", "Quiet" }

local GLYPHS = {
  Max = "bolt",
  Work = "briefcase",
  Eco = "leaf",
  Quiet = "ear-off",
}

local shown = nil
local wanted = nil
local sending = false
local polling = false
local generation = 0

local function show(name)
  shown = name
  barWidget.setGlyph(GLYPHS[name] or "help")
  barWidget.setGlyphColor(name == "Max" and "primary" or "on_surface")
  barWidget.setTooltip(name)
end

local function succeeded(result)
  return result ~= nil and result.exitCode == 0
end

local function refresh()
  if polling or wanted ~= nil then
    return
  end

  polling = true
  local startedGeneration = generation

  local started = noctalia.runAsync(HELPER .. " get", function(result)
    polling = false

    if wanted ~= nil or startedGeneration ~= generation then
      return
    end

    if not succeeded(result) then
      show("unknown")
      return
    end

    show(noctalia.string.trim(tostring(result.stdout or "")))
  end, GET_TIMEOUT_MS)

  if not started then
    polling = false
  end
end

-- A profile outside CYCLE sits between the last and the first, so a step
-- forward goes to Max and a step back to Quiet.
local function stepFrom(name, step)
  local count = #CYCLE
  local index = table.find(CYCLE, name)

  if index == nil then
    index = step < 0 and count + 1 or 0
  end

  return CYCLE[(index - 1 + step) % count + 1]
end

-- Sends one switch at a time. Clicks during a switch only move wanted, and the
-- last one is sent when the running switch ends.
local function sendWanted()
  if sending or wanted == nil then
    return
  end

  sending = true
  local target = wanted

  local function finish(ok)
    sending = false
    generation = generation + 1

    if wanted ~= target then
      sendWanted()
      return
    end

    wanted = nil
    if not ok then
      refresh()
    end
  end

  local started = noctalia.runAsync(HELPER .. " set " .. target, function(result)
    finish(succeeded(result))
  end, SET_TIMEOUT_MS)

  if not started then
    finish(false)
  end
end

local function switch(step)
  wanted = stepFrom(wanted or shown, step)
  show(wanted)
  sendWanted()
end

function update()
  refresh()
  noctalia.setUpdateInterval(POLL_MS)
end

function onClick()
  switch(1)
end

function onRightClick()
  switch(-1)
end

update()
