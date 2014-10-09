
class AwakentheBear < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Awaken the Bear"

    @cost = 3 # 2G
    @description =  "Target creature gets +3/+3 and gains trample until end of turn."
    @img = "cards/386484.png"
    @mtg_id = 386484
  end

  def can_target(target)
    target.is_a? Creature
  end

  def can_be_played
    super && world.permanents.any?{ |p| self.can_target(p) }
  end

  def play_with_target!(target)
    super(target)
    target.add_temp_abilities  [ Trample ]
    target.attack_bonus += 3
    target.dmg -= 3
  end

end
