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

  describe "collection matchers" do
    it "matches arrays" do
      array = [1, 2, 3]

      expect(array).to include(3)
      expect(array).to include(1, 3)

      expect(array).to start_with(1)
      expect(array).to end_with(3)

      expect(array).to match_array([3, 2, 1])
      expect(array).not_to match_array([1, 2])

      expect(array).to contain_exactly(3, 2, 1)   # similar to match array
      expect(array).not_to contain_exactly(3)     # but use individual arguments
    end

    it "matches hashes" do
      hash = { a: 1, b: 2, c: 3 }

      expect(hash).to include(:a)
      expect(hash).to include(a: 1)

      expect(hash).to include(a: 1, c: 3)
      expect(hash).to include({ a: 1, c: 3 })

      expect(hash).not_to include({ 'a' => 1, 'c' => 3 })
    end
  end

  describe "other useful matchers" do
    it "matches strings with a regex" do
      # This matcher is a good way to 'spot check' strings
      string = "The order has been received."
      expect(string).to match(/order(.)+received/)

      expect('123').to match(/\d{3}/)
      expect(123).not_to match(/\d{3}/)

      email = 'someone@somewhere.com'
      expect(email).to match(/\A\w+@\w+\.\w{3}\Z/)
    end

    it "matches other object types" do
      expect('test').to be_instance_of String     # strict, actual value must be an instance/direct descendant of expected value
      expect('test').to be_an_instance_of String  # alias of #be_instance_of

      expect('test').to be_kind_of String     # loose, expected value can be anywhere in the hierarchy (superclass, module)
      expect('test').to be_a_kind_of String   # alias, #be_kind_of

      expect('test').to be_a String  # alias #be_kind_of
      expect([1, 2, 3]).to be_an Array  # alias #be_kind_of
    end

    it "matches objects with #respond_to" do
      string = 'test'
      expect(string).to respond_to :length
      expect(string).not_to respond_to :sort
    end

    it "matches class instances with #have_attributes" do
      class Car
        attr_accessor :make, :year, :color
      end

      car = Car.new
      car.make = 'Dodge'
      car.year = 2010
      car.color = 'green'

      expect(car).to have_attributes(color: 'green')
      expect(car).to have_attributes(make: 'Dodge', year: 2010, color: 'green')
    end

    it "matches anything with #satisfy" do
      # this is the most flexible matcher
      # not used often, use the rest whenever possible
      expect(10).to satisfy do |value|
        (value >= 5) && (value <= 10) && (value % 2 == 0)
      end
    end
  end

  describe "predicate matchers" do
    it "matches be_* to custom methods ending in ?" do
      # drops "be_", adds "?" to end, calls method on object
      # can use these when methods end in "?", require no arguments,
      # and return true/false

      # with built-in methods
      expect([]).to be_empty  # [].empty?
      expect(1).to be_integer  # 1.integer?
      expect(0).to be_zero     # 0.zero?
      expect(1).to be_nonzero  # 1.nonzero?
      expect(1).to be_odd      # 1.odd?
      expect(2).to be_even     # 2.even?

      # be_nil is an example of this too

      # with custom methods
      class Product
        def visible?; true; end
      end
      product = Product.new

      expect(product).to be_visible   # product.visible?
      expect(product.visible?).to be true  # exactly the same as this
    end

    it "matches have_* to custom methods like has_*" do
      # changes "have_" to "has_", adds "?" to end, calls method on object
      # can use these when methods start with "has_", end in "?"
      # and return true/false; can have arguments but not required

      # with built-in methods
      class Customer
        def has_pending_order?; true; end
      end
      customer = Customer.new

      expect(customer).to have_pending_order  # customer.has_pending_order?
      expect(customer.has_pending_order?).to be true  # same as this
    end
  end
end
