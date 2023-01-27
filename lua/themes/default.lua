local if_nil = vim.F.if_nil

local header = {
    type = "text",
    val = {
        "                                                   ███╗     ",
        "  ██╗ ███████╗  █████╗    ██╗  ███╗ ██╗ ██╗   █████████████╗",
        "█████╗╚██╔═██║  ██╔██║███████  ╚══╝████████╗  ██╔════════██║",
        "╚═██╔╝██╔╝███║  █████║╚██║██║  ███╗╚██╔═██╔╝  ██║███████╗██║",
        "  ███╗███████║  ██╔██║ ██║██║  ╚██║████████╗  ╚═╝╚═███╔═╝╚═╝",
        "████╔╝██╔══██║  █████║ ██║██║   ██║╚██╔═██╔╝     ███████╗    ",
        "╚═██║ ██║  ██║  ╚███╔╝ ██║██║   ██║ ██║ ██║       ╚███╔═██╗ ",
        " ███║ ███████║  ██║██╗███║██║  █████████████╗ █████████████╗",
        " ╚══╝ ╚══════╝  ╚═╝╚═╝╚═╝╚══╝  ╚════════════╝ ╚════════════╝",
    },
    opts = {
        position = "center",
        hl = "Type",
        -- wrap = "overflow";
    },
}

local footer = {
    type = "text",
    val = "天若有道 吾则循天道; 天若无道 吾则逆苍天!",
    opts = {
        position = "center",
        hl = "Number",
    },
}

--- @param sc string
--- @param txt string
--- @param keybind string optional
--- @param keybind_opts table optional
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "normal", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local buttons = {
    type = "group",
    val = {
        button("e", "🌱  > New file" , ":ene <BAR> startinsert <CR>"),
        button("t", "📚  > File tree", ":NvimTreeToggle<CR>"),
        button("f", "🔍  > Find file", ":Telescope find_files<CR>"),
        button("r", "📁  > Recent"   , ":Telescope oldfiles<CR>"),
        button("s", "🛠  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
        button("q", "🚪  > Quit NVIM", ":qa<CR>"),
    },
    opts = {
        spacing = 1,
    },
}

options = {
        layout = {
            { type = "padding", val = 2 },
            header,
            { type = "padding", val = 2 },
            buttons,
            footer,
        },
        opts = {
            margin = 5,
        },
    }

---- Hi, boys and girls, and others, here's a little surprise for you~
--vim.cmd("hi Maya_b guifg=#55CDFC|hi White guifg=#FFFFFF|hi Amaranth_p guifg=#F7A8B8")
--function ln(txt, hi) return{type="text",val={txt},opts={position="center",hl=hi}} end
--options = {layout={
--{type="padding",val=2},
--ln("███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗","Maya_b"),
--ln("████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║","Amaranth_p"),
--ln("██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║","White"),
--ln("██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║","Amaranth_p"),
--ln("██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║","Maya_b"),
--ln("╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝","Maya_b"),
--{type="padding",val=2},buttons,footer},
--opts={margin=5}}

return { opts = options }
