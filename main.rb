require_relative 'creature'
require_relative 'fight'
require_relative 'player'
require_relative 'world'
require_relative 'battle'


mat   = Player.new( name:"Mathieu")
olive = Player.new( name:"Olivier", health:15)
world = World.new(mat,olive)


gob = Creature.new( name: "Gob" , strength: 2 , toughness: 2 )
angel = Creature.new( name: "Angel" , strength: 5 , toughness: 5   )
elf = Creature.new( name: "Elf" , strength: 1 , toughness: 1 )
wall = Creature.new( name: "Wall" , strength: 0 , toughness: 7 )

mat.summon! gob
mat.summon! angel
olive.summon! elf
olive.summon! wall



puts world.render

battle = mat.attack!( olive)

battle.attack! gob
battle.attack! angel
battle.block!  angel , elf
battle.block!  gob , wall



puts battle.render
battle.resolve!
puts world.render
world.clean!
puts world.render

exit


Fight.new(gob, elf).fight!

puts "#{gob} #{elf}"
