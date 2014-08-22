class Creature

  attr_accessor :name, :owner, :tapped, :blocked, :cost, :strength, :toughness, :dmg, :attack_bonus

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


  def tap!
    @tapped = true
  end


  def tapped?
    tapped
  end


  def untap!
    @tapped = false
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

  def to_s
    out = name
    out += "\u23CE" if tapped?
    out += "\u2620" if dead?
    out += "B" if blocked
    out += "[#{attack}/#{health}]"
  end

  def render
    to_s
  end

  def attack!
    tap!
  end

end
