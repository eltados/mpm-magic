class Player
  attr_accessor :name, :health , :creatures

  DEFAULTS = {
     name:  "Player",
     health: 20,
  }

  def initialize(options={})
    options = DEFAULTS.merge(options)
    options.each {|k,v| send("#{k}=",v)}
    @creatures = []
  end

  def alive?
    health > 0
  end

  def dead?
    !alive?
  end

  def summon!(creature)
    creature.owner = self
    @creatures << creature
  end

  def attack!(player)
    Battle.new(self, player)
  end


  def clean!
    clean_dead_creatures!
    @creatures.each do |c|
      c.reset!
    end
  end

  def clean_dead_creatures!
    dead_creatures = []
    @creatures.each do |c|
      dead_creatures << c if c.dead?
    end
    @creatures -=  dead_creatures
  end

  def to_s
    "#{name}#{'*' if dead?} [#{health}]"
  end

  def render
"""
#{to_s}
#{'-'* 80}
#{creatures.map(&:render ).join "\n"}
"""
  end

end
