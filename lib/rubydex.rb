class Rubydex

  def initialize
    
  end

  def pokemon_retriever(title)
    DB.execute("SELECT * FROM pokemon WHERE name = :title", title)
  end

end