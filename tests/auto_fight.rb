require 'rubygems'
require 'require_all'
require "minitest/autorun"
require "method_profiler"
require_all '.'


class FightTooLong < StandardError
end

class AutoFight < Minitest::Unit::TestCase
  def setup
  end

  def test_run_games
  #  profiler = MethodProfiler.observe(World)
  #  profiler_card = MethodProfiler.observe(Card)
   world = nil
   timeout = 5
   max_game_length = 3
   winner = {}
   winner[:p1] = 0
   winner[:p2] = 0
   i = 0
   begin
      Timeout::timeout(timeout) do
        while true
          p1 = Player.new
          p1.ai = true
          p1.name = "Player 1"
          p2 = Player.new
          p2.ai = true
          p2.name = "Player 2"
          world = World.new(p1, p2)
          world.start!
          Timeout::timeout(max_game_length  , FightTooLong) do
            while(! p1.dead? && ! p2.dead? ) do
              world.active_player.auto_play!
            end
          end
          if p1.alive?
            winner[:p1] += 1
          else
            winner[:p2] += 1
          end
          i+= 1
          print "."
          assert true, "This game did not crash"
        end
      end
    rescue Timeout::Error
      puts "#{i} games ( #{i * 60 / timeout.to_f } per min )"
    rescue Exception => e
      assert(false, """
One of the game failed. Here are some details about the game :

=== permanents ===
#{world.players.map(&:creatures).flatten.map(&:name).sort.join("\n")}

=== logs ===
#{world.logs.map(&:description).join("\n") if true}

=== exception ===
#{e.message}
#{e.backtrace.join("\n")}

""")
    end

    puts "p1 winrate: #{winner[:p1] * 100  / ( winner[:p1] + winner[:p2] ).to_f}"
    puts "p2 winrate: #{winner[:p2] * 100  / ( winner[:p1] + winner[:p2] ).to_f}"
    # puts "=== profiler world==="
    # puts profiler.report
    #
    # puts "=== profiler world==="
    # puts profiler_card.report
  end

end
