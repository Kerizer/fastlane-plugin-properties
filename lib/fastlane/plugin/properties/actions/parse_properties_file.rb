require 'fastlane/action'
require 'java-properties'

module Fastlane
  module Actions
    class ParsePropertiesFileAction < Action
      def self.run(params)
        content = JavaProperties.load(params[:path])
        return content
      end

      def self.description
        "Load .properties file and returns it as a ruby hash-map."
      end

      def self.authors
        ["Pavlo Pakholka"]
      end

      def self.return_value
        'Content of properties file.'
      end

      def self.details
        # Optional:
        ""
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :path,
            env_name: "PROPERIES_READ_HASH_PATH",
            description: "Path to .properies file you want to read",
            type: String,
            optional: false,
            verify_block: proc do |value|
              UI.user_error!("Couldn't find .properties file at path '#{value}'") unless File.exist?(File.expand_path(value))
            end)
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
