class Pokemon
  attr_accessor :name, :number, :type, :species, :height, :weight, :description, :ascii
  attr_reader :pokemon_hash

  def initialize(pokemon_arr)
    # @pokemon_hash = pokemon_hash
    self.name = pokemon_arr[2]
    self.number = pokemon_arr[3]
    self.type = pokemon_arr[4].split(" ")
    self.species = pokemon_arr[5]
    self.height = pokemon_arr[6]
    self.weight = pokemon_arr[7]
    self.description = pokemon_arr[8]
    self.ascii = pokemon_arr[9]
  end



  def save
    DB.execute("INSERT INTO pokemon (href, name, number, type, species, height, weight, description, ascii) VALUES 
      (:href, :name, :number, :type, :species, :height, :weight, :description, :ascii)", pokemon_hash)
  end



end