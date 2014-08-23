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




end
