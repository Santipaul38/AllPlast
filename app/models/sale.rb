class Sale < ApplicationRecord
  belongs_to :client
  has_one :bill
  belongs_to :price_list
  has_many :sale_details

  validates_presence_of :number_bill,
                        :date,
                        :client_id,
                        :bill_id,
                        :price_list_id,
                        message: 'Ingresar el dato correspondiente'
end
