--!nonstrict
-- Bar indicator for keep-creds.sh. The active gpg-agent.conf is the only source
-- of truth, so polling its cache TTL keeps the glyph honest even when the state
-- changes outside a click (script bails out on a failed check).
--
-- The toggle is detached: enabling waits on gpg and ssh passphrase prompts,
-- which outlives any runAsync timeout that would otherwise kill it mid-prompt.

local CONF = (noctalia.getenv("HOME") or "") .. "/.gnupg/gpg-agent.conf"
local EXTENDED_TTL = "default%-cache%-ttl 86400"
local TOGGLE = "setsid -f /home/sqve/scripts/noctalia/keep-creds.sh toggle"
local POLL_MS = 2000

function update()
  local conf = noctalia.readFile(CONF) or ""
  local on = string.find(conf, EXTENDED_TTL) ~= nil
  barWidget.setGlyph(on and "shield" or "shield-off")
  barWidget.setGlyphColor(on and "primary" or "on_surface")
  barWidget.setTooltip(on and "Keep credentials: on" or "Keep credentials: off")
  noctalia.setUpdateInterval(POLL_MS)
end

function onClick()
  noctalia.runAsync(TOGGLE)
end

update()
