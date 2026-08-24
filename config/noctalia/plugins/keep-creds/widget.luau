--!nonstrict
-- Bar indicator for keep-creds.sh. The flag file is the only source of truth,
-- so polling it keeps the glyph honest even when the state changes outside a
-- click (reboot clears XDG_RUNTIME_DIR, script bails out on a failed check).
--
-- The toggle is detached: enabling waits on gpg and ssh passphrase prompts,
-- which outlives any runAsync timeout that would otherwise kill it mid-prompt.

local FLAG = (noctalia.getenv("XDG_RUNTIME_DIR") or "") .. "/keep-creds"
local TOGGLE = "setsid -f /home/sqve/scripts/noctalia/keep-creds.sh toggle"
local POLL_MS = 2000

function update()
  local on = noctalia.fileExists(FLAG)
  barWidget.setGlyph(on and "shield" or "shield-off")
  barWidget.setGlyphColor(on and "primary" or "on_surface")
  barWidget.setTooltip(on and "Keep credentials: on" or "Keep credentials: off")
  noctalia.setUpdateInterval(POLL_MS)
end

function onClick()
  noctalia.runAsync(TOGGLE)
end

update()
