require_relative 'turn'
require_relative 'lands/mountain'
require_relative 'lands/forest'
class World

    attr_accessor :p1, :p2, :turn, :playing_player
    def initialize(p1=nil , p2=nil)
      @p1 = p1
      @p2 = p2
      @turn = Turn.new
      @playing_player = @p1
    end

    def defending_player
      @playing_player == @p1 ? @p2 : @p1
    end

    def opponent
      defending_player
    end


    def switch_playing_player!
      @playing_player  = defending_player
    end

    def clean!
      @p1.clean!
      @p2.clean!
    end

    def ready?
      p1 && p2
    end

end
