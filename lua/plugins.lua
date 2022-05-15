vim.cmd([[
	augroup packer_user_config
	  autocmd!
	  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
]])

return require('packer').startup(function(use)
	-- for packer to host itself
	use 'wbthomason/packer.nvim'

	-- for git
	use {
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup {
				signcolumn = false,
				numhl = true,
			}
		end
	}
end)
