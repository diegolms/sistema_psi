class RelatoriosController < ApplicationController

  def new
    @relatorio = Relatorio.new
  end  

  def download_pdf

    @tipo_relatorio = 1
    @lancamentos = Lancamento.where(" date(data_pagamento) BETWEEN ? AND ? ", Date.parse("01/04/2019"), Date.parse("30/04/2019"))

    respond_to do |format|   
      format.pdf do
        render pdf: "Lancamento No. ",
        page_size: 'A4',
        template: "relatorios/gerar_relatorio.html.erb",
        layout: "pdf.html",
        orientation: "Landscape",
        lowquality: true,
        zoom: 1,
        dpi: 75
      end
    end  
  end

  def gerar_relatorio

     @data_inicio = params[:relatorio][:data_inicio]
     @data_fim = params[:relatorio][:data_fim]
     @tipo_relatorio = params[:relatorio][:tipo].to_i

     template = ""
     
     if(@tipo_relatorio == TipoRelatorio::TIPO_LANCAMENTO)
        template = "relatorios/lancamentos.html.erb"
        @lancamentos = Lancamento.where(" date(data_pagamento) BETWEEN ? AND ? ", Date.parse(@data_inicio), Date.parse(@data_fim))
     end

    respond_to do |format|
      format.html
    end
  end
end
