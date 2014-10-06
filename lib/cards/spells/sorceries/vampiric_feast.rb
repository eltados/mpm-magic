
class VampiricFeast < Sorcery

  def initialize(owner=nil)
    super(owner)
    @name = "Vampiric Feast"

    @cost = 7 # 5BB
    @description =  "Vampiric Feast deals 4 damage to target creature and you gain 4 life."
    @img = "cards/4243.png"
    @mtg_id = 4243
  end

  def play!
    super
    player.target_action = TargetAction.new(self, self)
  end

  def can_target(target)
    target.is_a? Creature
  end

  def can_be_played
    super && world.permanents.any?{ |p| self.can_target(p) }
  end

  def execute_with_target!(target)
    super(target)
    target.hit! 4
    @owner.health += 4
  end

  def positive?
    false
  end


end
