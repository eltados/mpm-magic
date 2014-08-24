require_relative 'card'
class Creature < Card

  attr_accessor  :blocked, :strength, :toughness, :dmg, :attack_bonus

  DEFAULTS = {
     dmg:  0,
     attack_bonus: 0,
     tapped: false
  }.freeze

  def initialize(options={})

    options = DEFAULTS.merge(options)
    options.each {|k,v| send("#{k}=",v)}

  end

  def health
    toughness - dmg
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


  def attack!
    tap!
  end

  def self.gob
    Creature.new(
      name: "Gob",
      strength: 2,
      toughness: 2,
      type: "Gobelin",
      img: "http://bibliotheque-imperiale.com/images/thumb/4/42/Gobelinnuit.png/300px-Gobelinnuit.png")
  end


  def self.dragon
    Creature.new(
      name: "Green Dragon",
      strength: 7,
      toughness: 4,
      type: "Dragon",
      img: "http://beyondheroes2.zxq.net/ReDragons.jpg")
  end

  def self.elf
     Creature.new(
     name: "Forest Elf" ,
     type: "Elf", strength: 1 , toughness: 1 , img: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQTt6OYHNJ99yDLLkpmgc1Nn_S0-fVBc7qTVK985y8KfT4RoIqD")
  end

end
