class Card < Hook

  attr_accessor :name, :owner, :img, :tapped, :actions,  :cost, :flags, :description, :targeted_by_actions
  # attr_reader :abilities

  @@all = {}

  def self.modified_methods
    [ :actions ]
  end

  def self.modified_methods_with_param
   [ ]
  end

  def targets
   actions.map(&:targets).flatten
  end

  def target
   targets.size > 0 ? targets[0] : nil
  end

  def initialize (owner = nil)
    @actions = []
    @abilities = []
    add_action Discard.new
    if !requires_target?
      add_action Play.new(self)
    else
      add_action PlayWith1Target.new(self)
    end
    @cost = 0
    @tapped = false
    @flags = {}
    @owner = owner
    @targeted_by_actions = []
  end

  def targeted_by
   targeted_by_actions.map(&:card)
  end

  def play!
    event :played
  end

  def requires_target?
    respond_to?(:can_target)
  end

  def pay_cost!
    @owner.mana_pool.pay! self.cost
  end

  def add_action action
    action.owner = self
    @actions <<  action
  end

  def remove_action action
    @actions.delete action(action) if(action(action) )
  end

  def can?(action_class, target = nil)
    a = action(action_class)
    return false if a.nil?
    a.can_be_activated == true && \
    ( target ==nil || action(action_class).can_target(target) )
  end

  def execute! action_class
    action(action_class).execute!
  end

  def action(action_class)
    actions.each do |a|
      return a if a.is_a? action_class
    end
    return nil
  end


  def has_action(action)
    actions.any?{ |a| a.is_a? action }
  end


  def add_abilities(abilities)
    @abilities += abilities.map { |a|
      a.new(self)
     }
  end

  def add_temp_abilities(abilities)
    @abilities += abilities.map { |ab_class| ab = ab_class.new(self) ; ab.permanent =false; ab; }
  end

  def has_ability(ability)
    abilities.any?{ |a| a.is_a? ability }
  end

  def tap!
    @tapped = true
    event :tapped
  end

  def untap!
    @tapped = false
    event :untapped
  end


  def tapped?
    tapped
  end

  def in_play?
    self.owner.permanents.include? self
  end

  def in_hand?
    self.owner.hand.include?(self)
  end

  def to_param
    "#{object_id}-#{self.class.name.underscore}"
  end

  def self.find(id)
    ObjectSpace._id2ref(id.to_i)
  end


  def js_id
    "#{object_id}"
  end

  def actionable_actions
    actions.select(&:can_be_activated).sort_by(&:priority)
  end

  def main_action
    actions.select(&:can_be_activated).sort_by(&:priority)[0]
  end

  def self.all

        @@all[self] = ObjectSpace.each_object(self.singleton_class).reject{ |c|
          c == self ||
          c == Creature ||
          c == Land ||
          c == Sorcery ||
          c == Instant ||
          c == Spell ||
          c == Enchantment
        }  if @@all[self].nil?

        @@all[self]
  end


  def player
    @owner
  end

  def opponent
    player.opponent
  end

  def world
    player.world
  end


  def phase
    world.turn.phase
  end


  def inspect
    "#<#{self.class.name}:#{object_id}>"
  end

  def can_be_activated
    !tapped?
  end

  def type
    self.class.superclass.to_s.underscore
  end

  def when_turn_ends(*args)
    super
    @flags = {}
    @targeted_by_actions = {}
  end


  def when_phase_untap(*args)
    super
    untap!
  end

  def event(event, *args)
    method = "when_#{event}".to_sym
    send(method, args) if self.respond_to? method.to_sym
    method = "when_#{event}".to_sym
    @abilities.select do |ability|
        ability.respond_to? method
    end.each  do |ability|
      ability.send method, args
    end
  end

  def destroy!
    event :destroyed
  end

  def sacrify!
    event :destroyed
  end

  def self.disabled?
    false
  end

  def when_destroyed(*args)
    super
    player.world.log Log.new( description: "#{self.name} was destroyed", card:self , action: "die")
    player.permanents.delete self
    player.graveyard << self
  end



  def __modify(original_value , method )
    abilities.flatten.select do |ability|
        ability.respond_to? method
    end.reduce(original_value) do |val,ability|
        ability.send( method, val)
    end
  end

  def abilities
    return @abilities  if player == nil || world == nil || world.enchantments == nil
    [@abilities, world.abilities_for(self)].flatten
  end

  def __modify_with_param(original_value , method, param )
    abilities.select do |ability|
        ability.respond_to? method
    end.reduce(original_value) do |val,ability|
        ability.send( method, val , param)
    end
  end

 def self.define_modified_methods
   # TODO for the moment I need to duplicate that in every sub classes
    self.modified_methods.each do |method|
      define_method "#{method}_with_mod".to_sym do
         __modify( send("#{method}_without_mod".to_sym) , method )
      end
      alias_method_chain method , :mod
    end



    self.modified_methods_with_param.each do |method|
      define_method "#{method}_with_mod".to_sym do |param|
         __modify_with_param( send("#{method}_without_mod".to_sym , param ) , method , param )
      end
      alias_method_chain method , :mod
    end
  end
end
