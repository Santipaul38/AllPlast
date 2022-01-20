class Sale < ApplicationRecord
    belongs_to :client
    belongs_to :bill
    belongs_to :price_list

    has_many :sale_details
end
