require_relative 'land'
class Mountain < Land

  def initialize(options={})
    super
    @name = "Mountain"
    @img = "http://fc02.deviantart.net/fs71/i/2013/036/9/3/the_dark_mountain_by_skyehopper-d5tzupi.jpg"
  end

end
