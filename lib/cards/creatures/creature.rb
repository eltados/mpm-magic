class Creature < Card

  attr_accessor  :strength, :toughness, :dmg,  :attack_bonus

  def self.modified_methods
    super + [:strength , :toughness, :dmg, :attack_bonus, :can_attack , :can_block , :can_be_activated , :attack_requires_tap ]
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

  def health=(h)
    @dmg = health - h
  end

  def attack
    strength + attack_bonus
  end


  def attack=(a)
    @attack_bonus = - attack + a
  end

  def value
    toughness  + strength +  attack * 0.5 + dmg * 1.5 + [0,abilities.map(&:value)].flatten.inject{|sum,x| sum + x }
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
    tap! if attack_requires_tap
    flags[:attacking] = true
  end

  def block!(creature)
    @flags[:blocking] = true
    creature.flags[:blocked] = true
    creature.flags[:blocked_by] = [] if creature.flags[:blocked_by] == nil
    creature.flags[:blocked_by] << self
    @flags[:blocked_creature] = creature
  end

  def undo_block!
    @flags.delete :blocking
    @flags[:blocked_creature].flags.delete :blocked
    @flags[:blocked_creature].flags[:blocked_by].delete  self
    @flags.delete :blocked_creature
  end

  def undo_attack!
    untap! if attack_requires_tap
    @flags.delete :attacking
  end

  def can_be_played
    player.playing? &&  ( phase.is_a?(Pre) ||  phase.is_a?(Post) || phase.is_a?(DiscardPhase)  ) && owner.mana_pool.can_pay?(self.cost)
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

  def attack_requires_tap
      true
  end

  def to_s
    "#<#{self.class.name}:#{object_id} #{attack}/#{health}>"
  end

  def would_kill?(creature)
    self.attack >= creature.health
  end

  def would_be_killed_by?(creature)
    creature.would_kill? self
  end


  def play!
    add_abilities [SummoningSickness] if ! has_ability(Haste)
    super
  end


  define_modified_methods


  def when_phase_ends(*args)
    super
    event :destroyed if dead?
  end

  def when_turn_ends(*args)
    super
    @abilities.each do |ability|
      @abilities.delete ability if ! ability.permanent?
    end
    @dmg = 0
    @attack_bonus = 0
    @toughness_bonus = 0
    @flags = {}
  end

  def when_receive_dmg(*args)
    event :destroyed if dead? && !world.turn.phase.is_a?(ResolveCombat)
  end

end
