require "chef/node"

# rubocop:disable Style/ClassAndModuleChildren
module Core
  module Helpers
    require_relative "helpers/attr_helper"
  end
end
# rubocop:enable Style/ClassAndModuleChildren

Chef::Node.send(:include, Core::Helpers::AttrHelper)
