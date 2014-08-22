class World

    attr_accessor :p1, :p2
    def initialize(p1 , p2)
      @p1 = p1
      @p2 = p2
    end


    def clean!
      @p1.clean!
      @p2.clean!
    end

    def render
"""
#{@p1.render}

#{'='* 80}


#{@p2.render.to_s.split("\n").reverse.join("\n")}
"""
    end



end
