class Log
  attr_accessor :world, :description, :card, :target, :action, :time

  def initialize(world:nil, description: "", card: nil, target: nil , action: nil)
    @world =  world
    @description =  description
    @time =  Time.new
    @card =  card
    @action =  action
    @target =  target
  end

end
