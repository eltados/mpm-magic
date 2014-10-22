
class AngelicPage < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Angelic Page"

    @strength = 1
    @toughness = 1
    @cost = 2 # 1W
    @description =  "Flying {Tap}: Target attacking or blocking creature gets +1/+1 until end of turn."
    @img = "cards/197009.png"
    @mtg_id = 197009
  end

  def self.disabled?; true end

end
    