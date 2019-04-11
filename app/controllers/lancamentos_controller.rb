class LancamentosController < ApplicationController
  before_action :set_lancamento, only: [:show, :edit, :update, :destroy]

  # GET /lancamentos
  # GET /lancamentos.json
  def index
    @lancamentos = Lancamento.where("ativo = #{Constantes::ATIVO}").order('lancamentos.id desc').paginate(:page => params[:page], :per_page => 10)	
  end

  # GET /lancamentos/1
  # GET /lancamentos/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
          render pdf: "Lancamento No. #{@lancamento.id}",
          page_size: 'A4',
          template: "lancamentos/show.html.erb",
          layout: "pdf.html",
          orientation: "Landscape",
          lowquality: true,
          zoom: 1,
          dpi: 75
      end
    end
  end

  # GET /lancamentos/new
  def new
    @lancamento = Lancamento.new
	@lancamento.tipo = Lancamento::TIPO_LANCAMENTO_RECEITA
  end

  # GET /lancamentos/1/edit
  def edit
	@lancamento.valor = @lancamento.valor.to_s.gsub(".",",")	
  end

  # POST /lancamentos
  # POST /lancamentos.json
  def create
    @lancamento = Lancamento.new(lancamento_params)
    @lancamento.pessoa_id = params[:lancamento][:pessoa_id]
    @lancamento.categoria_id = params[:lancamento][:categoria_id]
	@lancamento.valor = params[:lancamento][:valor].gsub(",", ".")
	@lancamento.movimenta_caixa = ActiveRecord::Type::Boolean.new.cast(params[:lancamento][:movimenta_caixa])
	
	if(@lancamento.movimenta_caixa)
		c = Caixa.new
		c.tipo_lancamento = @lancamento.tipo
		cAtual = Caixa.last.valor
		if(c.tipo_lancamento == Lancamento::TIPO_LANCAMENTO_RECEITA)
			c.valor = cAtual + @lancamento.valor
		else
			c.valor = cAtual - @lancamento.valor
		end
		
		c.save!
	end
	
	@lancamento.condominio = ActiveRecord::Type::Boolean.new.cast(params[:lancamento][:condominio])

    respond_to do |format|
      if @lancamento.save!
        format.html { redirect_to lancamentos_url, notice: 'Lancamento criado com sucesso.' }
        format.json { render :show, status: :created, location: @lancamento }
      else
        format.html { render :new }
        format.json { render json: @lancamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lancamentos/1
  # PATCH/PUT /lancamentos/1.json
  def update
    respond_to do |format|
	    @lancamento.pessoa_id = params[:lancamento][:pessoa_id]
		@lancamento.categoria_id = params[:lancamento][:categoria_id]
		@lancamento.valor = params[:lancamento][:valor].gsub(",", ".")
		@lancamento.movimenta_caixa = ActiveRecord::Type::Boolean.new.cast(params[:lancamento][:movimenta_caixa])
		@lancamento.condominio = ActiveRecord::Type::Boolean.new.cast(params[:lancamento][:condominio])
      if @lancamento.update(lancamento_params)
	    
        format.html { redirect_to lancamentos_url, notice: 'Lancamento editado com sucesso.' }
        format.json { render :show, status: :ok, location: @lancamento }
      else
        format.html { render :edit }
        format.json { render json: @lancamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lancamentos/1
  # DELETE /lancamentos/1.json
  def destroy
    @lancamento.ativo = Constantes::INATIVO
	@lancamento.save!
    respond_to do |format|
      format.html { redirect_to lancamentos_url, notice: 'Lancamento excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lancamento
      @lancamento = Lancamento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lancamento_params
      params.require(:lancamento).permit(:descricao, :data_vencimento, :data_pagamento, :valor, :observacao, :categoria_id, :pessoa_id, :tipo)
    end
end
