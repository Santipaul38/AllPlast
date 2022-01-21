class Client < ApplicationRecord
    has_many :sales

    validates_presence_of :name, :surname, :business, :phone_number, :email, message: "Ingresar el dato correspondiente" 
    validates :name, :surname, :business, format: { with: /\A[a-z]+\z/i, message: "Por favor, solamente use letras" }
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
