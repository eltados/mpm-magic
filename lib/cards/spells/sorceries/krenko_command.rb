class  KrenkoCommand < Sorcery


  def initialize(owner=nil)
    super(owner)
    @name = 'Krenko\'s Command'
    @cost = 2 # 1R
    @description =  "Put two 1/1 red Goblin creature tokens onto the battlefield."
    @img = "http://ts1.mm.bing.net/th?&id=HN.607988458254762795&w=300&h=300&c=0&pid=1.9&rs=0&p=0"
  end

  def play!
    super
    2.times {  @owner.create_token! (Gob.new( @owner )) }
  end

end
