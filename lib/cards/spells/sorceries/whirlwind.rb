
class Whirlwind < Sorcery

  def initialize(owner=nil)
    super(owner)
    @name = "Whirlwind"

    @cost = 4 # 2GG
    @description =  "Destroy all creatures with flying."
    @img = "cards/20219.png"
    @mtg_id = 20219
  end

  def play!
    super
    world.permanents.select{ |c| c.is_a?(Creature) && c.has_ability(Flying)}.each do |creature_without_flying|
      creature_without_flying.destroy!
    end
  end

end
