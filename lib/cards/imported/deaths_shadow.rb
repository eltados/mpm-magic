
class DeathsShadow < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Death's Shadow"

    @strength = 13
    @toughness = 13
    @cost = 1 # B
    @description =  "Death's Shadow gets -X/-X, where X is your life total."
    @img = "cards/198372.png"
    @mtg_id = 198372
  end

  def self.disabled?; true end

end
    