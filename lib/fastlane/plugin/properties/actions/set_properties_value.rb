require 'fastlane/action'
require 'java-properties'
require_relative '../helper/properties_helper'

module Fastlane
  module Actions
    class SetPropertiesValueAction < Action
      def self.run(params)
        content = JavaProperties.load(params[:path])
        content[params[:key].to_sym] = params[:value]
        JavaProperties.write(content, params[:path])
      end

      def self.description
        "Sets a value of a setting in .properties file."
      end

      def self.authors
        ["Pavlo Pakholka"]
      end

      def self.return_value
        nil  
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
          FastlaneCore::ConfigItem.new(key: :value,
            env_name: "PROPERIES_SET_VALUE_PARAM_VALUE",
            description: "Value to set",
            skip_type_validation: true, # skipping type validation as fastlane converts YES/NO/true/false strings into booleans
            type: String,
            optional: false
          ),
          FastlaneCore::ConfigItem.new(key: :path,
            env_name: "PROPERIES_GET_VALUE_PARAM_PATH",
            description: "Path to .properies file you want to update",
            type: String,
            optional: false,
            verify_block: proc do |value|
              UI.user_error!("Couldn't find .properties file at path '#{value}'") unless File.exist?(File.expand_path(value))
            end
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
