class Msg
  attr_accessor :world, :text, :time, :level

  def initialize(world:nil , level: :info, text: nil)
    @world =  world
    @level =  level
    @text =  text
    @time =  Time.new
  end

end
