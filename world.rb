require_relative 'turn'
require_relative 'lands/mountain'
require_relative 'lands/forest'
class World

    attr_accessor :p1, :p2, :turn, :playing_player, :target_action, :logs
    def initialize(p1=nil , p2=nil)
      @p1 = p1
      @p2 = p2
      @turn = Turn.new
      @playing_player = @p1
      @logs =[]
    end

    def defending_player
      @playing_player == @p1 ? @p2 : @p1
    end

    def opponent
      defending_player
    end

    def permanents
      [@p1.permanents , @p2.permanents  ].flatten
    end

    def switch_playing_player!
      @playing_player  = defending_player
    end

    def clean_up!
      permanents.map &:clean_up!
    end

    def ready?
      p1 && p2
    end

end
