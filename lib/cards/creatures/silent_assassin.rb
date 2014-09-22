class SilentAssassin < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Silent Assassin"
    @strength = 2
    @toughness = 1
    @cost = 2 # BB
    @description =  "{3}{Black}: Destroy target blocking creature at end of combat."
    @img = "http://huntersinsight.files.wordpress.com/2010/07/assassin.jpg"
    @mtg_id = 19692
  end

end
