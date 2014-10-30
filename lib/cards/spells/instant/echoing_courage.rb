
class EchoingCourage < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Echoing Courage"

    @cost = 2 # 1G
    @description =  "Target creature and all other creatures with the same name as that creature get +2/+2 until end of turn."
    @img = "cards/370393.png"
    @mtg_id = 370393
  end

  def can_target(target)
    target.is_a?(Creature) && target.in_play?
  end

  def can_be_played
    super && world.permanents.any?{ |p| self.can_target(p) }
  end

  def play!
    super
    world.creatures.select{ |c| target.name == c.name }.each do |creature|
      creature.attack_bonus += 2
      creature.dmg -=2
    end
  end

  def positive?
    true
  end


end
