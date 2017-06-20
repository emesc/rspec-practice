describe "Expectation Matchers" do
  describe "equivalence matchers" do
    context "loose equality with #eq" do
      it "checks for strings" do
        a = "2 cats"
        b = "2 cats"
        expect(a).to eq b
        expect(a).to be == b  # synonym for #eq
      end

      it "checks for numbers" do
        c = 17
        d = 17.0
        expect(c).to eq d  # different types, but close enough
      end
    end

    context "value equality with #eql" do
      it "checks for strings" do
        a = "2 cats"
        b = "2 cats"
        expect(a).to eql b  # just a little stricter
      end

      it "checks for numbers" do
        c = 17
        d = 17.0
        expect(c).not_to eql d  # not the same, close doesn't count
      end
    end

    context "identity equality with #equal" do
      it "checks for strings" do
        a = "2 cats"
        b = "2 cats"
        expect(a).not_to equal b  # same value, different object

        c = b
        expect(b).to equal c
        expect(b).to be c
      end

      it "checks for numbers" do
        c = 17
        d = 17.0
        expect(c).not_to equal d
      end
    end
  end
end
