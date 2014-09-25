class Creature < Card

  attr_accessor  :strength, :toughness, :dmg,  :attack_bonus

  def self.modified_methods
    super + [:strength , :toughness, :dmg, :attack_bonus, :can_attack , :can_block , :can_be_activated ]
  end

  def self.modified_methods_with_param
   super + [ :can_be_blocked_by ]
  end

  def initialize(owner=nil)
    super(owner)
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

  def hit!(hit_points)
    @dmg += hit_points
    event :receive_dmg
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
    creature.flags[:blocked_by] = self
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

  def can_be_played
    owner.playing? &&  ( phase.is_a?(Pre) ||
        phase.is_a?(Post) ||
        phase.is_a?(DiscardPhase)  ) && owner.mana_pool.can_pay?(self.cost)
  end

  def can_be_activated
    !tapped?
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

  def destroy!
    event :dead
  end

  def sacrify!
    event :dead
  end


  def play!
    add_abilities [SummoningSickness]
    super
  end


  define_modified_methods


  def when_phase_ends(*args)
    super
    event :dead if dead?
  end

  def when_turn_ends(*args)
    super
    @abilities.each do |ability|
      self.abilities.delete ability if ! ability.permanent?
    end
    @dmg = 0
    @attack_bonus = 0
    @toughness_bonus = 0
  end

  def when_dead(*args)
    super
    player.world.logs << "#{owner.name} loses his #{self.name}"
    player.permanents.delete self
    player.graveyard << self
  end

  def when_receive_dmg(*args)
    event :dead if dead?
  end


  def event(event, *args)
    super(event , args)
    method = "when_#{event}".to_sym
    @abilities.select do |ability|
        ability.respond_to? method
    end.each  do |ability|
      ability.send method, args
    end
  end

end
