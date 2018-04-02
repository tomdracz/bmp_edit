shared_examples "a method requiring bitmap" do
  let(:bitmap) { nil }

  it "returns an error if there is no bitmap" do
    expect { subject.parse_input(command) }.to raise_error(NoBitmapError)
  end
end
