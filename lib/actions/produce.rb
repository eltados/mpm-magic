class Produce < Action

  def initialize(owner=nil)
    super(owner)
    @name = "Produce"
    @img ="produce.png"
    @description ="Produce mana"
    @priority =2
  end

  def can_be_activated
    card.in_play?  && !already_played? &&  card.can_be_activated
  end

  def execute!
    owner.tap!
    if card.respond_to? :mana_produced
     mana = card.mana_produced
    else
     mana = 1
    end
    player.mana_pool.mana += mana
  end

  def react_time
    0
  end


end
