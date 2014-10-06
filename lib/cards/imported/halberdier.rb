
class Halberdier < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Halberdier"

    @strength = 3
    @toughness = 1
    @cost = 4 # 3R
    @description =  "First strike"
    @img = "cards/29751.png"
    @mtg_id = 29751
  end

  def self.disabled?; true end

end
