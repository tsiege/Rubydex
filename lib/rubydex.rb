class Rubydex

  def initialize
    
  end

  def pokemon_retriever(info)
    DB.execute("SELECT ? FROM pokemon")
  end

end