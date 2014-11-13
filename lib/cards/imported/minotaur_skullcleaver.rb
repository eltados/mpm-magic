
class MinotaurSkullcleaver < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Minotaur Skullcleaver"

    @strength = 2
    @toughness = 2
    @cost = 3 # 2R
    @description =  "Haste When Minotaur Skullcleaver enters the battlefield, it gets +2/+0 until end of turn."
    @img = "cards/373698.png"
    @mtg_id = 373698
  end

  def self.disabled?; true end

end
    