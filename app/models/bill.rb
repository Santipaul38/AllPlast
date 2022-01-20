class Bill < ApplicationRecord
    has_many :sales

    validates_presence_of :total, message: "Ingresar el dato correspondiente"
    validates :total, numericality: { only_float: true }

end
