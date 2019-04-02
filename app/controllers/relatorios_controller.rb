class RelatoriosController < ApplicationController

  def new
    @relatorio = Relatorio.new
  end  

  def gerar_relatorio

     @data_inicio = params[:relatorio][:data_inicio]
     @data_fim = params[:relatorio][:data_fim]
     @tipo_relatorio = params[:relatorio][:tipo].to_i

     template = ""
     
     if(@tipo_relatorio == TipoRelatorio::TIPO_LANCAMENTO)
        template = "relatorios/lancamentos.html.erb"
        @lancamentos = Lancamento.where("data_pagamento >= '#{@data_inicio}' and data_pagamento <= '#{@data_fim}'")
     end

    respond_to do |format|
      format.html
      format.pdf do
          render pdf: "Lancamento No. ",
          page_size: 'A4',
          template: template,
          layout: "pdf.html",
          orientation: "Landscape",
          lowquality: true,
          zoom: 1,
          dpi: 75
      end
    end
  end
end
