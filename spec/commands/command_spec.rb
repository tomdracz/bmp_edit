require_relative "../../lib/commands/command"

describe Commands::Command do
  subject { described_class }
  describe "#execute" do
    it "raises a NonImplementedError" do
      expect { subject.execute }.to raise_error(NotImplementedError)
    end
  end
end
