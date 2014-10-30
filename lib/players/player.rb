class Player <Hook
  attr_accessor :name, :health ,:target_action, :permanents, :world, :deck, :hand, :ai, :brain, :graveyard, :mana_pool, :flags , :actions

  def initialize(world=nil)
    @permanents = []
    @deck = []
    @hand = []
    @graveyard = []
    @mana_pool =  ManaPool.new(self)
    @ai =  false
    @flags =  {}
    @health = 20
    @brain = SimpleAi.new(self)
    @actions = [ Next.new(self) ]
  end

  def img
    @ai ? "ai.png" : "player.png"
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


  def draw!(target=nil)
    if deck.size == 0
      health = 0
      return
    end
    card = deck.shift
    card.flags[:new] = true
    hand << card
    world.log Log.new(description: "#{name} draws 1 card#{ "( #{target.name} )" if target}", card: self , action: DrawAction.new , target:target)
  end

  def play!(card)
    return if ! hand.include? card
    hand.delete card
    permanents << card
    card.play!
  end

  def return_in_hand!(card)
    return if ! card.in_play?
    permanents.delete card
    hand << card
  end


  def create_token!(card)
    card.cost = 0
    permanents << card
    card.play!
  end

  def hits_player!(damage , card=nil)
    @health -= damage
    card.flags[:hits_player] = damage
    card.event :hits_player
    world.log Log.new(description:"#{name} : - #{damage} HP #{"( #{card.name} )" if card!= nil}", card: self ,target:card, action: HitAction.new)
  end

  def heal_player!(gain , card)
    @health += gain
    card.flags[:gain_hp] = gain
    card.event :gain_hp
    world.log Log.new(description:"#{name} : + #{gain} HP ( #{card.name} )", card: self ,target:card, action: HitAction.new)
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

  def enchantments
    permanents.select do |card| card.is_a? Enchantment end
  end



  def attack_all!
    creatures.select { |c| c.can? Attack}.each do |creature|
      creature.execute! Attack
    end
  end



  def active?
    stack_playing?
  end

  def my_turn?
    playing?
  end

  def playing?
    self == world.playing_player
  end

  def phase_playing?
    self == world.phase_playing_player
  end

  def stack_playing?
    self == world.stack_playing_player
  end


  def opponent
    world.p1 == self ? world.p2 : world.p1
  end

  def auto_play!
    return nil if !active?
    begin
      brain.play!
    rescue Exception => e
      puts "\n\n@@@@@@@@@@@@@@@@@@@"
      puts e.message
      puts e.backtrace.inspect
      puts "@@@@@@@@@@@@@@@@@@@\n\n"
    end

  end


  def to_param
    "#{object_id}-#{name}"
  end


  def js_id
    "#{object_id}"
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
