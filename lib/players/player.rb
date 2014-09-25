class Player <Hook
  attr_accessor :name, :health ,:target_action, :permanents, :world, :deck, :hand, :ai,  :graveyard, :mana_pool, :flags, :played

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
    raise 'No More Card to Draw'   if deck.size ==0
    hand << deck.shift
    # when_draw
  end

  def play!(card)
    return if ! hand.include? card
    hand.delete card
    permanents << card
    card.play!
  end


  def create_token!(card)
    card.cost = 0
    permanents << card
    card.play!
  end

  def hits_player!(dommage , card)
    @health -= dommage
    card.flags[:hits_player] = dommage
    card.event :hits_player
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
    land = hand.find {|c| c.is_a?(Land) && c.can?(Play) }

    if land
      return land.execute!(Play)
    end

    creature = hand.sort_by(&:cost).reverse.find {|c| puts c ; c.is_a?(Creature) && c.can?(Play) }
    if creature
      return creature.execute!(Play)
    end

    if world.turn.phase.is_a?(Combat) && creatures.find { |c| c.can?(Attack) } != nil
      # c = creatures.select { |c| c.can?(Attack) }

      return attack_all!
    end

    if world.turn.phase.is_a?(BlockPhase)
      attacking_creatures = opponent.creatures.select{ |c| c.flags[:attacking] &&  !c.flags[:blocked] }
      attacking_creatures.each do |attacking_creature|
        creatures.select{ |c| c.can? Block, attacking_creature }.sort_by(&:attack).each do |defending_creature|
          block = defending_creature.action(Block)
          if attacking_creature.attack <  defending_creature.health
            return block.execute_with_target!( attacking_creature )
          end
        end
      end

    end

    if world.turn.phase.is_a?(DiscardPhase) && hand.size >= 8
      return hand.sort_by(&:cost).reverse.first.execute! Discard
    end
    return world.turn.next!
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

end
