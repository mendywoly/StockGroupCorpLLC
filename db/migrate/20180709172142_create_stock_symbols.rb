class CreateStockSymbols < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_symbols do |t|
      t.string :stock_symbol
      t.string :name
      t.string :symbol_type
      t.string :iexId      
      t.timestamps
    end
  end
end
