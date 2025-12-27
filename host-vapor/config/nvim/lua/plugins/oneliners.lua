return {
    { -- This helps with ssh tunneling and copying to clipboard
	'ojroques/vim-oscyank',
    },
    { -- Git plugin
	'tpope/vim-fugitive',
    },
    { -- Show historical versions of the file locally
	'mbbill/undotree',
    },
    { -- Show CSS Colors
	'brenoprata10/nvim-highlight-colors',
	config = function()
	    require('nvim-highlight-colors').setup({})
	end
    },
    { -- Hex editor
    'RaafatTurki/hex.nvim',
	config = function()
        require('hex').setup({})
	end
    },
}
