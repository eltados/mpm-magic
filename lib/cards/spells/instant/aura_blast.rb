class AuraBlast < Instant

  def initialize(owner=nil)
    super(owner)
    @name = "Aura Blast"

    @cost = 2 # 1W
    @description =  "Destroy target enchantment. Draw a card."
    @img = "cards/26382.png"
    @mtg_id = 26382
  end


  def play!
    super
    player.target_action = TargetAction.new(self, self)
  end

  def can_target(target)
    target.is_a? Enchantment
  end

  def can_be_played
    owner.mana_pool.can_pay?(self.cost) && \
    [player.opponent.permanents, player.permanents ].flatten.any?{ |p| self.can_target(p) }
  end

  def execute_with_target!(target)
    super(target)
    target.destroy!
    player.draw!
  end

  def positive?
    false
  end
end
