if require('util').is_module_available 'impatient' then
  require 'impatient'
end

require 'plugins'
require 'config'
require 'mapping'
require('project-config').update_config()
require('machine-config').on_start()
