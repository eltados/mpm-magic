
class StrongholdAssassin < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Stronghold Assassin"

    @strength = 2
    @toughness = 1
    @cost = 3 # 1BB
    @description =  "{Tap}, Sacrifice a creature: Destroy target nonblack creature."
    @img = "cards/376527.png"
    @mtg_id = 376527
  end

  def self.disabled?; true end

end
    