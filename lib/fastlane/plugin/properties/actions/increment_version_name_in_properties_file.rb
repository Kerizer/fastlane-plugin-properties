require 'fastlane/action'
require 'java-properties'
require_relative '../helper/properties_helper'

module Fastlane
  module Actions
    class IncrementVersionNameInPropertiesFileAction < Action
      def self.run(params)
        content = JavaProperties.load(params[:path])
        value = content[params[:key].to_sym]
        new_value = Helper::PropertiesHelper.update_semver_version(params[:update_type], value)
        content[params[:key].to_sym] = new_value
        JavaProperties.write(content, params[:path])
        return new_value
      end

      def self.description
        "Sets a value of a setting in .properties file."
      end

      def self.authors
        ["Pavlo Pakholka"]
      end

      def self.return_value
        "New version name."  
      end

      def self.details
        # Optional:
        ""
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :key,
            env_name: "PROPERIES_GET_VALUE_PARAM_KEY",
            description: "Key of properie in .properties file",
            optional: false,
            type: String
          ),
          FastlaneCore::ConfigItem.new(key: :path,
            env_name: "PROPERIES_GET_VALUE_PARAM_PATH",
            description: "Path to .properies file you want to update",
            type: String,
            optional: false,
            verify_block: proc do |value|
              UI.user_error!("Couldn't find .properties file at path '#{value}'") unless File.exist?(File.expand_path(value))
            end
          ),
          FastlaneCore::ConfigItem.new(key: :update_type,
            env_name: "PROPERIES_GET_VALUE_PARAM_KEY",
            description: "Key of properie in .properties file",
            optional: true,
            type: String
          )
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
