class Turn
    attr_accessor :current_phase, :number

    def initialize
      @current_phase = 0
      @number = 1
    end
   @@phases =["unkeep" , "draw", "pre", "attack" , "post", "discard" ]

   def next!
     @current_phase += 1
     if @current_phase >= @@phases.size
       end!
     end
   end

   def phase
       @@phases[@current_phase]
   end

   def end!
     @current_phase = 0
     @number += 1
   end

end
