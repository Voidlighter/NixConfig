local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
end
return {
    {
	"ribru17/bamboo.nvim",
	config = function()
	    vim.cmd.colorscheme "bamboo"
	    enable_transparency()
	end
    },
    -- {
    --     "folke/tokyonight.nvim",
    --     config = function()
    --         vim.cmd.colorscheme "tokyonight"
    --         enable_transparency()
    --     end
    -- },
}
