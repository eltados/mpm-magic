class World

    attr_accessor :p1, :p2, :turn,  :logs, :stack, :playing_player
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

    def resolve_stack!
      while @stack.size > 0
         action = @stack.pop
         skip = action.skip?
        #  puts "#{action.name} #{action.card.name} => skip? : #{skip}"
         if skip
          log Log.new(description: "#{action.owner.name} [ #{action.name} ] #{"on" if !action.targets.empty? }#{action.targets.map(&:name).join ',' } was not resolved because it is no longer valid!" , card: action.card, action:"X"  )
         else
          action.execute!
         end
         action.targets = []
      end
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


# playing_player  = >Player for which it is the turn.


# the player with hand for a phase
    def phase_playing_player
      turn.phase.is_a?(BlockPhase) ? defending_player :  playing_player
    end

#  Player that can play in the context of the stack
    def stack_playing_player
      return phase_playing_player if stack.empty?
      stack.last.player.opponent
    end


# should be removed eventually and replaced but playing_player

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

        p.world = self
        p.hand = []
        p.permanents = []
        p.graveyard = []
        p.deck = []

        17.times do
          p.deck << Land.all.sample.new(p)
        end


        43.times do
          p.deck << (Card.all - Land.all).reject{ |c| c.disabled? }.shuffle[0].new(p)
        end

        if p.selected_deck != nil
          p.deck = p.selected_deck.cards
          p.deck.map do |c| c.owner = p end
        end

        p.deck.shuffle!

        # redraw if no land ...
        while(! p.hand.any?{ |c| c.is_a?(Land) })
          p.hand = []
          7.times { p.draw! }
        end

        p.hand.each{ |c| c.flags.delete :new }

      end
      @logs =[]
      @playing_player.opponent.hand << ManaRing.new(@playing_player.opponent)


    if dev? && false

      @playing_player = p1
      # p1.hand = []
      p2.hand = []
      # p1.hand = []
    #    p1.hand << AuraBlast.new(p1)
    #    p1.permanents << FerventCharge.new(p1)
      #  p2.hand << RevivingDose.new(p2)
       p1.permanents << WhiteDwarf.new(p1)
       p1.permanents << WhiteDwarf.new(p1)
       p1.permanents << AngelicPage.new(p1)
       p2.permanents << FlinthoofBoar.new(p2)
      #  p1.permanents << BenalishTrapper.new(p1)
      #  p1.permanents << MoggFlunkies.new(p1)
      #  p1.permanents << SorceressQueen.new(p1)
       p1.hand << Mob.new(p1)
       p1.hand << ConcordantCrossroads.new(p1)
    #    p1.permanents << Wolf.new(p1)
      # 10.times { p1.hand << WarAxe.new(p1) }
    #    p1.permanents << Mob.new(p1)
    #    p1.permanents << Spider.new(p1)
    #   #  p1.hand << JandorsSaddlebags.new(p1)
    #    p1.permanents << RuthlessCullblade.new(p1)
    #    p1.permanents << Rhino.new(p1)
      #  p1.permanents << PhyrexianArena.new(p1)
    #    p1.hand << RevivingDose.new(p1)
      #  p1.hand << Terror.new(p1)
      #  p1.hand << Undo.new(p1)
      #  p1.hand << UnholyStrength.new(p1)
    # #    p1.hand << VampiricFeast.new(p1)
    # #    p1.hand << Mob.new(p1)
       p1.hand << Lighting.new(p1)
    #    p1.hand << AwakentheBear.new(p1)
    # #   #  p1.hand << SeismicShudder.new(p1)
        p1.hand << TitanicGrowth.new(p1)
        p1.hand = []
        # p2.hand << TitanicGrowth.new(p2)
    # #     # p1.hand << SerpentGift.new(p1)
    # #     # p1.hand << KrenkoCommand.new(p1)
    # #     # p1.hand << UnholyStrength.new(p1)
        # p2.permanents << TeferisImp.new(p2)
        # p2.permanents << DarkMonk.new(p2)
        # p1.permanents << DarkMonk.new(p1)
        # p1.permanents << Mob.new(p1)
    # #     # p2.hand = []
      #  p1.hand << Spider.new(p1)
      #  p1.hand << Mountain.new(p1)
      #  p2.permanents << Spider.new(p2)
      #  p2.permanents << Mob.new(p2)
    # #    10.times { p2.permanents << Mountain.new(p2) }
    #   #  p2.permanents << ConcordantCrossroads.new(p2)
       p2.permanents << WolverinePack.new(p2)
    # #   #  p2.permanents << Rhino.new(p2)
    # #   #  p2.permanents << StormtideLeviathan.new(p2)
    # #   #  p2.permanents << Rhino.new(p2)
      #  30.times {  p1.permanents << Mountain.new(p1) }
       0.times {  p2.permanents << Mountain.new(p2) }
       8.times {  p1.permanents << Mountain.new(p1) }
      #  2.times {  p2.permanents << Mountain.new(p2) }
    end
    end


    def when_phase_ends
      permanents.each{ |p|  p.event :phase_ends }
      players.map &:when_phase_ends # TODO
    end

    def when_turn_ends
      permanents.each{ |p|  p.event :turn_ends }
      p1.hand.each{ |p|  p.event :turn_ends }
      p2.hand.each{ |p|  p.event :turn_ends }
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
