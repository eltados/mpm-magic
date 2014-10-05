class Attack < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Attack"
    @img ="attack.png"
    @description ="Attack with this card"
    @priority =1
  end

  def can_be_activated
    super && player.playing? && phase.is_a?(Combat) && card.can_attack
  end

  def execute!
    super
    card.attack!
  end


  def log
    "#{player.name} #{name.downcase}s with #{card.name}"
  end
end
