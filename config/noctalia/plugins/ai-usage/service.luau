--!nonstrict
-- Single poller for every ai-usage capsule. `ai-usagebar usage --json` returns
-- all vendors in one call, so the report is fetched once and published on
-- shared state; the capsules are pure subscribers and never spawn a process.

local COMMAND = "ai-usagebar usage --json"
local TIMEOUT_MS = 20000

local function intervalMs()
    local minutes = tonumber(noctalia.getConfig("refresh_minutes")) or 5
    return math.max(1, math.min(120, minutes)) * 60000
end

local function poll()
    noctalia.runAsync(COMMAND, function(result)
        if result == nil or result.exitCode ~= 0 then
            local stderr = noctalia.string.trim(tostring(result and result.stderr or ""))
            noctalia.state.set("error", stderr ~= "" and stderr or "ai-usagebar failed")
            return
        end
        local decoded, err = noctalia.json.decode(result.stdout or "")
        if decoded == nil or type(decoded.entries) ~= "table" then
            noctalia.state.set("error", tostring(err or "unreadable ai-usagebar output"))
            return
        end
        noctalia.state.set("error", "")
        noctalia.state.set("report", decoded)
    end, TIMEOUT_MS)
end

-- update() is the tick; the interval is re-read every time so a settings change
-- takes effect on the next cycle without a reload.
function update()
    noctalia.setUpdateInterval(intervalMs())
    poll()
end

function onConfigChanged()
    noctalia.setUpdateInterval(intervalMs())
end

update()
