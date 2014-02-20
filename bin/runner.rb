require_relative '../config/environment'

DB = SQLite3::Database.open "db/pokemon.db"

RubyDex.new