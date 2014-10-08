
class InfernoFist < Enchantment

  def initialize(owner=nil)
    super(owner)
    @name = "Inferno Fist"

    @cost = 2 # 1R
    @description =  "Enchant creature you control Enchanted creature gets +2/+0.  {Red}, Sacrifice Inferno Fist: Inferno Fist deals 2 damage to target creature or player."
    @img = "cards/383277.png"
    @mtg_id = 383277
  end

  def self.disabled?; true end

end
