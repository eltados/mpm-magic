class Wolf < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Wolf"
    @strength = 2
    @toughness = 2
    @cost = 3
    @img = "http://at-cdn-s01.audiotool.com/2013/09/03/documents/thunder_wolf/4/cover256x256-73ae55fb9c514e38a98a2e248a2e8aa2.jpg";
    add_abilities  [  ]
  end

end
