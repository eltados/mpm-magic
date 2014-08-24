class World

    attr_accessor :p1, :p2, :turn
    def initialize(p1 , p2)
      @p1 = p1
      @p2 = p2
      @turn = Turn.new
    end


    def clean!
      @p1.clean!
      @p2.clean!
    end

    def self.setup
      mat   = Player.new( name:"Mathieu")
      olive = Player.new( name:"Olivier", health:16)

      world = World.new(mat,olive)

      4.times do
        mat.deck << Creature.gob
      end

      4.times do
        mat.deck << Creature.elf
      end

      2.times do
        mat.deck << Creature.dragon
      end

      mat.deck.suffle!

      world
    end



end
