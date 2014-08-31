class World

    attr_accessor :p1, :p2, :turn, :playing_player, :target_action, :logs
    def initialize(p1=nil , p2=nil)
      @p1 = p1
      @p2 = p2
      @turn = Turn.new(self)
      @playing_player = @p1
      @logs =[]
      @p1.world == self if(@p1 != nil)
      @p2.world == self if(@p2 != nil)
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

    def active_player
      @playing_player.active? ?  @playing_player : opponent
    end


    def clean_up!
      permanents.map &:clean_up!
    end

    def ready?
      @p1 != nil  && @p2 !=nil
    end

    def delete(player)
      p1 == nil if player == p1
      p2 == nil if player == p2
    end


    def to_param
      "#{object_id}-world"
    end

    def self.find(id)
      ObjectSpace._id2ref(id.to_i)
    end

    def name
      "Game #{object_id}"
    end

    def start!
      [p1, p2].each do |p|

        20.times do
          p.deck << Mountain.new(p)
          p.deck << Forest.new(p)
        end


        40.times do
          p.deck << Creature.all.shuffle[0].new(p)
        end

        p.deck.shuffle!

        7.times { p.draw! }

      end
    end



end
