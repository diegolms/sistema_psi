class Pessoa < ApplicationRecord
	has_one :user
	has_many :vencimentos
end
