
class ProdigalSorcerer < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Prodigal Sorcerer"

    @strength = 1
    @toughness = 1
    @cost = 3 # 2U
    @description =  "{Tap}: Prodigal Sorcerer deals 1 damage to target creature or player."
    @img = "cards/1217.png"
    @mtg_id = 1217
    add_abilities [HitAbility]
  end


end
