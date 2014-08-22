class Battle

  attr_accessor :attacking_creatures ,:blocked_creatures

  def initialize(attacking_player, defending_player)
    @attacking_creatures =[]
    @attacking_player = attacking_player
    @defending_player = defending_player
    @blocked_creatures = {}
  end

  def attack!( attacking_creature )
    attacking_creature.tap!
    @attacking_creatures  <<  attacking_creature
  end

  def block!( attacking_creature , blocking_creature)
    attacking_creature.blocked = true
    @blocked_creatures[attacking_creature] =  blocking_creature
  end

  def unblocked_creatures
      attacking_creatures.reject do |c|
        c.blocked?
      end
  end

  def resolve!

    blocked_creatures.each do |attacking, blocking|
      Fight.fight!(attacking, blocking)
    end

    unblocked_creatures.each do |creature|
      Fight.attack_player!(creature, @defending_player)
    end

  end


  def render
    out  = ""
    @attacking_creatures.each do |creature|
      out += creature.render
      if creature.blocked?
        out += " is blocked by #{@blocked_creatures[creature]}"
      else
        out += " is not blocked."
      end
      out += "\n"

    end
    out
  end

end
