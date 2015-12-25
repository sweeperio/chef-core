require "chefspec"
require "chefspec/berkshelf"

Dir["./spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.log_level = :fatal
  config.platform  = "ubuntu"
  config.version   = "14.04"
end
