class Snake < Creature

  def initialize(owner=nil)
    super(owner)
    @name = "Snake"
    @strength = 1
    @toughness = 1
    @cost = 1
    @img = "http://digital-art-gallery.com/oid/93/640x640_16176_Cave_snake_2d_fantasy_monster_snake_cave_reptile_picture_image_digital_art.jpg";
    add_abilities  [  ]
  end

  def self.disabled?
    true
  end

end
