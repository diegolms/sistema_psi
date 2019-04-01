class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new]
 
  def index
    @lancamentos_receita = Lancamento.where("ativo = #{Constantes::ATIVO} and tipo = #{Lancamento::TIPO_LANCAMENTO_RECEITA}").sum(:valor) 
    @lancamentos_despesa = Lancamento.where("ativo = #{Constantes::ATIVO} and tipo = #{Lancamento::TIPO_LANCAMENTO_DESPESA}").sum(:valor)
    @pessoas = Pessoa.where("ativo = #{Constantes::ATIVO}").size	
  end
 
  def new
  end
end
