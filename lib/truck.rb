class Truck
  attr_accessor :make, :year, :color
  attr_reader :wheels
  attr_writer :doors

  def initialize(options={})
    @make = options[:make] || 'Ford'
    @year = (options[:year] || 2007).to_i
    @color = options[:color] || 'unknown'
    @wheels = 4
  end

  def colors
    ['blue', 'black', 'red', 'green', 'white']
  end

  def full_name
    "#{year.to_s} #{make} Truck (#{color})"
  end
end
