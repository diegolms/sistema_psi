class Lancamento < ApplicationRecord
  belongs_to :categoria, :class_name => "Categorium"
  belongs_to :pessoa
  has_one :caixa
  
  TIPO_LANCAMENTO_RECEITA = 1
  TIPO_LANCAMENTO_DESPESA = 2
  
  TIPO_LANCAMENTO = {'RECEITA' => TIPO_LANCAMENTO_RECEITA, 'DESPESA' => TIPO_LANCAMENTO_DESPESA}
  
  MENSALIDADE = 1

  
end
