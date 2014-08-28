require_relative 'deck'
require_relative 'hand'
require_relative 'actions/play'
require_relative 'lands/land'
require_relative 'graveyard'
require_relative 'mana_pool'
require_relative 'abilities/summoning_sickness'

class Player
  attr_accessor :name, :health , :permanents, :deck, :hand, :graveyard, :mana_pool, :flags, :played

  DEFAULTS = {
     name:  "Player",
     health: 20,
  }

  def initialize(options={})
    options = DEFAULTS.merge(options)
    options.each {|k,v| send("#{k}=",v)}
    @permanents = []
    @deck = Deck.new
    @hand = Hand.new
    @graveyard =  Graveyard.new
    @mana_pool =  ManaPool.new(self)
    @played =  false
    @flags =  {}
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

  def cards_in_play
    @permanents
  end

  def attack!(player)
    Battle.new(self, player)
  end


  def draw!
    raise 'No More Card to Draw'   if deck.size ==0
    card = deck.draw!
    card.owner = self
    hand << card
  end

  def play!(card)
    hand.cards.delete card
    permanents << card
    card.owner = self
    card.play!
  end


  def unkeep!
    @flags = {}
    @mana_pool.reset!
  end

  def discard!(card)
    hand.cards.delete card
    graveyard << card
  end

  def clean!
    clean_dead_permanents!
    @permanents.each do |c|
      c.reset!
    end
  end

  def clean_dead_permanents!
    dead_permanents = []
    @permanents.each do |c|
      dead_permanents << c if c.dead?
    end
    @permanents -=  dead_permanents
  end

  def lands
    permanents.select do |card| card.is_a? Land end
  end


  def creatures
    permanents.select do |card| card.is_a? Creature end
  end


  def attack_all!
    creatures.select { |c| c.can? Attack}.each do |creature|
      creature.execute! Attack
    end
  end

  def setup!
    20.times do
      deck << Mountain.new
      deck << Forest.new
      deck << Creature.gob
      deck << Creature.elf
    end

    12.times do
      deck << Creature.dragon
    end

    deck.suffle!

    7.times { draw! }
  end

  def playing?
    self == $world.playing_player
  end

  def auto_play!
    land = hand.cards.find {|c| c.is_a?(Land) && c.can?(Play) }
    return land.execute!(Play) if land

    creature = hand.cards.sort_by(&:cost).reverse.find {|c| c.is_a?(Creature) && c.can?(Play) }
    return creature.execute!(Play) if creature

    if $world.turn.phase.is_a?(Combat) && creatures.find { |c| c.can?(Attack) } != nil
      return attack_all!
    end
    if $world.turn.phase.is_a?(DiscardPhase)
      return hand.cards.sort_by(&:cost).reverse[0].execute! Discard
    end
    return $world.turn.next!
  end

  def to_param
    "#{object_id}-#{name}"
  end

  def self.find(id)
    ObjectSpace._id2ref(id.to_i)
  end


end
