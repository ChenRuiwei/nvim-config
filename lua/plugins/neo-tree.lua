return {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    keys = {
        {
            "<leader>fe",
            function()
                require("neo-tree.command").execute({ toggle = true })
            end,
            desc = "Explorer NeoTree (root dir)",
        },
        { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
    },
    opts = {
        close_if_last_window = true,
    }
}
