$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'simplecov'

# SimpleCov.minimum_coverage 95
SimpleCov.start

# This module is only used to check the environment is currently a testing env
module SpecHelper
end

require 'fastlane' # to import the Action super class
require 'fastlane/plugin/properties' # import the actual plugin

Fastlane.load_actions # load other actions (in case your plugin calls other actions or shared values)

def copy_properties_file
  FileUtils.mkdir_p("/tmp/fastlane/tests")
  source = "./spec/assets/Configs.properties"
  destination = "/tmp/fastlane/tests/Configs.properties"

  FileUtils.cp_r(source, destination)
end

def remove_properties_file
  FileUtils.rm_r("/tmp/fastlane/tests")
end
