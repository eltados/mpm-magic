class BestialMenace < Sorcery

  def initialize(owner=nil)
    super(owner)
    @name = "Bestial Menace"
    @cost = 5 # 3GG
    @description =  "Put a 1/1 green Snake creature token, a 2/2 green Wolf creature token, and a 3/3 green Elephant creature token onto the battlefield."
    @img = "cards/247535.png"
    @mtg_id = 247535
  end

  def when_played(*args)
    @owner.create_token! Snake.new( @owner )
    @owner.create_token! Wolf.new( @owner )
    @owner.create_token! Elephant.new( @owner )
  end

end
