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

  def js_id
    "#{object_id}"
  end

  def to_json
    {
      js_id: object_id,
      time: @time.to_i,
      card: @card.nil? ? nil : @card.js_id ,
      card_name: @card.nil? ? nil : @card.name ,
      action: @action.nil? ? nil : @action.name.underscore,
      target: @target.nil? ? nil : @target.js_id,
      target_name: @target.nil? ? nil : @target.name ,
    }.to_json
  end

end
