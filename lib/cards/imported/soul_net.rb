
class SoulNet < Enchantment # Artifact

  def initialize(owner=nil)
    super(owner)
    @name = "Soul Net"

    @cost = 1 # 1
    @description =  "Whenever a creature is put into a graveyard from the battlefield, you may pay {1}. If you do, you gain 1 life."
    @img = "cards/3812.png"
    @mtg_id = 3812
  end

  def self.disabled?; true end

end
    
