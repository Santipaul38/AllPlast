class Product < ApplicationRecord
  has_many :category_products
  has_many :categories, through: :category_products
  
  has_many :sale_details
  has_many :sales, through: :sale_details

  validates_presence_of :name,
                        :price,
                        :stock,
                        :category_ids,
                        message: 'Ingresar el dato correspondiente.'
  validates :name,
            format: {
              with: /\A[a-z0-9\s]+\Z/i,
              message: 'debe contener letras y/o números.',
            }
  validates :price,
            numericality: {
              only_float: true,
              greater_than: 0,
              message: 'debe ser un número.',
            }

  validate :exist

  def exist
    return false
  end
  
  
end
