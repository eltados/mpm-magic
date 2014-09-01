class Creature < Card

  attr_accessor  :strength, :toughness, :dmg, :abilities, :attack_bonus

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

  # def toughness
  #   @toughness  + ab_calc(:toughness)
  # end
  #
  # def strength
  #   @strength  + ab_calc(:strength)
  # end
  #
  #
  # def actions
  #   @actions + ab_ary( :actions )
  # end
  #
  # def ab_calc(method)
  #   @abilities.select{ |a| a.respond_to? method }.map( &method ).inject{|sum,x| sum + x } || 0
  # end
  #
  # def ab_ary(method)
  #   @abilities.select{ |a| a.respond_to? method }.map( &method ).flatten
  # end


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
    ability = self.ability(ability_class)
    @abilities.delete ability if ability!=nil
  end

  def ability(ability_class)
    @abilities.each do |a|
      return a if a.is_a? ability_class
    end
    return nil
  end

  def attack
    strength + @attack_bonus
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
    !has_ability?(SummoningSickness) && !tapped?
  end

  def play!
    super
    add_ability SummoningSickness.new
    @abilities.map &:play!
  end

  def when_phase_ends
    super
    when_dead if dead?
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


end
