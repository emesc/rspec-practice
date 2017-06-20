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

  describe "truthiness matchers" do
    it "matches true/false" do
      expect(1 < 2).to be true
      expect(1 > 2).to be false

      expect('foo').not_to be true  # the string is not exactly true
      expect(nil).not_to be false  # nil is not exactly false
      expect(0).not_to be false   # 0 is not exactly false
    end

    it "matches truthy/falsey" do
      expect(1 < 2).to be_truthy
      expect(1 > 2).to be_falsey

      expect('foo').to be_truthy  # any value counts as true
      expect(nil).to be_falsey    # nil counts as false
      expect(0).not_to be_falsey  # but 0 is still not falsey enough
    end

    it "matches nil" do
      expect(nil).to be_nil  # either way works
      expect(nil).to be nil

      expect(false).not_to be_nil   # nil only, just like #nil?
      expect(0).not_to be_nil       # nil only, just like #nil?
    end
  end

  describe "numeric comparison matchers" do
    it "matches less than/greater than" do
      expect(10).to be > 9
      expect(10).to be >= 10
      expect(10).to be <= 10
      expect(9).to be < 10
    end

    it "matches numeric ranges" do
      expect(10).to be_between(5, 10).inclusive
      expect(10).not_to be_between(5, 10).exclusive
      expect(10).to be_within(1).of(11)
      expect(5..10).to cover(9)
    end
  end
end
