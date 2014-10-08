class  KrenkoCommand < Sorcery


  def initialize(owner=nil)
    super(owner)
    @name = 'Krenko\'s Command'
    @cost = 2 # 1R
    @description =  "Put two 1/1 red Goblin creature tokens onto the battlefield."
    @img = "cards/krenko.jpg"
  end

  def play!
    super
    2.times {  @owner.create_token! (Gob.new( @owner )) }
  end

end
