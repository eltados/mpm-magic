
class SerraAdvocate < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Serra Advocate"

    @strength = 2
    @toughness = 2
    @cost = 4 # 3W
    @description =  "Flying {Tap}: Target attacking or blocking creature gets +2/+2 until end of turn."
    @img = "cards/13162.png"
    @mtg_id = 13162
  end

  def self.disabled?; true end

end
    