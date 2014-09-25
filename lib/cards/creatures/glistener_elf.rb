class GlistenerElf < Creature

  def initialize(owner=nil)
    super(owner)
    @name = 'Glistener Elf'
    @strength = 1
    @toughness = 1
    @cost = 1 # G
    @description =  "Infect (This creature deals damage to creatures in the form of -1/-1 counters and to players in the form of poison counters.)"
    @img = "http://www.tentonhammer.com/image/view/50524"
    @mtg_id = 233052
  end

end
