--!nonstrict
-- One capsule: a vendor mark and one percentage per window. `vendor` picks the
-- plan and `window` names the windows to read, comma separated, so a single
-- capsule can carry a plan's weekly window next to a per-model one. Each
-- reading is coloured by its own severity, which is the point of grouping them:
-- one red number in the row is the one that stops the next prompt.

local vendor = string.lower(tostring(noctalia.getConfig("vendor") or "anthropic"))

-- Tabler carries an OpenAI mark but no Claude one, so Claude ships as an SVG
-- asset. ui.image takes no colour role, so the ink is baked into the file: this
-- mark is black for a light bar, and a dark theme would need a light-inked twin
-- chosen by noctalia.isDarkMode(). ui.image also caches aggressively —
-- config-reload keeps the old bitmap, so edits here need a disable/enable.
local ICONS = {
    anthropic = { image = "assets/claude.svg" },
    anthropic_api = { image = "assets/claude.svg" },
    openai = { glyph = "brand-openai" },
    openrouter = { glyph = "route" },
    copilot = { glyph = "brand-github-copilot" },
}

local GLYPH_SIZE = 13
-- Measured against screenshots rather than reasoned about. The box drives
-- alignment and only 15 centres the ink on the digits' line (11 and 12 land half
-- a pixel high, 13 a full pixel; 16 and up grow the row and shove the text up).
-- Ink size is then set separately by the padding in the SVG viewBox, so the mark
-- matches the glyph's weight without moving off centre.
local IMAGE_SIZE = 15

local function iconNode()
    local icon = ICONS[vendor]
    if icon ~= nil and icon.image ~= nil then
        return ui.image({ path = icon.image, width = IMAGE_SIZE, height = IMAGE_SIZE, fit = "contain" })
    end
    return ui.glyph({ name = icon ~= nil and icon.glyph or "brain", size = GLYPH_SIZE, color = "on_surface" })
end

local function windowNames()
    local names = {}
    for name in string.gmatch(tostring(noctalia.getConfig("window") or ""), "[^,]+") do
        local trimmed = string.lower(noctalia.string.trim(name))
        if trimmed ~= "" then names[#names + 1] = trimmed end
    end
    return names
end

local windows = windowNames()

local function entryFor(report)
    if type(report) ~= "table" or type(report.entries) ~= "table" then return nil end
    for _, entry in ipairs(report.entries) do
        if tostring(entry.id or "") == vendor then return entry end
    end
    return nil
end

-- An unmatched name is skipped rather than guessed at: with several windows on
-- one capsule, falling back to the first would silently draw the same reading
-- twice. A capsule that names nothing still gets the vendor's first window.
local function metricsFor(entry)
    if type(entry) ~= "table" or type(entry.metrics) ~= "table" then return {} end
    if #windows == 0 then
        return entry.metrics[1] ~= nil and { entry.metrics[1] } or {}
    end
    local picked = {}
    for _, name in ipairs(windows) do
        for _, metric in ipairs(entry.metrics) do
            if string.find(string.lower(tostring(metric.label or "")), name, 1, true) then
                picked[#picked + 1] = metric
                break
            end
        end
    end
    return picked
end

-- The CLI already tiers every reading, so its severity is reused rather than
-- re-deriving thresholds here.
local function colorFor(metric)
    local severity = tostring(metric and metric.severity or "")
    if severity == "critical" then return "error" end
    if severity == "high" then return "tertiary" end
    return "on_surface"
end

local function percentText(metric)
    local percent = tonumber(metric and metric.percent)
    return percent ~= nil and string.format("%d%%", percent) or "—"
end

-- ── Tooltip ───────────────────────────────────────────────────────────────────

-- The CLI packs a window's context into one string: "Resets in 1d 7h · 81%
-- elapsed · 25pts under". As a single tooltip row that overflows and ellipsises,
-- so each fragment becomes its own key/value pair.
local function detailRows(detail, rows)
    for part in string.gmatch(tostring(detail or ""), "[^·]+") do
        local text = noctalia.string.trim(part)
        if text ~= "" then
            local resets = text:match("^Resets in%s+(.+)$")
            local elapsed = text:match("^(%d+%%)%s+elapsed$")
            local pace = text:match("^(%d+pts%s+%a+)$")
            if resets ~= nil then
                rows[#rows + 1] = { key = "Resets in", value = resets }
            elseif elapsed ~= nil then
                rows[#rows + 1] = { key = "Elapsed", value = elapsed }
            elseif pace ~= nil then
                rows[#rows + 1] = { key = "Pace", value = pace }
            else
                rows[#rows + 1] = { key = "", value = text }
            end
        end
    end
end

local function tooltipFor(entry, metrics)
    local rows = { { key = tostring(entry.display_name or vendor), value = tostring(entry.plan or "") } }
    for _, metric in ipairs(metrics) do
        rows[#rows + 1] = { key = tostring(metric.label or ""), value = percentText(metric) }
        detailRows(metric.detail, rows)
    end
    return rows
end

-- ── Render ────────────────────────────────────────────────────────────────────

local function fallback(text, role, tooltip)
    barWidget.render(ui.row({ gap = 4, align = "center" }, {
        iconNode(),
        ui.label({ text = text, fontSize = 11, fontWeight = "semibold", color = role,
            baseline = "inkCentered" }),
    }))
    barWidget.setTooltip(tooltip)
end

local function render()
    local err = tostring(noctalia.state.get("error") or "")
    local entry = entryFor(noctalia.state.get("report"))

    if entry == nil then
        fallback("—", "on_surface_variant", err ~= "" and err or ("no usage for " .. vendor))
        return
    end
    if tostring(entry.status or "") == "error" then
        fallback("!", "error", tostring(entry.error or "vendor error"))
        return
    end

    local metrics = metricsFor(entry)
    if #metrics == 0 then
        fallback("—", "on_surface_variant", "no matching window for " .. vendor)
        return
    end

    local nodes = { iconNode() }
    for _, metric in ipairs(metrics) do
        nodes[#nodes + 1] = ui.label({
            text = percentText(metric), fontSize = 11, fontWeight = "semibold",
            color = colorFor(metric), baseline = "inkCentered",
        })
    end

    barWidget.render(ui.row({ gap = 4, align = "center" }, nodes))
    barWidget.setTooltip(tooltipFor(entry, metrics))
end

noctalia.state.watch("report", render)
noctalia.state.watch("error", render)

render()
