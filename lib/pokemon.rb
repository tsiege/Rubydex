class Pokemon
  attr_accessor :name, :number, :type, :species, :height, :weight, :description, :ascii

  def initialize(pokemon_arr)
    self.name = pokemon_arr[2]
    self.number = pokemon_arr[3]
    self.type = pokemon_arr[4].split(" ")
    self.species = pokemon_arr[5]
    self.height = pokemon_arr[6]
    self.weight = pokemon_arr[7]
    self.description = pokemon_arr[8]
    self.ascii = pokemon_arr[9]
  end
end