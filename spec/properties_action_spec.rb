describe Fastlane::Actions::PropertiesAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The properties plugin is working!")

      Fastlane::Actions::PropertiesAction.run(nil)
    end
  end
end
