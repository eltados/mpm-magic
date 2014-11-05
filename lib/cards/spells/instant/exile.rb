
class Exile < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Exile"

    @cost = 3 # 2W
    @description =  "Destroy target nonwhite attacking creature. You gain life equal to its toughness."
    @img = "cards/15350.png"
    @mtg_id = 15350
  end


  def play!
    super
    target.player.heal_player!(3 , self)
    target.destroy!
  end


  def can_target(target)
    target.is_a?(Creature) && target.in_play?
  end

  def can_be_played
    super && world.permanents.any?{ |p| self.can_target(p) }
  end

  def positive?
    false
  end

end
