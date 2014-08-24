require_relative 'deck'
require_relative 'hand'
require_relative 'graveyard'

class Player
  attr_accessor :name, :health , :permanents, :deck, :hand, :graveyard

  DEFAULTS = {
     name:  "Player",
     health: 20,
     deck: Deck.new,
     hand: Hand.new,
     graveyard: Graveyard.new,
  }

  def initialize(options={})
    options = DEFAULTS.merge(options)
    options.each {|k,v| send("#{k}=",v)}
    @permanents = []
  end

  def alive?
    health > 0
  end

  def dead?
    !alive?
  end

  def summon!(creature)
    creature.owner = self
    @permanents << creature
  end

  def attack!(player)
    Battle.new(self, player)
  end


  def draw!
    raise 'No More Card to Draw'   if deck.size ==0
    hand << deck.draw!
  end

  def play!(card)
    hand.cards.delete card
    permanents << card
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
