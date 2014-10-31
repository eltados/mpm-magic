class GoblinBattleJester < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Goblin Battle Jester"
    @strength = 2
    @toughness = 2
    @type = "Creature"
    @cost = 4 # 3R
    @description =  "Whenever you cast a red spell, target creature can't block this turn."
    @img = "http://4.bp.blogspot.com/_0poJXWIb4sE/TPf5Mo5E4dI/AAAAAAAAALI/vKrkV1A5G1A/s320/goblin hero face.JPG"
    @mtg_id = 278070
  end

  def self.disabled?
    true
  end

end
