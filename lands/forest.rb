require_relative 'land'

class Forest < Land

  def initialize(options={})
    super
    @name = "Forest"
    @img = "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTNhAehTLYxxNpu3fFyKfHmEck9JbtFn7NPdv8VjISzdR8FkAWw"
  end

end
