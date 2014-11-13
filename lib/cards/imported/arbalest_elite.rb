
class ArbalestElite < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Arbalest Elite"

    @strength = 2
    @toughness = 3
    @cost = 4 # 2WW
    @description =  "{2}{White}, {Tap}: Arbalest Elite deals 3 damage to target attacking or blocking creature. Arbalest Elite doesn't untap during your next untap step."
    @img = "cards/220078.png"
    @mtg_id = 220078
  end

  def self.disabled?; true end

end
    