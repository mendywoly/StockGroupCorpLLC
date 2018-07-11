
class StockSymbol < ApplicationRecord
    has_many :favorites
    has_many :users, through: :favorites



    API_URL = 'https://api.iextrading.com/1.0/'
    def self.get_symbol
        respon = RestClient.get("#{API_URL}ref-data/symbols", headers= { :accept => :json, content_type: :json })
        data = JSON.parse(respon.body)
        data.each do |sym|
            StockSymbol.find_or_create_by(stock_symbol: sym['symbol'], name:sym['name'], symbol_type: sym['type'], iexId: sym['iexId'])
        end
        binding.pry
    end

    def self.search(search)
        where("name ILIKE ? OR stock_symbol ILIKE ?", "%#{search}%", "%#{search}%").limit(20) 
    end

    def self.fetch_data_api(symbol, api_endpoint)
        respon = RestClient.get("#{API_URL}stock/#{symbol}/#{api_endpoint}", headers= { :accept => :json, content_type: :json })
        data = JSON.parse(respon.body)
    end
end
