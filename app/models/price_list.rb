class PriceList < ApplicationRecord
    has_many :sales

    validates_presence_of :date, :percentage, message: "Ingresar el dato correspondiente" 
    validates :percentage, numericality: { only_float: true }

end
