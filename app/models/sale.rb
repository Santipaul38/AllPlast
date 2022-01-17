class Sale < ApplicationRecord
    belongs_to :client
    belongs_to :bill
    belongs_to :price

    has_many :sale_details
end
