class Attack < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Attack"
    @img ="attack.png"
    @description ="Attack with this card"
    @priority =1
  end

  def actionnable?
    super && player.playing? && card.in_play? && world.turn.phase.is_a?(Combat) && \
    card.can_attack
  end

  def execute!
    card.attack!
  end


  def log
    "#{player.name} #{name.downcase}s with #{card.name}"
  end
end
