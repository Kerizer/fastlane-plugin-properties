require 'spec_helper'

describe Fastlane::Actions::SetPropertiesValueAction do
  describe "Set value in Configs.properties" do
    before do
      copy_properties_file
    end

    it "should change VADER propertie" do
      result = Fastlane::FastFile.new.parse("lane :test do
        get_properties_value(
          key: 'VADER',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      expect(result).to eq("Luke, I am your father.")

      Fastlane::FastFile.new.parse("lane :test do
        set_properties_value(
          key: 'VADER',
          value: 'No, I am your father.',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      result = Fastlane::FastFile.new.parse("lane :test do
        get_properties_value(
          key: 'VADER',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      expect(result).to eq("No, I am your father.")
    end

    it "should add new propertie to Configs.properties" do
      result = Fastlane::FastFile.new.parse("lane :test do
        get_properties_value(
          key: 'Luke',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      expect(result).to eq(nil)

      Fastlane::FastFile.new.parse("lane :test do
        set_properties_value(
          key: 'Luke',
          value: 'Nooooooo!',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      result = Fastlane::FastFile.new.parse("lane :test do
        get_properties_value(
          key: 'Luke',
          path: '/tmp/fastlane/tests/Configs.properties'
        )
      end").runner.execute(:test)
      expect(result).to eq("Nooooooo!")
    end

    after do
      remove_properties_file
    end
  end
end
