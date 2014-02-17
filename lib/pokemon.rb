class Pokemon
  attr_reader :pokemon_hash

  def initialize(pokemon_hash)
    @pokemon_hash = pokemon_hash
  end

  def save
    DB.execute("INSERT INTO pokemon (href, name, number, type, species, height, weight, description, ascii) VALUES 
      (:href, :name, :number, :type, :species, :height, :weight, :description, :ascii)", pokemon_hash)
  end




end