require_relative '../card'
require_relative '../abilities/summoning_sickness'
require_relative '../abilities/haste'
require_relative '../abilities/flying'
require_relative '../abilities/heal'
require_relative '../actions/attack'
require_relative '../actions/undo_attack'
require_relative '../actions/block'
class Creature < Card

  attr_accessor  :strength, :toughness, :dmg, :abilities,  :attack_bonus

  DEFAULTS = {
     dmg:  0,
     attack_bonus: 0,
     tapped: false
  }.freeze

  def initialize(options={})
    super
    options = DEFAULTS.merge(options)
    options.each {|k,v| send("#{k}=",v)}
    @abilities = []
    add_action Attack.new
    add_action UndoAttack.new
    add_action Block.new
  end

  def health
    toughness - dmg
  end

  def add_ability ability
    ability.owner = self
    @abilities <<  ability
  end

  def has_ability?(ability_class)
    ability(ability_class) != nil
  end


  def remove_ability(ability_class)
    puts "#{ability_class}"
    ability = self.ability(ability_class)
    puts "#{ability}"

    @abilities.delete ability if ability!=nil
  end

  def ability(ability_class)
    @abilities.each do |a|
      return a if a.is_a? ability_class
    end
    return nil
  end


  def reset!
    @dmg = 0
    @attack_bonus = 0
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

  def kill!
    player = owner
    player.permanents.delete self
    player.graveyard << self
  end

  def unkeep!
    super
    @abilities.each do |ability|
      self.abilities.delete ability if ! ability.permanent?
    end
    reset!
  end

  def attack!
    tap!
    flags[:attacking] = true
  end

  def block!(creature)
    @flags[:blocking] = true
    creature.flags[:blocked] = true
    puts "#{self.name} blocks #{creature}"
    @flags[:blocked_creature] = creature
  end



  def undo_attack!
    untap!
    flags[:attacking] = nil
  end

  def can_be_played?
    owner.mana_pool.can_pay? self.cost
  end

  def activable?
    !has_ability?(SummoningSickness) && !tapped?
  end

  def clean_up!
    kill! if dead?
  end

  def play!
    super
    add_ability SummoningSickness.new
    @abilities.map &:play!
  end


end
