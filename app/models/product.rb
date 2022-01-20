class Product < ApplicationRecord
    has_many :category_products
    has_many :categories, through: :category_products
    has_many :sale_details

    validates_presence_of :name, :price, :stock, :registration_date, :category_ids, message: "Ingresar el dato correspondiente" 
    validates :name, format: { with: /\A[a-z]+\z/i, message: "Por favor, solamente use letras" }
    validates :price, numericality: { only_float: true }

end
