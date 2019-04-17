class Perfil < ApplicationRecord

  ADMIN = 1
  USUARIO = 2

  has_many :users
end
