
class PygmyGiant < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Pygmy Giant"

    @strength = 0
    @toughness = 2
    @cost = 3 # 1RR
    @description =  "{Red}, {Tap}, Sacrifice a creature: Pygmy Giant deals X damage to target creature, where X is a number in the sacrificed creature's text box."
    @img = "cards/74333.png"
    @mtg_id = 74333
  end

  def self.disabled?; true end

end
    