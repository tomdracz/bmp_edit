shared_examples "a method requiring bitmap" do
  let(:bitmap) { nil }

  it "returns an error if there is no bitmap" do
    expect { subject.execute }.to raise_error(NoBitmapError)
  end
end
