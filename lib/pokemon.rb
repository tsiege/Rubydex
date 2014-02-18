class Pokemon
  attr_accessor :name, :number, :type, :species, :height, :weight, :description, :ascii
  # attr_reader :pokemon_hash
  ALL_POKEMON = []

  def self.all
    ALL_POKEMON
  end

  def initialize(pokemon_array)
    # @pokemon_hash = pokemon_hash
    name = pokemon_array[2]
    number = pokemon_array[3]
    type = pokemon_array[4].split(" ")
    species = pokemon_array[5]
    height = pokemon_array[6]
    weight = pokemon_array[7]
    description = pokemon_array[8]
    ascii = pokemon_array[9]
    ALL_POKEMON.push(self)
  end



  # def save
  #   DB.execute("INSERT INTO pokemon (href, name, number, type, species, height, weight, description, ascii) VALUES 
  #     (:href, :name, :number, :type, :species, :height, :weight, :description, :ascii)", pokemon_hash)
  # end



end