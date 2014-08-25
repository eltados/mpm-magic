require_relative 'card'
require_relative 'abilities/summoning_sickness'
require_relative 'abilities/haste'
require_relative 'abilities/flying'
require_relative 'abilities/heal'
class Creature < Card

  attr_accessor  :blocked, :strength, :toughness, :dmg, :abilities,  :attack_bonus

  DEFAULTS = {
     dmg:  0,
     attack_bonus: 0,
     tapped: false
  }.freeze

  def initialize(options={})

    options = DEFAULTS.merge(options)
    options.each {|k,v| send("#{k}=",v)}
    @abilities = []
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

  def blocked?
    blocked
  end

  def unkeep!
    super
    @abilities.each do |ability|
      self.abilities.delete ability if ! ability.permanent?
    end
  end

  def attack!
    tap!
  end

  def play!
    super
    add_ability SummoningSickness.new
    @abilities.map &:play!
  end

  def self.gob
    gob = Creature.new(
      name: "Gob",
      strength: 2,
      toughness: 2,
      type: "Gobelin",
      img: "http://bibliotheque-imperiale.com/images/thumb/4/42/Gobelinnuit.png/300px-Gobelinnuit.png")
    gob.add_ability Haste.new
    gob
  end


  def self.dragon

    dragon = Creature.new(
      name: "Green Dragon",
      strength: 7,
      toughness: 4,
      type: "Dragon",
      img: "http://beyondheroes2.zxq.net/ReDragons.jpg")
    dragon.add_ability Flying.new
    dragon
  end

  def self.elf
    elf = Creature.new(
     name: "Forest Elf" ,
     type: "Elf", strength: 1 , toughness: 1 , img: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQTt6OYHNJ99yDLLkpmgc1Nn_S0-fVBc7qTVK985y8KfT4RoIqD")
    elf.add_ability Heal.new
    elf
  end

end
