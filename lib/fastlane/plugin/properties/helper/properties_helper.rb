require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class PropertiesHelper
      # Available in actions as `Helper::PropertiesHelper.update_semver_version`
      def self.update_semver_version(type, version_name)
        type = type || 'minor'
        version = version_name.split(".")
        major = version[0].to_i
        minor = version[1].to_i
        patch = version[2].to_i
      
        if type == 'major'
          major+=1
          minor = 0
          patch = 0
        end
      
        if type == 'minor'
          minor+=1
          patch = 0
        end
      
        if type == 'patch'
          patch+=1
        end
      
        return "#{major}.#{minor}.#{patch}"
      end
    end
  end
end
