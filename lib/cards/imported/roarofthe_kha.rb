
class RoaroftheKha < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Roar of the Kha"

    @cost = 2 # 1W
    @description =  "Choose one - Creatures you control get +1/+1 until end of turn; or untap all creatures you control. Entwine {1}{White}(Choose both if you pay the entwine cost.)"
    @img = "cards/48092.png"
    @mtg_id = 48092
  end

  def self.disabled?; true end

end
    