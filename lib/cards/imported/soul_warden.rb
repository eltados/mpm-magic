
class SoulWarden < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Soul Warden"

    @strength = 1
    @toughness = 1
    @cost = 1 # W
    @description =  "Whenever another creature enters the battlefield, you gain 1 life."
    @img = "cards/129740.png"
    @mtg_id = 129740
  end

  def self.disabled?; true end

end
    