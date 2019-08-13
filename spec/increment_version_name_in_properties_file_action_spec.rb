require 'spec_helper'

describe Fastlane::Actions::IncrementVersionNameInPropertiesFileAction do
  describe "Set value in Configs.properties" do
    before do
      copy_properties_file
    end

    it "Should increment VERSION_CODE inside Configs.properties" do
      result = Fastlane::FastFile.new.parse("lane :test do
        get_properties_value(
          key: 'VERSION_NAME',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      expect(result).to eq("0.20.0")

      Fastlane::FastFile.new.parse("lane :test do
        increment_version_name_in_properties_file(
          key: 'VERSION_NAME',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      result = Fastlane::FastFile.new.parse("lane :test do
        get_properties_value(
          key: 'VERSION_NAME',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      expect(result).to eq("0.21.0")

      Fastlane::FastFile.new.parse("lane :test do
        increment_version_name_in_properties_file(
          key: 'VERSION_NAME',
          update_type: 'major',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      result = Fastlane::FastFile.new.parse("lane :test do
        get_properties_value(
          key: 'VERSION_NAME',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      expect(result).to eq("1.0.0")

      Fastlane::FastFile.new.parse("lane :test do
        increment_version_name_in_properties_file(
          key: 'VERSION_NAME',
          update_type: 'patch',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      result = Fastlane::FastFile.new.parse("lane :test do
        get_properties_value(
          key: 'VERSION_NAME',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      expect(result).to eq("1.0.1")
    end

    after do
      remove_properties_file
    end
  end
end
