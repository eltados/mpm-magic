
class UnrulyMob < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Unruly Mob"

    @strength = 1
    @toughness = 1
    @cost = 2 # 1W
    @description =  "Whenever another creature you control dies, put a +1/+1 counter on Unruly Mob."
    @img = "cards/220389.png"
    @mtg_id = 220389
  end

  def self.disabled?; true end

end
