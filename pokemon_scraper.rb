require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def initialize
    @pokemon_data = []
    @index_url = 'http://pokemondb.net/pokedex/game/firered-leafgreen'
    @index = Nokogiri::HTML(open(@index_url))
    @asscii_url = 'http://www.fiikus.net/asciiart/pokemon/'
  end

  def index_data_scrape
    @index.css("a.ent-name").css("a").each_with_index do |element, index|
      @pokemon_data[index] ||={}
      @pokemon_data[index][:href] = element.attr("href")
      @pokemon_data[index][:name] = element.children.text
      @pokemon_data[index][:number] = pokedex_number(index)
    end
  end

  def pokedex_number(index)
    number = index + 1
    if number < 10
      "#00#{number}"
    elsif number < 100
      "#0#{number}"
    else
      "##{number}"
    end
  end

  def pokemon_data_scrape
    @pokemon_data.each do |pokemon_hash|
      sleep(1)
      temp_page = "http://pokemondb.net/#{pokemon_hash[:href]}"
      pokemon_page = Nokogiri::HTML(open(temp_page))
      pokemon_page_tables = pokemon_page.css("table.vitals-table")
      pokemon_page_data = pokemon_page_tables.first.css("td")

      data_from_pokemon_page(pokemon_hash, pokemon_page_data, pokemon_page_tables)
    end
  end

  def data_from_pokemon_page(pokemon_hash, pokemon_page_data, pokemon_page_tables)
    pokemon_hash[:type] = pokemon_page_data[1].text.strip.gsub(/\t{1,}/," ")
    pokemon_hash[:species] = pokemon_page_data[2].text
    pokemon_hash[:height] = pokemon_page_data[3].text
    pokemon_hash[:weight] = pokemon_page_data[4].text
    # pokemon_hash[:ability] = pokemon_page_data
    pokemon_hash[:description] = pokemon_page_tables[4].css("td")[0].text
  end

  def pokemon_ascii_scrape
    @pokemon_data.each do |pokemon_hash|
      sleep(1)
      pokemon_number = pokemon_hash[:number].gsub(/#/, "")
      begin
        pokemon_temp_url = @asscii_url + "#{pokemon_number}.txt"
        pokemon_ascii = Nokogiri::HTML(open(pokemon_temp_url))
        pokemon_hash[:ascii] = pokemon_ascii.css("p").text
      rescue
        pokemon_hash[:ascii] = <<-eos
                      00000000000              
                    000000000000000            
                  0000000000000000000          
                 000000000000000000000         
                00000000000000000000000        
               0000000000000000000000000       
              000000000000000000000000000      
              000000000000000000000000000      
             00000000000000000000000000000     
             0000000000000   00000000000000     
            000000000000       000000000000    
            00000000000         00000000000    
            0000000000   .00..   0000000000    
            0000000000  .0..0..  00000000001   
                        ....0..                
                        ....0..                
           1000000000   ...0...   0000000000   
            0        0  .......  0        01   
            0        0   ..0..   0        0    
            0         0         0         0    
            0         00       00         0    
             0          000 000          0     
             0            101            0     
              0                         0      
              00                       00      
               0                       0       
                0                     0        
                 00                 00         
                  00               00          
                    00           00            
                      00000000000  
        eos
      end
    end
  end

  def save_pokemon
    @pokemon_data.each do |pokemon_hash|
      pokemon = Pokemon.new(pokemon_hash)
      pokemon.save
    end
  end

  def save_to_db
    index_data_scrape
    pokemon_data_scrape
    pokemon_ascii_scrape

    save_pokemon
  end
end
