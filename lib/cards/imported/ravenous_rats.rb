
class RavenousRats < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Ravenous Rats"

    @strength = 1
    @toughness = 1
    @cost = 2 # 1B
    @description =  "When Ravenous Rats enters the battlefield, target opponent discards a card."
    @img = "cards/45286.png"
    @mtg_id = 45286
  end

  def self.disabled?; true end

end
    