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
      mat   = Player.new( name:"Mathieu")
      olive = Player.new( name:"Olivier", health:16)

      world = World.new(mat,olive)

      20.times do
        mat.deck << Mountain.new
      end

      20.times do
        mat.deck << Forest.new
      end


      20.times do
        mat.deck << Creature.gob
      end

      15.times do
        mat.deck << Creature.elf
      end

      12.times do
        mat.deck << Creature.dragon
      end

      mat.deck.suffle!

      7.times do mat.draw! end

      world
    end



end

$world = World.setup
