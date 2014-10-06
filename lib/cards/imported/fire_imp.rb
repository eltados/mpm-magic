
class FireImp < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Fire Imp"

    @strength = 2
    @toughness = 1
    @cost = 3 # 2R
    @description =  "When Fire Imp enters the battlefield, it deals 2 damage to target creature."
    @img = "cards/4337.png"
    @mtg_id = 4337
  end

  def self.disabled?; true end

end
    