require 'rubygems'
require 'prawn'
require 'prawn/table'
require 'date'

class VencimentosController < ApplicationController
  before_action :set_vencimento, only: [:show, :edit, :update, :destroy]

  # GET /vencimentos
  # GET /vencimentos.json
  def index
  
  
		p "params #{params}"
		
	  conditions = 	current_user.isAdmin? ? "pessoa_id is not null" : "pessoa_id = #{current_user.pessoa.id}"
	  @meses = Vencimento.where(conditions).order("vencimentos.id asc, data").group(:data)
	  @pessoas = Pessoa.where(:ativo => Constantes::ATIVO).where.not(id: 1).order("id asc")
	  
	  if !params[:vencimento].nil?
			if !params[:vencimento][:mes].empty?	
				p "params #{params[:vencimento][:mes]}"	
				p "params empty #{params[:vencimento][:mes].empty?}"	
				conditions += " and data = '#{params[:vencimento][:mes]}'"
			end
			
			 if !params[:vencimento][:pessoa_id].empty?
				conditions += " and pessoa_id = '#{params[:vencimento][:pessoa_id]}'"	  
			end
			
	  end
	 	  
      @vencimentos = Vencimento.where(conditions).order("vencimentos.id asc, data").paginate(:page => params[:page], :per_page => 10)

  end

  # GET /vencimentos/1
  # GET /vencimentos/1.json
  def show

    p "params #{params}"

    # if params[:authenticity_token].nil?
    #   p "enctrou"
    #   redirect_to '/vencimentos'
    # else
      recibo_pdf(@vencimento)	
	  
      pdf_filename = File.join(Rails.root, "tmp/recibo.pdf")
      send_file(pdf_filename, :filename => "tmp/recibo.pdf", :disposition => 'inline', :type => "application/pdf", :target => "_blank")
  
    # end  


  end

  # GET /vencimentos/new
  def new
    @vencimento = Vencimento.new
  end

  # GET /vencimentos/1/edit
  def edit
  end

  # POST /vencimentos
  # POST /vencimentos.json
  def create
    @vencimento = Vencimento.new(vencimento_params)

    respond_to do |format|
      if @vencimento.save
        format.html { redirect_to @vencimento, notice: "Vencimento was successfully created." }
        format.json { render :show, status: :created, location: @vencimento }
      else
        format.html { render :new }
        format.json { render json: @vencimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vencimentos/1
  # PATCH/PUT /vencimentos/1.json
  def update
    respond_to do |format|
      if @vencimento.update(vencimento_params)
        format.html { redirect_to @vencimento, notice: "Vencimento was successfully updated." }
        format.json { render :show, status: :ok, location: @vencimento }
      else
        format.html { render :edit }
        format.json { render json: @vencimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vencimentos/1
  # DELETE /vencimentos/1.json
  def destroy
    #@vencimento.destroy
    @vencimento.status = params[:status].to_i
    @vencimento.save!

    lancamento = Lancamento.new
    lancamento.descricao = "Mensalidade #{@vencimento.data.strftime("%m/%Y")}"
    lancamento.data_vencimento = @vencimento.data_vencimento
    lancamento.data_pagamento = Time.now
    lancamento.valor = 150
    lancamento.categoria_id = Lancamento::MENSALIDADE
    lancamento.tipo = Lancamento::TIPO_LANCAMENTO_RECEITA
    lancamento.pessoa_id = @vencimento.pessoa_id

    lancamento.save!

    c = Caixa.new
    c.tipo_lancamento = lancamento.tipo
    cAtual = Caixa.last.valor
    c.valor = cAtual + lancamento.valor
    c.user_id = current_user.id
    c.save!

    lancamento.caixa_id = c.id
    lancamento.save!

    respond_to do |format|
      format.html { redirect_to vencimentos_url, notice: "Vencimento alterado com sucesso" }
      format.json { head :no_content }
    end
  end

  def recibo_pdf(vencimento)

		Prawn::Document.generate(File.join(Rails.root, "tmp/recibo.pdf")) do |pdf|
		
      initial_y = pdf.cursor
		  initialmove_y = 5
		  address_x = 0
		  invoice_header_x = 325
		  lineheight_y = 12
		  font_size = 11

		  pdf.move_down initialmove_y
		  pdf.font "Helvetica"
		  pdf.font_size font_size

		   last_measured_y = pdf.cursor

		  pdf.text_box "Condomínio Residencial Jesus do Porto V", :at => [address_x,  pdf.cursor]
		  pdf.move_down lineheight_y
		  pdf.text_box "Rua Bel. Manoel Pereira Diniz, 727", :at => [address_x,  pdf.cursor]
		  pdf.move_down lineheight_y
		  pdf.text_box "Jardim Cidade Universitária, João Pessoa/PB", :at => [address_x,  pdf.cursor]

		  pdf.move_cursor_to last_measured_y

      mes = meses(vencimento.data.strftime("%_m"))+"/"+vencimento.data.strftime("%Y")

		  invoice_header_data = [ 
      ["Mês", mes],
      ["Apartamento", vencimento.pessoa.numero],
			["Taxa de Condomínio", formatar_numero(vencimento.valor)]
		  ]

		  pdf.table(invoice_header_data, :position => invoice_header_x, :width => 215) do
			style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
			style(row(2), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
			style(column(1), :align => :right)
			style(row(2).columns(0), :borders => [:top, :left, :bottom])
			style(row(2).columns(1), :borders => [:top, :right, :bottom])
		  end
      
      #pdf.move_cursor_to last_measured_y
      pdf.font_size 15
      pdf.move_down 25

      pdf.text_box "RECIBO", :at => [address_x,  pdf.cursor], :align => :center, :style => :bold
      pdf.font_size 13

      pdf.move_down 40

      nome_completo = vencimento.pessoa.nome_completo
      valor = formatar_numero(vencimento.valor)      
      valor_extenso = Extenso.moeda( valor.to_s.split(" ")[1].gsub(",","").to_i)
      pdf.text_box "\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0Recebi do(a) Sr(a). #{nome_completo.upcase}, a quantia de #{valor} (#{valor_extenso}), referente à taxa de condomínio do Residencial Jesus do Porto V, no mês de #{mes}, pelo qual dou plena e total quitação.", :at => [address_x,  pdf.cursor], :align => :justify
      
      pdf.move_down 80
		  
		  data_atual = Time.now
		  
		  pdf.text_box "João Pessoa, "+data_atual.strftime("%d")+ " de " +meses(data_atual.strftime("%_m"))+ " de "+ data_atual.strftime("%Y")+".", :at => [address_x,  pdf.cursor], :align => :right, :style => :bold
		  pdf.move_down 15
		  pdf.text_box "_____________________________", :at => [address_x,  pdf.cursor], :align => :right, :style => :bold
		  pdf.move_down 20
		  pdf.text_box "Responsável", :at => [address_x,  pdf.cursor], :align => :right, :style => :bold
  

    

		 
	
		  
			#DOWNLOAD
		    ##pdf_filename = File.join(Rails.root, "tmp/relatorio.pdf")
			##send_file(pdf_filename, :filename => "relatorio.pdf", :type => "application/pdf")
			###	

		end
	end

  def formatar_numero(numero)
		ActionController::Base.helpers.number_to_currency(numero)
	end
	
	def meses(mes)
		case mes.to_i
			when 1
				"Janeiro"
			when 2
				"Fevereiro"
			when 3		
				"Março"
			when 4
				"Abril"
			when 5
				"Maio"
			when 6
				"Junho"
			when 7		
				"Julho"
			when 8
				"Agosto"
			when 9
				"Setembro"
			when 10
				"Outubro"
			when 11	
				"Novembro"
			when 12
				"Dezembro"			
			end
	end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vencimento
    @vencimento = Vencimento.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vencimento_params
    params.fetch(:vencimento, {})
  end
end
