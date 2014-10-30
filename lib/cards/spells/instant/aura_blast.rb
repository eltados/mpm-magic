class AuraBlast < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Aura Blast"

    @cost = 2 # 1W
    @description =  "Destroy target enchantment. Draw a card."
    @img = "cards/26382.png"
    @mtg_id = 26382
  end


  def can_target(target)
    target.is_a?(Enchantment) && target.in_play?
  end


  def can_be_played
    super && world.permanents.any?{ |p| self.can_target(p) }
  end

  def play!
    super(target)
    target.destroy!
    player.draw!
  end

  def positive?
    false
  end
end
