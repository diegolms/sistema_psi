class Cliente < ApplicationRecord

    has_many :sessaos

    before_save { self.nome.upcase!}

end
