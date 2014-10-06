
class ShivsEmbrace < Enchantment

  def initialize(owner=nil)
    super(owner)
    @name = "Shiv's Embrace"

    @cost = 4 # 2RR
    @description =  "Enchant creature Enchanted creature gets +2/+2 and has flying. {Red}: Enchanted creature gets +1/+0 until end of turn."
    @img = "cards/5721.png"
    @mtg_id = 5721
  end

  def disabled?; true end

end
    