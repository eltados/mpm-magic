
class RuthlessCullblade < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Ruthless Cullblade"

    @strength = 2
    @toughness = 1
    @cost = 2 # 1B
    @description =  "Ruthless Cullblade gets +2/+1 as long as an opponent has 10 or less life."
    @img = "cards/194678.png"
    @mtg_id = 194678
  end

  def self.disabled?; true end

end
    