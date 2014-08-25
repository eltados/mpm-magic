require_relative 'turn'
require_relative 'lands/mountain'
require_relative 'lands/forest'
class World

    attr_accessor :p1, :p2, :turn
    def initialize(p1 , p2)
      @p1 = p1
      @p2 = p2
      @turn = Turn.new
    end

    def current_player
      @p1
    end

    def clean!
      @p1.clean!
      @p2.clean!
    end

    def self.setup
      p1 = Player.new( name:"Mathieu")
      p2 = Player.new( name:"Olivier", health:16)

      world = World.new(p1,p2)

      20.times do
        p1.deck << Mountain.new
        p2.deck << Mountain.new
        p1.deck << Forest.new
        p2.deck << Forest.new
        p1.deck << Creature.gob
        p2.deck << Creature.gob
        p1.deck << Creature.elf
        p2.deck << Creature.elf
      end

      12.times do
        p1.deck << Creature.dragon
      end

      p1.deck.suffle!
      p2.deck.suffle!

      7.times { p1.draw! }
      7.times { p2.draw! }

      world
    end



end

$world = World.setup
