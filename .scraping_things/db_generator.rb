require 'sqlite3'
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './lib/pokemon'
require_relative './pokemon_scraper'




def create_table
  DB.execute("CREATE TABLE IF NOT EXISTS pokemon (id INTEGER PRIMARY KEY AUTOINCREMENT,
    href TEXT, name TEXT, number VARCHAR(4), type TEXT, species TEXT,
    height VARCHAR(12), weight VARCHAR(18), description TEXT, ascii TEXT)")
end



DB = SQLite3::Database.new "pokemon.db"
create_table

pokemon_scraper = Scraper.new
pokemon_scraper.save_to_db