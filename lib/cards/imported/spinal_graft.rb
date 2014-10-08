
class SpinalGraft < Enchantment

  def initialize(owner=nil)
    super(owner)
    @name = "Spinal Graft"

    @cost = 2 # 1B
    @description =  "Enchant creature Enchanted creature gets +3/+3. When enchanted creature becomes the target of a spell or ability, destroy that creature. It can't be regenerated."
    @img = "cards/4688.png"
    @mtg_id = 4688
  end

  def self.disabled?; true end

end
    