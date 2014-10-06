
class WolverinePack < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Wolverine Pack"

    @strength = 2
    @toughness = 4
    @cost = 4 # 2GG
    @description =  "Rampage 2 (Whenever this creature becomes blocked, it gets +2/+2 until end of turn for each creature blocking it beyond the first.)"
    @img = "cards/4027.png"
    @mtg_id = 4027
  end

  def self.disabled?; true end

end
