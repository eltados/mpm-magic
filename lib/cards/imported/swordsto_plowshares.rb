
class SwordstoPlowshares < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Swords to Plowshares"

    @cost = 1 # W
    @description =  "Exile target creature. Its controller gains life equal to its power."
    @img = "cards/382380.png"
    @mtg_id = 382380
  end

  def self.disabled?; true end

end
    