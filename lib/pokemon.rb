class Pokemon
  attr_accessor :name, :number, :type, :species, :height, :weight, :description, :ascii
  attr_reader :pokemon_hash

  def initialize(pokemon_hash)
    @pokemon_hash = pokemon_hash
    # self.name = pokemon_array[2]
    # self.number = pokemon_array[3]
    # self.type = pokemon_array[4].split(" ")
    # self.species = pokemon_array[5]
    # self.height = pokemon_array[6]
    # self.weight = pokemon_array[7]
    # self.description = pokemon_array[8]
    # self.ascii = pokemon_array[9]
  end



  def save
    DB.execute("INSERT INTO pokemon (href, name, number, type, species, height, weight, description, ascii) VALUES 
      (:href, :name, :number, :type, :species, :height, :weight, :description, :ascii)", pokemon_hash)
  end



end