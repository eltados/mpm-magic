
class DacksDuplicate < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Dack's Duplicate"

    @strength = 0
    @toughness = 0
    @cost = 4 # 2UR
    @description =  "You may have Dack's Duplicate enter the battlefield as a copy of any creature on the battlefield except it gains haste and dethrone. (Whenever it attacks the player with the most life or tied for most life, put a +1/+1 counter on it.)"
    @img = "cards/382245.png"
    @mtg_id = 382245
  end

  def self.disabled?; true end

end
    