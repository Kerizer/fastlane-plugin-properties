require 'spec_helper'

describe Fastlane::Actions::GetPropertiesValueAction do
  describe "Get Version Number from Configs.properties" do
    before do
      copy_properties_file
    end

    it "should return version number from Configs.properties" do
      result = Fastlane::FastFile.new.parse("lane :test do
        get_properties_value(
          key: 'VERSION_NAME',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      expect(result).to eq("0.20.0")
    end

    after do
      remove_properties_file
    end
  end
end
