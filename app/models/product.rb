class Product < ApplicationRecord
  has_many :category_products
  has_many :categories, through: :category_products
  
  has_many :sale_details
  has_many :sales, through: :sale_details

  validates :price,
            numericality: {
              only_float: true,
              greater_than: 0,
              message: 'debe ser un número.',
            }

  validates :name, uniqueness: {:scope => :state, message: ": Este producto ya existe", on: :create }
  
end
