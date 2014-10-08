
class WaveofReckoning < Sorcery

  def initialize(owner=nil)
    super(owner)
    @name = "Wave of Reckoning"

    @cost = 5 # 4W
    @description =  "Each creature deals damage to itself equal to its power."
    @img = "cards/19659.png"
    @mtg_id = 19659
  end

  def play!
    super
    world.permanents.select{ |c| c.is_a?(Creature) }.each do |creature|
      creature.hit! creature.attack
    end
  end

end
