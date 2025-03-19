local headers = {
  {
    "                  __                ",
    "               /\\/'-,               ",
    "       ,--'''''   /\"                ",
    " ____,'.  )       \\___  _           ",
    "`\"\"\"\"\"------'\"\"\"`-----'(_)_ __ ___  ",
  },
  {
    "                           __      _",
    "                         o'')}____//",
    "                        _ `_/      )",
    "  _ __   ___  _____   _(_)(_(_/-(_/"
  },
  {
    "                               .-.   ",
    "  (___________________________()6 `-,",
    "  (   ______________________   /''\"` ",
    "  //\\\\   ___  _____   _(_)_ //\\\\__   ",
  },
  {
    "                      .-\"-.        ",
    "                     /|6 6|\\        ",
    "                    {/(_0_)\\}       ",
    "                     _/ _ \\_        ",
    "  _ __   ___  _____ (/_(_)_\\)_ ___  ",
  },
  {
    "                     __         ",
    "                (___()'`;           ",
    "                /,    /`_           ",
    "  _ __   ___  __\\\\\"--\\\\(_)_ __ ___",
  }
}

local headerColors = {
  {
    { { "GruvboxOrangeBold", 0, -1 } },
    { { "GruvboxOrangeBold", 0, -1 } },
    { { "GruvboxOrangeBold", 0, -1 } },
    { { "GruvboxOrangeBold", 0, 23 }, { "GruvboxGreenBold", 24, -1 } },
    { { "GruvboxOrangeBold", 0, 23 }, { "GruvboxGreenBold", 23, 26 }, { "GruvboxPurple", 26, -1 } },
  },
  {
    { { "GruvboxOrangeBold", 0, -1 } },
    { { "GruvboxOrangeBold", 0, -1 } },
    { { "GruvboxGreenBold", 0, 25 }, { "GruvboxOrangeBold", 25, -1 } },
    { { "GruvboxAqua", 0, 17 },      { "GruvboxPurple", 17, 23 },    { "GruvboxGreenBold", 23, 26 }, { "GruvboxOrangeBold", 26, -1 } },
  },
  {
    { { "GruvboxOrangeBold", 0, -1 } },
    { { "GruvboxOrangeBold", 0, -1 } },
    { { "GruvboxOrangeBold", 0, -1 } },
    { { "GruvboxOrange", 0, 8 },     { "GruvboxAqua", 8, 17 }, { "GruvboxPurple", 17, 23 }, { "GruvboxGreenBold", 23, 26 }, { "GruvboxPurple", 26, 27 }, { "GruvboxOrangeBold", 27, 32 }, { "GruvboxPurple", 32, -1 } },
  },
  {
    { { "GruvboxOrangeBold", 0, -1 } },
    { { "GruvboxOrangeBold", 0, -1 } },
    { { "GruvboxOrangeBold", 0, -1 } },
    { { "GruvboxOrangeBold", 0, 23 }, { "GruvboxGreenBold", 23, 26 }, { "GruvboxOrangeBold", 26, -1 } },
    { { "GruvboxAqua", 0, 17 },       { "GruvboxPurple", 17, 20 },    { "GruvboxOrangeBold", 20, 23 }, { "GruvboxGreenBold", 23, 26 }, { "GruvboxOrangeBold", 26, 29 }, { "GruvboxPurple", 29, -1 } },
  },
  {
    { { "GruvboxOrangeBold", 0, -1 } },
    { { "GruvboxOrangeBold", 0, -1 } },
    { { "GruvboxOrangeBold", 0, 24 }, { "GruvboxGreenBold", 24, 26 } },
    { { "GruvboxAqua", 0, 16 },       { "GruvboxOrangeBold", 16, 23 }, { "GruvboxGreenBold", 23, 26 }, { "GruvboxPurple", 26, -1 } },
  }
}

local header_end = { " | '_ \\ / _ \\/ _ \\ \\ / / | '_ ` _ \\ ",
  " | | | |  __/ (_) \\ V /| | | | | | |",
  " |_| |_|\\___|\\___/ \\_/ |_|_| |_| |_|",
}
local header_colors_end = {
  { { "GruvboxAqua", 0, 16 }, { "GruvboxPurple", 16, -1 } },
  { { "GruvboxAqua", 0, 17 }, { "GruvboxPurple", 17, -1 } },
  { { "GruvboxAqua", 0, 18 }, { "GruvboxPurple", 18, -1 } },
}

function TableConcat(t1, t2)
  for i = 1, #t2 do
    t1[#t1 + 1] = t2[i]
  end
  return t1
end

-- pick a random header
math.randomseed(os.time())
local index = math.random(1, #headers)

local header = TableConcat(headers[index], header_end)
local headerColor = TableConcat(headerColors[index], header_colors_end)

local leader = "SPC"
local if_nil = vim.F.if_nil

--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
  local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

  local opts = {
    position = "center",
    shortcut = sc,
    cursor = 3,
    width = 40,
    align_shortcut = "right",
    hl_shortcut = "Keyword",
  }
  if keybind then
    keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { "n", sc_, keybind, keybind_opts }
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
    vim.api.nvim_feedkeys(key, "t", false)
  end

  return {
    type = "button",
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

local buttons = {
  button("e", "  New file", "<cmd>ene <CR>"),
  button("󱁐 s f", "󰈞  Find file"),
  button("󱁐 s g", "󱎸  Grep"),
  button("󱁐 s .", "󰊄  Find recent file"),
  button("󱁐 t t", "  Toggle Terminal"),
}

return {
  {
    'goolord/alpha-nvim',
    config = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = header
      dashboard.section.header.opts = {
        hl = headerColor,
        position = "center",
      }
      dashboard.section.footer.val = {
        "",
        "",
        "All these bytes will be lost in time,",
        "              like tears in the rain.",
      }
      dashboard.section.footer.opts.hl = "Comment"
      dashboard.section.buttons.val = buttons
      dashboard.section.buttons.opts.spacing = 0
      require("alpha").setup(dashboard.opts)
    end,
  },
}
