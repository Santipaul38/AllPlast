class Sale < ApplicationRecord
  belongs_to :client
  has_one :bill
  belongs_to :price_list

  has_many :sale_details
  has_many :products, through: :sale_details

  validates_presence_of :date,
                        :client_id,
                        :price_list_id,
                        message: 'Ingresar el dato correspondiente'

  def totalPrice
    total = 0
    for detail in self.sale_details
      total += detail.import
    end
    return total.round(2)
  end
  
end
