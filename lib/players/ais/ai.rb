class Ai

  def initialize(player=nil)
    @player = player
  end

  def hand
    @player.hand
  end


  def player
    @player
  end

  def me
    @player
  end

  def world
    @player.world
  end

  def opponent
    @player.opponent
  end

  def creatures
    @player.creatures
  end

  def permanents
    @player.permanents
  end

  def attack_all!
    @player.attack_all!
  end

end
