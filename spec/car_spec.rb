require 'car'

describe Car do
  it_behaves_like('a standard vehicle')

  describe ".colors" do
    let(:colors) { ['blue', 'black', 'red', 'green'] }
    it "returns an array of color names" do
      expect(Car.new.colors).to match_array(colors)
    end
  end

  describe '#full_name' do
    let(:honda) { Car.new({ make: 'Honda', year: 2004, color: 'blue' }) }
    let(:new_car) { Car.new }

    it "returns a string in the expected form" do
      expect(honda.full_name).to eq '2004 Honda (blue)'
    end

    context "when initialized with no arguments" do
      it "returns a string using default values" do
        expect(new_car.full_name).to eq '2007 Volvo (unknown)'
      end
    end
  end
end
