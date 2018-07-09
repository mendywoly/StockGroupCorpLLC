
class StockSymbol < ApplicationRecord
    def self.get_symbol
        respon = RestClient.get("https://api.iextrading.com/1.0/ref-data/symbols", headers= { :accept => :json, content_type: :json })
        data = JSON.parse(respon.body)
        data.each do |sym|
            StockSymbol.find_or_create_by(stock_symbol: sym['symbol'], name:sym['name'], symbol_type: sym['type'], iexId: sym['iexId'])
        end
        binding.pry
    end

    def self.search(search)
        where("name ILIKE ? OR stock_symbol ILIKE ?", "%#{search}%", "%#{search}%") 
    end
end
