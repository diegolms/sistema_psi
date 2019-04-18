class Vencimento < ApplicationRecord
	belongs_to :user
	
	ABERTO = 1
	PAGO = 2
	VENCIDO = 3
	
	STATUS = {'EM ABERTO' => ABERTO, 'PAGO' => PAGO, 'VENCIDO' => VENCIDO}
end
