-- Headless check for widget.luau's tooltip: `lua5.4 check.lua` from this dir.
-- Plain Lua against a snapshot of `ai-usagebar usage --json`, because the shape
-- the widget has to get right is the awkward one — a plan with three windows
-- whose labels share no prefix with it, next to two logins of one vendor whose
-- labels repeat theirs. Stubs are the whole noctalia surface the widget touches.

local config, state, tooltip, bar = {}, {}, nil, {}

noctalia = {
  getConfig = function(key)
    return config[key]
  end,
  string = {
    trim = function(s)
      return (s:gsub('^%s+', ''):gsub('%s+$', ''))
    end,
  },
  state = {
    get = function(key)
      return state[key]
    end,
    set = function(key, value)
      state[key] = value
    end,
    watch = function() end,
  },
}
ui = {
  row = function(_, children)
    return children
  end,
  label = function(props)
    return props.text
  end,
  glyph = function()
    return 'icon'
  end,
  image = function()
    return 'icon'
  end,
}
barWidget = {
  render = function(nodes)
    bar = nodes
  end,
  setTooltip = function(rows)
    tooltip = rows
  end,
}

local REPORT = {
  entries = {
    {
      id = 'anthropic',
      display_name = 'Claude',
      plan = 'Claude Max 20x',
      status = 'ready',
      metrics = {
        {
          label = 'Session (5h)',
          percent = 12,
          detail = 'Resets in 2h 51m · 39% elapsed · 28pts under',
        },
        {
          label = 'Weekly (7d)',
          percent = 59,
          detail = 'Resets in 1d 8h · 80% elapsed · 21pts under',
        },
        { label = 'Fable (7d)', percent = 97, detail = 'Resets in 1d 8h' },
      },
    },
    {
      id = 'openai',
      display_name = 'Codex',
      plan = 'ChatGPT Pro',
      status = 'ready',
      metrics = {
        {
          label = 'Codex weekly',
          percent = 100,
          detail = 'Resets in 1d 8h · 80% elapsed · 20pts ahead',
        },
      },
    },
    {
      id = 'openai@work',
      display_name = 'Codex · work',
      plan = 'ChatGPT Team',
      status = 'ready',
      metrics = {
        {
          label = 'Codex 5h',
          percent = 100,
          detail = 'Resets in 4h 01m · 17% elapsed · 83pts ahead',
        },
        {
          label = 'Codex weekly',
          percent = 62,
          detail = 'Resets in 1d 10h · 79% elapsed · 17pts under',
        },
      },
    },
  },
}

local function draw(vendor, window)
  config.vendor, config.window = vendor, window
  state.report = REPORT
  dofile('widget.luau')
  print(('── %s / %s '):format(vendor, window) .. ('─'):rep(16))
  for _, row in ipairs(tooltip) do
    print(string.format('%-22s %s', row.key, row.value))
  end
  print('bar: ' .. table.concat(bar, ' ') .. '\n')
  return tooltip
end

local codex = draw('openai,openai@work', 'weekly')

assert(#codex == 6, 'expected 6 rows, got ' .. #codex)
assert(
  codex[1].key == 'Codex' and codex[1].value == 'ChatGPT Pro',
  'plan header wrong'
)
assert(
  codex[2].key == 'weekly · 1d 8h',
  'label keeps its redundant plan prefix: ' .. codex[2].key
)
assert(
  codex[3].key == '' and codex[3].value == '',
  'plans not separated by a blank row'
)
-- The bar draws weekly only; the 5h window that actually blocks must still hover.
assert(
  codex[5].key == '5h · 4h 01m',
  '5h window missing from tooltip: ' .. codex[5].key
)
assert(
  codex[5].value == '100%' and codex[6].value == '62%',
  'windows not sorted fullest first'
)
assert(
  #bar == 3,
  'bar should stay filtered to icon + two weeklies, got ' .. #bar
)

local claude = draw('anthropic', 'fable,weekly')

-- "Session (5h)" shares no prefix with "Claude", so nothing may be stripped.
assert(
  claude[2].key == 'Fable (7d) · 1d 8h',
  'fullest window not first: ' .. claude[2].key
)
assert(
  claude[4].key == 'Session (5h) · 2h 51m',
  'label mangled: ' .. claude[4].key
)

print('OK')
