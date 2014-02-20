require 'bundler/setup'

Bundler.require(:default)

require_relative '../lib/pokemon'
require_relative '../lib/rubydex'

DB = SQLite3::Database.open "db/pokemon.db"