class Player <Hook
  attr_accessor :name, :health ,:target_action, :permanents, :world, :deck, :hand, :ai, :brain, :graveyard, :mana_pool, :flags, :played

  def initialize(world=nil)
    @permanents = []
    @deck = []
    @hand = []
    @graveyard = []
    @mana_pool =  ManaPool.new(self)
    @played =  false
    @ai =  false
    @flags =  {}
    @health = 20
    @brain = SimpleAi.new(self)
  end

  def img
    "player.png"
  end

  def alive?
    health > 0
  end

  def played?
    played
  end

  def dead?
    !alive?
  end


  def draw!
    if deck.size == 0
      health = 0
      return
    end
    hand << deck.shift
    # when_draw
  end

  def play!(card)
    return if ! hand.include? card
    hand.delete card
    permanents << card
    card.play!
  end


  def play_with_target!(card, target)
    return if ! hand.include? card
    hand.delete card
    permanents << card
    card.play_with_target!(target)
  end

  def create_token!(card)
    card.cost = 0
    permanents << card
    card.play!
  end

  def hits_player!(damage , card)
    @health -= damage
    card.flags[:hits_player] = damage
    card.event :hits_player
    world.log Log.new(description:"#{card.name} hits #{name} :  - #{damage} HP", card: self ,target:card, action: "-#{damage}")
  end

  def discard!(card)
    return if ! hand.include? card
    hand.delete card
    graveyard << card
    card.event :enters_graveyard
  end

  def move_to_graveyard!(card)
    return if ! permanents.include? card
    permanents.delete card
    graveyard << card
    card.event :enters_graveyard
  end



  def lands
    permanents.select do |card| card.is_a? Land end
  end


  def creatures
    permanents.select do |card| card.is_a? Creature end
  end


  def spells
    permanents.select do |card| card.is_a? Spell end
  end



  def attack_all!
    creatures.select { |c| c.can? Attack}.each do |creature|
      creature.execute! Attack
    end
  end




  def active?
    ( playing? &&  !world.turn.phase.is_a?(BlockPhase) ) || ( !playing? &&  world.turn.phase.is_a?(BlockPhase) )
  end

  def playing?
    self == world.playing_player
  end

  def opponent
    world.p1 == self ? world.p2 : world.p1
  end

  def auto_play!
    return nil if !active?
    brain.play!
  end


  def to_param
    "#{object_id}-#{name}"
  end

  def self.find(id)
    ObjectSpace._id2ref(id.to_i)
  end

  def when_turn_ends
    @mana_pool.reset!
    @flags = {}
  end



  def when_phase_end
    @target_action =nil
  end

  def when_phase_draw
    draw!
  end

  def to_s
    "#<Player:#{object_id} name=#{name}>"
  end

end
