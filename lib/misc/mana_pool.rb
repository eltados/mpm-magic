class ManaPool
  attr_accessor :mana, :player

  def initialize(player)
    @mana = 0
    @player = player
  end


  def reset!
    @mana = 0
  end

  def can_pay? cost
    @mana  + reserve >= cost
  end

  def pay! cost
    @mana -= cost
    while (@mana < 0)
      @player.lands.find { |land|  land.can?(Produce) }.execute! Produce
    end
  end

  def reserve
    r = @player.lands.select do  |land|
      land.can? Produce
    end.map(&:mana_produced).inject{|sum,x| sum + x }
    r || 0
  end


end
