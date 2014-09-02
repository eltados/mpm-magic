class Creature < Card

  attr_accessor  :strength, :toughness, :dmg, :abilities, :attack_bonus

  $modified_methods = [:strength , :toughness, :dmg, :attack_bonus, :actions, :can_attack , :can_block  ]
  $modified_methods_with_param = [ :can_be_blocked_by ]

  def initialize(owner=nil)
    super(owner)
    @abilities = []
    @dmg = 0
    @attack_bonus = 0
    @strength = 1
    @toughness = 1
    add_action Attack.new
    add_action UndoAttack.new
    add_action Block.new
    add_action UndoBlock.new
  end

  def health
    toughness - dmg
  end

  def attack
    strength + attack_bonus
  end

  def alive?
    health > 0
  end

  def dead?
    !alive?
  end

  def attack!
    tap!
    flags[:attacking] = true
  end

  def block!(creature)
    @flags[:blocking] = true
    creature.flags[:blocked] = true
    @flags[:blocked_creature] = creature
  end

  def undo_block!
    @flags[:blocking] = nil
    @flags[:blocked_creature].flags[:blocked] = nil
    @flags[:blocked_creature] = nil
  end



  def undo_attack!
    untap!
    flags[:attacking] = nil
  end

  def can_be_played?
    owner.mana_pool.can_pay? self.cost
  end

  def activable?
    !abilities.include?(SummoningSickness) && !tapped?
  end

  def can_attack
    !tapped? && flags[:attacking] == nil
  end

  def can_block
    !tapped? && flags[:blocking] == nil
  end

  def can_block_creature(creature)
    can_block && creature.can_be_blocked_by(self)
  end

  def can_block_any(creatures)
    creatures.each do |attacking_creature|
      return true if can_block_creature(attacking_creature)
    end
    false
  end

  def can_be_blocked_by(creature)
    true
  end

  def add_abilities(abilities)
    @abilities += abilities.map { |a| a.new(self) }
  end


  def play!
    abilities << SummoningSickness.new(self)
    super
  end




  def __modify(original_value , method )
    @abilities.select do |ability|
        ability.respond_to? method
    end.reduce(original_value) do |val,ability|
        ability.send( method, val)
    end
  end


  $modified_methods.each do |method|
    define_method "#{method}_with_mod".to_sym do
       __modify( send("#{method}_without_mod".to_sym) , method )
    end
    alias_method_chain method , :mod
  end



  def __modify_with_param(original_value , method, param )
    @abilities.select do |ability|
        ability.respond_to? method
    end.reduce(original_value) do |val,ability|
        ability.send( method, val , param)
    end
  end

  $modified_methods_with_param.each do |method|
    define_method "#{method}_with_mod".to_sym do |param|
       __modify_with_param( send("#{method}_without_mod".to_sym , param ) , method , param )
    end
    alias_method_chain method , :mod
  end



  # def __modify(original_value , method)
  #   @abilities.select do  |ability|
  #       ability.respond_to? method
  #   end.reduce(original_value) do |val,ability|
  #       ability.send( method, val )
  #   end
  # end
  #
  #
  # $modified_methods.each do |method|
  #   define_method "#{method}_with_mod".to_sym do
  #      __modify( send("#{method}_without_mod".to_sym) , method)
  #   end
  #   alias_method_chain method , :mod
  # end



  def when_phase_ends
    super
    event :dead if dead?
  end

  def when_turn_ends
    super
    @abilities.each do |ability|
      self.abilities.delete ability if ! ability.permanent?
    end
    @dmg = 0
    @attack_bonus = 0
  end

  def when_dead
    super
    player.world.logs << "#{owner.name} loses his #{self.name}"
    player.permanents.delete self
    player.graveyard << self
  end

  def event(event)
    super
    method = "when_#{event}".to_sym
    @abilities.select do |ability|
        ability.respond_to? method
    end.each  do |ability|
      ability.send method
    end
  end

end
