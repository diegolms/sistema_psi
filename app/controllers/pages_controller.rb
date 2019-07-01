class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new]
 
  def index
  #   @lancamentos_receita = Lancamento.where("ativo = #{Constantes::ATIVO} and tipo = #{Lancamento::TIPO_LANCAMENTO_RECEITA} and data_pagamento is not null").sum(:valor) 
  #   @lancamentos_despesa = Lancamento.where("ativo = #{Constantes::ATIVO} and tipo = #{Lancamento::TIPO_LANCAMENTO_DESPESA} and data_pagamento is not null").sum(:valor)
  # 	@lancamentos_despesa_futuras = Lancamento.where("ativo = #{Constantes::ATIVO} and tipo = #{Lancamento::TIPO_LANCAMENTO_DESPESA} and data_pagamento is null").sum(:valor)
	#   @lancamentos_receita_futuras = Lancamento.where("ativo = #{Constantes::ATIVO} and tipo = #{Lancamento::TIPO_LANCAMENTO_RECEITA} and data_pagamento is null").sum(:valor) 
	# @caixa = Caixa.last.valor
  #   @pessoas = Pessoa.where("ativo = #{Constantes::ATIVO} and id not in (1)").size	
  end
 
  def new
  end
end
