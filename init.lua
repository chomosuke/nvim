local util = require 'util'

if util.is_module_available 'impatient' then
  require 'impatient'
end

require 'plugins'
require 'config'
require 'mapping'
require('machine-config').on_start()
