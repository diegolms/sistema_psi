class RelatoriosController < ApplicationController
  def index
    @relatorios = Relatorio.all.order('id desc').paginate(:page => params[:page], :per_page => 10)	
  end

  def show
  end

  def new
  end  
end
