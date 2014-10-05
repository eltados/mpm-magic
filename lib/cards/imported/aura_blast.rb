
class AuraBlast < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Aura Blast"

    @cost = 2 # 1W
    @description =  "Destroy target enchantment. Draw a card."
    @img = "cards/26382.png"
    @mtg_id = 26382
  end

  def disabled?; true end

end
    