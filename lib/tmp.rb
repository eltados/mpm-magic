#!/usr/bin/env ruby
require 'rubygems'
require 'active_support'


class Mod1
  def self.hp( value , card )
    value  + 100
  end
end


class Mod2
  def self.hp( value , card )
    100
  end
end

class Mod3

end


class Card
  attr_accessor :hp , :mods
  def initialize
    @mods = [ ] 
    @hp = 1 
  end 
  
  
  $modified_methods = [:hp] 
  

  def modify(original_value , method)
    @mods.select do  |mod| 
        mod.respond_to? method
    end.reduce(original_value) do |val,mod| 
        mod.send( method, val , self )
    end
  end 


  $modified_methods.each do |method|
   define_method "#{method}_with_mod".to_sym do 
       modify( send("#{method}_without_mod".to_sym) , method)
   end
   alias_method_chain method , :mod
  end

    
end


class SuperCard < Card

  def initialize
    @hp = 1 
    @mods = [ Mod2 , Mod1,  Mod1  ] 
  end 

  
end
 


c = Card.new
puts c.hp
puts c.hp_without_mod
puts c.hp_with_mod
puts "======="
s = SuperCard.new
puts s.hp
puts s.hp_without_mod
puts s.hp_with_mod



