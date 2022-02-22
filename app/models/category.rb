class Category < ApplicationRecord
    has_many :category_products
    has_many :products, through: :category_products

    validates_presence_of :name, message: "Ingresar el dato correspondiente" 
    validates :name, format: { with: /\A[a-z0-9\s]+\Z/i, message: "debe contener letras y/o números." }
    validates :name, uniqueness: { case_sensitive: false, message: ": Esta categoría ya existe" }
end
