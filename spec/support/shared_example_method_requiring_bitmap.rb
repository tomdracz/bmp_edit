shared_examples "a method requiring bitmap" do
  it "returns an error if there is no bitmap" do
    subject.bitmap = nil
    expect { subject.parse_input(command) }.to raise_error(NoBitmapError)
  end
end
