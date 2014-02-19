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
    puts "If you'd like to leave enter 'exit'."
    choice = gets.chomp.downcase
    choice_reciever(choice)
  end

  def choice_reciever(choice)
    if choice == "help"
      help
    elsif choice == "exit" || choice == "no"
      puts "Go catch 'em all!"
      exit
    elsif choice == "type"
      type_retriever
    elsif choice.split("").include?('#')
      pokemon_number_retriever(choice)
    elsif (1..151).include?(choice.to_i)
      choice = rubydex_number_formater(choice)
      pokemon_number_retriever(choice)
    else
      pokemon_name_retriever(choice)
    end
  end

  def rubydex_number_formater(choice)
    choice = choice.to_i
    if choice < 10
      "#00#{choice}"
    elsif choice < 100
      "#0#{choice}"
    else
      "##{choice}"
    end
  end


  def help
    puts "Trouble shooting your Rubydex..."
    puts "I can tell you a Pokemon based on a number or name."
    puts "I can show you all Pokemon of a certain type."
    puts "Basically that's all I do..."
    puts "If you want to get back to catching animals\nand having them fight each other enter 'exit'"
    choice = gets.chomp.downcase
    choice_reciever(choice)
  end


  def pokemon_name_retriever(choice)
    pokemon_info = DB.execute("SELECT * FROM pokemon WHERE name = ?", choice.capitalize)
    pokemon_creator(pokemon_info, choice)
  end

  def pokemon_number_retriever(choice)
    pokemon_info = DB.execute("SELECT * FROM pokemon WHERE number = ?", choice)
    pokemon_creator(pokemon_info, choice)
  end

  def pokemon_creator(pokemon_info, choice)
    if pokemon_info != []
      choice = Pokemon.new(pokemon_info.flatten)
      pokemon_putter(choice)
    else
      puts "Sorry, no such records exist for this Pokemon."
      puts "Would you like to try something else?"
      puts "Enter 'help' if you need some or enter another Pokemon."
      choice = gets.chomp.downcase
      choice_reciever(choice)
    end
  end

  def pokemon_putter(choice)
    puts "=========================================================================================================================="
    puts choice.ascii
    puts "Name:  #{choice.name}"
    puts "No.  #{choice.number}"
    print "Type:  "
    choice.type.each {|t| print "#{t} "} 
    puts ''
    puts "Species:  #{choice.species}"
    puts "Height:  #{choice.height}"
    puts "Weight:  #{choice.weight}"
    puts "Description:  choice.description"
    puts "=========================================================================================================================="
    puts "Anything else?"
    choice = gets.chomp.downcase
    choice_reciever(choice)
  end


  def type_retriever
    puts "Please enter a type of Pokemon."
    choice = gets.chomp.downcase

    temp_pokemon_by_type = DB.execute("SELECT name, number, type FROM pokemon")
    pokemon_by_type = temp_pokemon_by_type.collect do |pokemon_arr|
      pokemon_arr.collect do |p| 
        p.split(" ") 
      end
    end
    pokemon_type_sorter(pokemon_by_type, choice)
  end

  def pokemon_type_sorter(pokemon_by_type, choice)
    pokemon_of_same_type = []
    pokemon_by_type.each do |pokemon|
      pokemon_of_same_type << pokemon if pokemon[2].include?(choice.capitalize)
    end
    type_putter(pokemon_of_same_type)
  end

  def type_putter(pokemon_of_same_type)
    if pokemon_of_same_type != []
      puts "================================================================================"
      puts ""
      pokemon_of_same_type.each do |pokemon_arr|
        end_type = (", #{pokemon_arr[2][1]}" if pokemon_arr[2][1] != nil).to_s
        puts "Name: #{pokemon_arr[0][0]}  |  RubyDex #{pokemon_arr[1][0]}  |  Type: #{pokemon_arr[2][0]}" + end_type
      end
      puts ""
      puts "================================================================================"
      puts "Is there anything else?"
      choice = gets.chomp.downcase
      choice_reciever(choice)
    else
    puts "No such records exist."
    puts "Enter 'type' if you would like to try again."
    choice = gets.chomp.downcase
    choice_reciever(choice)
    end
  end
end