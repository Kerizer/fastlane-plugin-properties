require 'fastlane/action'
require 'java-properties'

module Fastlane
  module Actions
    class WritePropertiesFileAction < Action
      def self.run(params)
        content = JavaProperties.write(params[:hash], params[:path])
        return content
      end

      def self.description
        "Write any Hash-like structure as a properties file. This action won't create a new file."
      end

      def self.authors
        ["Pavlo Pakholka"]
      end

      def self.return_value
        ''
      end

      def self.details
        # Optional:
        ""
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :key,
            env_name: "PROPERIES_WRITE_HASH_MAP",
            description: "Hashmap you want to convert and write to file",
            optional: false,
            type: Hash),
          FastlaneCore::ConfigItem.new(key: :path,
            env_name: "PROPERIES_WRITE_HASH_PATH",
            description: "Path to .properies file you want to update",
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
