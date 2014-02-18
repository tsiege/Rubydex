require 'sqlite3'
require 'pry'
DB = SQLite3::Database.open "pokemon.db"

class RubyDex

  attr_accessor :pokemon_instances
  attr_reader :rubydex_logo

  def initialize
    @pokemon_instances = []
    @rubydex_logo = <<-eos                                                  
         00000             001                    000001                        
      000000000          00001                10000000000 
      0000000000         00001                 00000000000
      0000 00001          0001                 00000  0000
      000   000           0001                 00000   000                       
       001 000  0000   1  00000000   1          0000   0001        0000    0000  
       00000000 0000   0000000010000001    00   1000   0000  00000010000  0000   
       0000100000000   0000000 00 00000    0000  000   000000000000 0000000001   
       000  10000000   0000000    000001  10000  000   0001001 100   00000000    
       100   0000000   0000000   0000000  0000   000   000000  00     000000     
        001  0000000  0000000000000110000 0000   000  0000000 001      0000      
        000  0000000  0000000000000  00000000    000000001000000 00   000000     
        000   000000000000000000001   0000000    00000000 0000010000 00000001    
        000   00000000000 00000001    000000     0000000  0000000001 00000000    
        000   000 000000  000000       00000     00000     0000000  0000  0000   
              1                        00000                       0000   10000  
                                       0000                                      
                                       0000                                      
                                      0000                                       
                                      0000                                       
                                      0001                                       
                                       00                                                                                  
    eos
    puts rubydex_logo
    puts "Hello trainer, welcome to the RubyDex."
    puts "I am a knowledgeable device about 151 Pokemon."
    puts "Enter the name or number of a Pokemon you are interested in."
    puts "Or enter 'help' if you would like to see more capabilities."
    choice = gets.chomp
    choice_reciever(choice)
  end

  def choice_reciever(choice)
    if choice.downcase == "help"
      help
    elsif choice.downcase == "type"
      type_retriever
    elsif (1..151).include?(choice.gsub(/#/, ""))
      pokemon_number_retriever(choice)
    else
      pokemon_selector(choice)
    end
  end


  def pokemon_name_retriever(choice)
    pokemon_info = DB.execute("SELECT * FROM pokemon WHERE name = :choice", choice)
    choice = Pokemon.new(pokemon_info.flatten)
    if choice != []
      pokemon_instances << choice
      #pokemon_object.method_that_prints_to_screen
    else
      puts "Sorry, no such records exist for this Pokemon."
      puts "Would you like to try something else?"
      puts "Enter 'help' if you need some or enter another Pokemon."
      choice = gets.chomp
      choice_reciever(choice)
    end
  end

  def pokemon_number_retriever(choice)
    #uses a number to pick a pokemon
  end

  def pokemon_selector(choice)
    pokemon_instances.each do |pokemon_object|
      if pokemon_object.name == choice
        #pokemon_object.method_that_prints_to_screen
      else
        pokemon_retriever(choice)
      end
    end
  end

  def type_retriever
    
  end


end

test = Rubydex.new
binding.pry