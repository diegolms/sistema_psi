require 'rubygems'
require 'prawn'
require 'prawn/table'
require 'date'


class RelatoriosController < ApplicationController

  def new
    @relatorio = Relatorio.new
   	session = nil
  end  

  def download_pdf

   @data_inicio = session[:relatorio_data_inicio] 
   @data_fim = session[:relatorio_data_fim] 
   @tipo_relatorio = session[:relatorio_tipo_relatorio]    
   template = ""
   
   if(@tipo_relatorio == TipoRelatorio::TIPO_LANCAMENTO)
      template = "relatorios/lancamentos.html.erb"
      @lancamentos = Lancamento.where(" date(data_pagamento) BETWEEN ? AND ? ", Date.parse(@data_inicio), Date.parse(@data_fim))
   end

	 respond_to do |format|   
      format.pdf do
		pdf_filename = File.join(Rails.root, "tmp/relatorio.pdf")
		send_file(pdf_filename, :filename => "relatorio.pdf", :type => "application/pdf")
      end
    end  
  end

  def gerar_relatorio

      
      
     if params[:authenticity_token].nil?
      redirect_to '/relatorios/new'
     else
 
      @tipo_relatorio = params[:relatorio][:tipo].to_i
      session[:relatorio_tipo_relatorio] = @tipo_relatorio
 
      template = ""
      
      if(@tipo_relatorio == TipoRelatorio::PRESTACAO_CONTAS)
		p "prestação contas"
	     session[:relatorio_periodo_inicio] = Date.parse(params[:relatorio][:periodo_])
	     session[:relatorio_periodo_fim] =  session[:relatorio_periodo_inicio].at_end_of_month
         template = "relatorios/lancamentos.html.erb"
         @lancamentos = Lancamento.where(" date(data_pagamento) BETWEEN ? AND ? ", session[:relatorio_periodo_inicio], session[:relatorio_periodo_fim])
      elsif(@tipo_relatorio == TipoRelatorio::PARCIAL)
		
		 @data_inicio = params[:relatorio][:data_inicio]
		  session[:relatorio_data_inicio] = @data_inicio
	 
		  @data_fim = params[:relatorio][:data_fim]
		  session[:relatorio_data_fim] = @data_fim
		  session[:relatorio_data] = Date.parse(@data_fim)
	      template = "relatorios/lancamentos.html.erb"
          @lancamentos = Lancamento.where(" date(data_pagamento) BETWEEN ? AND ? ", Date.parse(@data_inicio), Date.parse(@data_fim))
		 
		 p "prcial #{session[:relatorio_data]} - #{Date.parse(@data_fim)}"
	  
	  end
 
	  relatorio_pdf(@lancamentos)	
	  
	  pdf_filename = File.join(Rails.root, "tmp/relatorio.pdf")
	  send_file(pdf_filename, :filename => "tmp/relatorio.pdf", :disposition => 'inline', :type => "application/pdf", :target => "_blank")

     end  
	 	 
  end
  
	def relatorio_pdf(lancamentos)

		Prawn::Document.generate(File.join(Rails.root, "tmp/relatorio.pdf")) do |pdf|
		
         titulo = "" 
		 periodo = ""	
		 if(session[:relatorio_tipo_relatorio] == TipoRelatorio::PRESTACAO_CONTAS)
			session[:relatorio_data] = session[:relatorio_periodo_fim]			
			titulo = "PRESTAÇÃO DE CONTAS"
			periodo = meses(session[:relatorio_data].strftime("%_m"))+"/"+session[:relatorio_data].strftime("%Y")
		 elsif(session[:relatorio_tipo_relatorio] == TipoRelatorio::PARCIAL)	
		 	titulo = "LANCAMENTOS PARCIAIS"
			periodo = session[:relatorio_data_inicio]+" - "+session[:relatorio_data_fim]
			
			
		 end
		 
		 p session[:relatorio_tipo_relatorio]

		  initial_y = pdf.cursor
		  initialmove_y = 5
		  address_x = 35
		  invoice_header_x = 325
		  lineheight_y = 12
		  font_size = 9
		  
		  total_receita = 0
		  total_despesa = 0

		  pdf.move_down initialmove_y

		  # Add the font style and size
		  pdf.font "Helvetica"
		  

		  #start with EON Media Group
		  #pdf.text_box "Jesus do Porto V", :at => [address_x,  pdf.cursor]
		  #pdf.move_down lineheight_y
		  #pdf.text_box "1234 Some Street Suite 1703", :at => [address_x,  pdf.cursor]
		  #pdf.move_down lineheight_y
		  #pdf.text_box "Some City, ST 12345", :at => [address_x,  pdf.cursor]
		  #pdf.move_down lineheight_y

		  #last_measured_y = pdf.cursor
		  #pdf.move_cursor_to pdf.bounds.height

		  #pdf.image logopath, :width => 215, :position => :right

		  #pdf.move_cursor_to last_measured_y

		  # client address
		  #pdf.move_down 65
		  last_measured_y = pdf.cursor

		  pdf.font_size 20
		  pdf.text_box "CONDOMÍNIO RESIDENCIAL", :at => [address_x,  pdf.cursor], :align => :center, :style => :bold
		  pdf.move_down 20
		  pdf.text_box "JESUS DO PORTO V", :at => [address_x,  pdf.cursor], :align => :center, :style => :bold
		  pdf.move_down 30
		  
		  pdf.font_size 10
		  pdf.text_box "Rua Bel. Manoel Pereira Diniz, 727, Jardim Cidade Universitária,", :at => [address_x,  pdf.cursor],:align => :center, :style => :bold
		  pdf.move_down lineheight_y
		  pdf.text_box "João Pessoa/PB", :at => [address_x,  pdf.cursor],:align => :center, :style => :bold
		  pdf.move_down 40
		  
		  pdf.font_size 20
		  pdf.text_box titulo, :at => [address_x,  pdf.cursor], :align => :center, :style => :bold
		  pdf.move_down 20
      

		  
		  
		  pdf.text_box periodo, :at => [address_x,  pdf.cursor], :align => :center, :style => :bold
		  pdf.move_down 30

		  pdf.move_cursor_to last_measured_y
		  
		  pdf.font_size 15

		  pdf.move_down 170
		  
		  pdf.text_box "Receitas", :at => [0,  pdf.cursor], :style => :bold
		  
		  pdf.move_down 17
		  
		  pdf.font_size 9
		  
		  mensalidade = lancamentos.where("tipo = #{Lancamento::MENSALIDADE}")
		  
		   invoice_services_data = [ 
			["Item", "Descrição", "Quantidade", "Valor", "Total"]
		  ]
		  
		 if(mensalidade.size != 0)
			 invoice_services_data = [ 
			["Item", "Descrição", "Quantidade", "Valor", "Total"]
		  ]
			
			invoice_services_data << ["Taxa de Condomínio",
										meses(session[:relatorio_data].strftime("%_m"))+"/"+session[:relatorio_data].strftime("%Y"),
										mensalidade.count,
										formatar_numero(mensalidade.select(:valor).distinct[0][:valor]),	
										formatar_numero(mensalidade.sum(:valor))]
			
			total_receita += mensalidade.sum(:valor)
		  
		  
		  
		  pdf.table(invoice_services_data, :width => pdf.bounds.width) do
			style(row(1..-1).columns(0..-1), :padding => [4, 5, 4, 5], :borders => [:bottom], :border_color => 'dddddd')
			style(row(0), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
			style(row(0).columns(0..-1), :borders => [:top, :bottom])
			style(row(0).columns(0), :borders => [:top, :left, :bottom])
			style(row(0).columns(-1), :borders => [:top, :right, :bottom])
			style(row(-1), :border_width => 2)
			style(column(2..-1), :align => :right)
			style(columns(0), :width => 75)
			style(columns(1), :width => 275)
		  end
		  
		  pdf.move_down 1
		  
		 end

		 

		  invoice_services_totals_data = [ 
			["Total Receitas", formatar_numero(total_receita) ],
		  ]
		  
		  p "invoice_header_x #{invoice_header_x}"

		  pdf.table(invoice_services_totals_data, :position => invoice_header_x+35, :width => 180) do
			style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
			style(row(0), :font_style => :bold)
			style(row(1), :font_style => :bold)			
			style(column(1), :align => :right)

		  end

		  pdf.move_down 10
		  
		  pdf.font_size 15
		  
		  pdf.text_box "Despesas", :at => [0,  pdf.cursor], :style => :bold
		  
		  pdf.move_down 17
		  
		  pdf.font_size 9

		  invoice_services_data = [ 
			["Item", "Descrição", "Quantidade", "Valor", "Total"]
		  ]

		  mensalidade = lancamentos.where("tipo != #{Lancamento::MENSALIDADE}")
		  
		if(mensalidade.size != 0)
			 mensalidade.each do |despesa|
		 		   invoice_services_data << [despesa.descricao,
										despesa.observacao,
										1,
										formatar_numero(despesa.valor),	
										formatar_numero(despesa.valor)]
										
										total_despesa += despesa.valor
		 end
			
		  
		  
		  pdf.table(invoice_services_data, :width => pdf.bounds.width) do
			style(row(1..-1).columns(0..-1), :padding => [4, 5, 4, 5], :borders => [:bottom], :border_color => 'dddddd')
			style(row(0), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
			style(row(0).columns(0..-1), :borders => [:top, :bottom])
			style(row(0).columns(0), :borders => [:top, :left, :bottom])
			style(row(0).columns(-1), :borders => [:top, :right, :bottom])
			style(row(-1), :border_width => 2)
			style(column(2..-1), :align => :right)
			style(columns(0), :width => 75)
			style(columns(1), :width => 275)
		  end

		  pdf.move_down 1
		end
		  
		
		  

		  invoice_services_totals_data = [ 
			["Total Despesas",formatar_numero(total_despesa)]
		  ]

		  pdf.table(invoice_services_totals_data, :position => invoice_header_x+35, :width => 180) do
			style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
			style(row(0), :font_style => :bold)
			style(row(1), :font_style => :bold)
			style(row(2), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
			style(column(1), :align => :right)
		  end
		  
		  pdf.move_down 20
		  
		  invoice_services_totals_data = [ 
			["Total Receitas", formatar_numero(total_receita) ],
			["Total Despesas",formatar_numero(total_despesa)],
			["Subtotal", formatar_numero(total_receita-total_despesa)]
		  ]

		  pdf.table(invoice_services_totals_data, :position => 270, :width => 270) do
			style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
			style(row(0), :font_style => :bold)
			style(row(1), :font_style => :bold)
			style(row(2), :background_color => 'e9e9e9', :border_color => 'dddddd', :font_style => :bold)
			style(column(1), :align => :right)
			style(row(2).columns(0), :borders => [:top, :left, :bottom])
			style(row(2).columns(1), :borders => [:top, :right, :bottom])
		  end
		  
		  
		  pdf.move_down 20
		  
		  mes_anterior = session[:relatorio_data] - 1.month
		  proximo_mes = session[:relatorio_data] + 1.month
		  
		  caixa_atual = Caixa.last.valor
		  caixa_anterior = Caixa.where("date(created_at) BETWEEN ? AND ? ", mes_anterior.at_beginning_of_month, mes_anterior.at_end_of_month).last
		  caixa_anterior = (caixa_anterior.nil? ? 0 : caixa_anterior.valor)
		  
		  invoice_services_totals_data = [ 
			["Saldo Mês Anterior ("+meses(mes_anterior.strftime("%_m"))+"/"+mes_anterior.strftime("%Y")+")", formatar_numero(caixa_anterior)],
			["Saldo existente para mês de ("+meses(proximo_mes.strftime("%_m"))+"/"+proximo_mes.strftime("%Y")+")", formatar_numero(caixa_atual)],
		  ]

		  pdf.table(invoice_services_totals_data, :position => 270, :width => 270) do
			style(row(0..1).columns(0..1), :padding => [1, 5, 1, 5], :borders => [])
			style(row(0), :font_style => :bold)
			style(row(1), :font_style => :bold)
			style(column(1), :align => :right)
		  end

		  pdf.move_down 50
		  
		  if(caixa_atual == 0)
			pdf.text_box "Conforme prestação de contas acima, mostramos como resultado um saldo de #{formatar_numero(caixa_atual)}.", :at => [address_x,  pdf.cursor], :align => :left, :style => :bold
			else
				if caixa_atual < 0 
					caixa_atual = caixa_atual * (-1)
					pdf.text_box "Conforme prestação de contas acima, mostramos como resultado um saldo negativo de #{formatar_numero(caixa_atual)} (-#{Extenso.moeda(caixa_atual.to_f.to_s.gsub(".","").to_i)}).", :at => [address_x,  pdf.cursor], :align => :left, :style => :bold
				else
					pdf.text_box "Conforme prestação de contas acima, mostramos como resultado um saldo positivo de #{formatar_numero(caixa_atual)} (#{Extenso.moeda(caixa_atual.to_f.to_s.gsub(".","").to_i)}).", :at => [address_x,  pdf.cursor], :align => :left, :style => :bold	
				end			
			
		  end
		  

		  
		  pdf.move_down 50
		  
		  data_atual = Time.now
		  
		  pdf.text_box "João Pessoa, "+data_atual.strftime("%d")+ " de " +meses(data_atual.strftime("%_m"))+ " de "+ data_atual.strftime("%Y")+".", :at => [address_x,  pdf.cursor], :align => :right, :style => :bold
		  pdf.move_down 15
		  pdf.text_box "_____________________________", :at => [address_x,  pdf.cursor], :align => :right, :style => :bold
		  pdf.move_down 10
		  pdf.text_box "Responsável", :at => [address_x,  pdf.cursor], :align => :right, :style => :bold

		  
		  #invoice_terms_data = [ 
		#	["Terms"],
		#	["Payable upon receipt"]
		 # ]

		 # pdf.table(invoice_terms_data, :width => 275) do
		#	style(row(0..-1).columns(0..-1), :padding => [1, 0, 1, 0], :borders => [])
		#	style(row(0).columns(0), :font_style => :bold)
		 # end

		 # pdf.move_down 15

		 # invoice_notes_data = [ 
		#	["Notes"],
		#	["Thank you for doing business with Your Business Name"]
		 # ]

		 # pdf.table(invoice_notes_data, :width => 275) do
		#	style(row(0..-1).columns(0..-1), :padding => [1, 0, 1, 0], :borders => [])
		#	style(row(0).columns(0), :font_style => :bold)
		 # end

	
		  
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
end
