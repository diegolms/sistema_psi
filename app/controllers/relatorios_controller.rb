class RelatoriosController < ApplicationController

  def new
    @relatorio = Relatorio.new
  end  

  def download_pdf

   p "session #{session[:conditions_relatorio]}"  
   p "params - #{params}" 

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
        render pdf: "Lancamento No. ",
        page_size: 'A4',
        template: "relatorios/gerar_relatorio.html.erb",
        encoding: 'utf8',
        layout: "pdf.html",
        orientation: "Landscape",
        lowquality: true,
        zoom: 1,
        dpi: 75
      end
    end  
  end

  def gerar_relatorio

      p "params - #{params}"  
      
     if params[:authenticity_token].nil?
      redirect_to '/relatorios/new'
     else
      @data_inicio = params[:relatorio][:data_inicio]
      session[:relatorio_data_inicio] = @data_inicio
 
      @data_fim = params[:relatorio][:data_fim]
      session[:relatorio_data_fim] = @data_fim
 
      @tipo_relatorio = params[:relatorio][:tipo].to_i
      session[:relatorio_tipo_relatorio] = @tipo_relatorio
 
      template = ""
      
      if(@tipo_relatorio == TipoRelatorio::TIPO_LANCAMENTO)
         template = "relatorios/lancamentos.html.erb"
         @lancamentos = Lancamento.where(" date(data_pagamento) BETWEEN ? AND ? ", Date.parse(@data_inicio), Date.parse(@data_fim))
      end

      redirect_to '/relatorios/download_pdf'
 
     respond_to do |format|
       format.html
       format.pdf do
         render pdf: "Lancamento No. ",
         page_size: 'A4',
         template: "relatorios/gerar_relatorio.html.erb",
         encoding: 'utf8',
         layout: "pdf.html",
         orientation: "Landscape",
         lowquality: true,
         zoom: 1,
         dpi: 75
       end
     end

     end  

     
  end
end
