class SaleDetail < ApplicationRecord
    belongs_to :product
    belongs_to :sale
    has_one :bill_item

    validates_presence_of :unit, :import, :product_id, :sale_id, message: "Ingresar el dato correspondiente" 
    validates :unit, numericality: { only_integer: true }
    validates :import, numericality: { only_float: true }


end
