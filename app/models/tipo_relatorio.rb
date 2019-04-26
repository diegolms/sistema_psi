class TipoRelatorio < ApplicationRecord

    PRESTACAO_CONTAS = 1
	PARCIAL = 2
	
	RELATORIOS = {'Prestação de Contas' => PRESTACAO_CONTAS, 'Parcial' => PARCIAL}
end
