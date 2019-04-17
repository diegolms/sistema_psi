class Vencimento < ApplicationRecord
	belongs_to :user
	
	ABERTO = 1
	PAGO = 2
	VENCIDO = 3
	CANCELADO = 3
	
	VENCIMENTOS = {'ABERTO' => ABERTO, 'PAGO' => PAGO, 'VENCIDO' => VENCIDO, 'CANCELADO' => CANCELADO }
end
