require 'spec_helper'

describe Fastlane::Actions::IncrementVersionCodeInPropertiesFileAction do
  describe "Set value in Configs.properties" do
    before do
      copy_properties_file
    end

    it "Should increment VERSION_CODE inside Configs.properties" do
      result = Fastlane::FastFile.new.parse("lane :test do
        get_properties_value(
          key: 'VERSION_CODE',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      expect(result).to eq("15")

      Fastlane::FastFile.new.parse("lane :test do
        increment_version_code_in_properties_file(
          key: 'VERSION_CODE',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      result = Fastlane::FastFile.new.parse("lane :test do
        get_properties_value(
          key: 'VERSION_CODE',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      expect(result).to eq("16")
    end

    after do
      remove_properties_file
    end
  end
end
