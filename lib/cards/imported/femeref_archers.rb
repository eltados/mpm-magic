
class FemerefArchers < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Femeref Archers"

    @strength = 2
    @toughness = 2
    @cost = 3 # 2G
    @description =  "{Tap}: Femeref Archers deals 4 damage to target attacking creature with flying."
    @img = "cards/135186.png"
    @mtg_id = 135186
  end

  def self.disabled?; true end

end
    