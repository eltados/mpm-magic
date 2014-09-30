require 'rubygems'
require 'require_all'
require "minitest/autorun"
require_all '.'

class AutoFight < Minitest::Test
  def setup
  end

  def test_run_games
   world = nil
   timeout = 15
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

          while(! p1.dead? && ! p2.dead? ) do
            world.active_player.auto_play!
          end
          i+= 1
          print "."
          assert true, "This game did not crash"
        end
      end
    rescue Timeout::Error
      # stat = {}
      # winners = {}
      # worlds.each do |world|
      #   winners[world.winner.name] = 0 if winners[world.winner.name] == nil
      #   winners[world.winner.name] += 1
      # end
      # stat[:win_rate] = winners.map do |key,value| {key => "#{value * 100 / worlds.size}%" } end.reduce(:merge)
      # worlds.map do |world| world.turn.number end.inject{|sum,x| sum + x } / worlds.size.to_f
      # stat[:turn] = worlds.map do |world| world.turn.number end.inject{|sum,x| sum + x } / worlds.size.to_f
      # stat[:games_per_min] = worlds.size * 60  / timeout.to_f
      # stat[:games] = worlds.size
      # puts stat.to_json
      puts "#{i} games ( #{i * 60 / timeout.to_f } per min )"
    rescue Exception => e
      assert(false, """
One of the game failed. Here are some details about the game :

=== logs ===
#{world.logs.map(&:description).join("\n")}

=== exception ===
#{e.message}
#{e.backtrace.join("\n")}

""")
    end
  end

end
