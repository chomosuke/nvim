if require 'util'.is_module_available 'machine_specific' then
  require 'machine_specific'
end
require 'plugins'
require 'config'
require 'mapping'
require 'project-config'.update_config()
