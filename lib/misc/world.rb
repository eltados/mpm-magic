class World

    attr_accessor :p1, :p2, :turn, :playing_player,  :logs, :stack
    def initialize(p1=nil , p2=nil)
      @p1 = p1
      @p2 = p2
      @turn = Turn.new(self)
      @playing_player = @p1
      @logs =[]
      @stack =[]
      @p1.world = self if(@p1 != nil)
      @p2.world = self if(@p2 != nil)
    end


    def enchantments
      permanents.select{ |p| p.is_a?(Enchantment) &&  p.respond_to?(:affects) }
    end


    def abilities_for(card)
      enchantments.select{|e| e.affects(card) && e.in_play? }.map do |e|
        e.provided_abilities.map do |ab|
          ab.new(card)
        end
      end
    end

    def defending_player
      @playing_player == @p1 ? @p2 : @p1
    end

    def opponent
      defending_player
    end

    def permanents
      [@p1.permanents , @p2.permanents ].flatten
    end

    def players
      [@p1, @p2 ]
    end

    def creatures
      [@p1, @p2 ].map(&:creatures).flatten
    end

    def winner
      return p2 if p1.dead?
      return p1 if p2.dead?
      nil
    end

    def switch_playing_player!
      @playing_player  = defending_player
    end

    def active_player
      @playing_player.active? ?  @playing_player : opponent
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

    def log(log)
      log.world = self
      logs << log
    end


    def dev?
      $ENV && $ENV['RACK_ENV'] == "development"
      # true
    end

    def self.find(id)
      ObjectSpace._id2ref(id.to_i)
    end

    def name
      "Game #{object_id}"
    end

    def inspect
      "#<#{self.class.name}:#{object_id} p1=#<#{p1.class.name}:#{p1.object_id}> p2=#<#{p2.class.name}:#{p2.object_id}>>"
    end


    def start!
      @playing_player =  ( Random.new.rand(2) == 0 || ( @p2.ai && !@p1.ai ) ) ? @p1 : @p2

      [p1, p2].each do |p|
        p.hand = []
        p.permanents = []
        p.graveyard = []
        p.deck = []

        17.times do
          p.deck << Land.all.sample.new(p)
        end


        43.times do
          p.deck << (Card.all - [God , WinterWall  ] - Land.all).reject{ |c| c.disabled? }.shuffle[0].new(p)
        end



        p.deck.shuffle!

        7.times { p.draw! }

      end

      @playing_player.opponent.hand << ManaRing.new(@playing_player.opponent)

    if dev?
      p1.hand = []
       p1.hand << AuraBlast.new(p1)
       p1.permanents << BookofRass.new(p1)
       p1.hand << Terror.new(p1)
       p1.permanents << JandorsSaddlebags.new(p1)
       p1.permanents << Wolf.new(p1)
      #  p1.hand << WaveofReckoning.new(p1)
       p1.permanents << Mob.new(p1)
       p1.permanents << Spider.new(p1)
      #  p1.hand << JandorsSaddlebags.new(p1)
       p1.permanents << DarkMonk.new(p1)
    #    p1.hand << AuraBlast.new(p1)
    #    p1.hand << VampiricFeast.new(p1)
    #    p1.hand << Mob.new(p1)
       p1.hand << Lighting.new(p1)
    #   #  p1.hand << SeismicShudder.new(p1)
    #     # p1.hand << TitanicGrowth.new(p1)
    #     # p1.hand << SerpentGift.new(p1)
    #     # p1.hand << KrenkoCommand.new(p1)
    #     # p1.hand << UnholyStrength.new(p1)
        # p1.permanents << TeferisImp.new(p1)
    #     # p1.permanents << God.new(p1)
    #     # p2.hand = []
      #  p2.permanents << Mob.new(p2)
      #  p2.permanents << Spider.new(p2)
    #    10.times { p2.permanents << Mountain.new(p2) }
      #  p2.permanents << ConcordantCrossroads.new(p2)
       p2.permanents << Elephant.new(p2)
    #   #  p2.permanents << Rhino.new(p2)
    #   #  p2.permanents << StormtideLeviathan.new(p2)
    #   #  p2.permanents << Rhino.new(p2)
       10.times {  p1.permanents << Mountain.new(p1) }
      #  2.times {  p2.permanents << Mountain.new(p2) }
    end
    end


    def when_phase_ends
      permanents.each{ |p|  p.event :phase_ends }
      players.map &:when_phase_ends # TODO
    end

    def when_turn_ends
      permanents.each{ |p|  p.event :turn_ends }
      players.map &:when_turn_ends # TODO
      playing_player.when_my_turn_ends #TODO
      switch_playing_player!
    end

    def when_phase_unkeep
      playing_player.permanents.each{ |p|  p.event :phase_unkeep }
    end

    def when_phase_untap
      playing_player.permanents.each{ |p|  p.event  :phase_untap }
    end

    def when_phase_draw
      playing_player.when_phase_draw #TODO
    end
end
