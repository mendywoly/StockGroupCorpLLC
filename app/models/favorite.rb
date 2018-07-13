class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :stock_symbol

  validates_uniqueness_of :stock_symbol_id, :scope => :user_id
end
