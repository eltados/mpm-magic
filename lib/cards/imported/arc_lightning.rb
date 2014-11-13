
class ArcLightning < Sorcery

  def initialize(owner=nil)
    super(owner)
    @name = "Arc Lightning"

    @cost = 3 # 2R
    @description =  "Arc Lightning deals 3 damage divided as you choose among one, two, or three target creatures and/or players."
    @img = "cards/5733.png"
    @mtg_id = 5733
  end

  def self.disabled?; true end

end
    