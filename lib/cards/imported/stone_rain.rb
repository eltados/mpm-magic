
class StoneRain < Sorcery

  def initialize(owner=nil)
    super(owner)
    @name = "Stone Rain"

    @cost = 3 # 2R
    @description =  "Destroy target land."
    @img = "cards/2307.png"
    @mtg_id = 2307
  end

  def self.disabled?; true end

end
    