
class CudgelTroll < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Cudgel Troll"

    @strength = 4
    @toughness = 3
    @cost = 4 # 2GG
    @description =  "{Green}: Regenerate Cudgel Troll. (The next time this creature would be destroyed this turn, it isn't. Instead tap it, remove all damage from it, and remove it from combat.)"
    @img = "cards/221895.png"
    @mtg_id = 221895
  end

  def self.disabled?; true end

end
