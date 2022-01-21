class Bill < ApplicationRecord
  belongs_to :sale

  validates_presence_of :total, message: 'Ingresar el dato correspondiente'
  validates :total, numericality: { only_float: true }
end
