require_relative 'deck'
require_relative 'hand'
require_relative 'graveyard'
require_relative 'abilities/summoning_sickness'

class Player
  attr_accessor :name, :health , :permanents, :deck, :hand, :graveyard

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
  end

  def alive?
    health > 0
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


end
