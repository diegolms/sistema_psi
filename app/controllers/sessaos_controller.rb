class SessaosController < ApplicationController
  before_action :set_sessao, only: [:show, :edit, :update, :destroy]

  # GET /sessaos
  # GET /sessaos.json
  def index
    @cliente = Cliente.find(params[:cliente])
    @sessaos = Sessao.joins(:cliente).where(clientes: { id: params[:cliente] }).order('data desc').paginate(:page => params[:page], :per_page => 10)	
    
  end

  # GET /sessaos/1
  # GET /sessaos/1.json
  def show
  end

  # GET /sessaos/new
  def new
    @sessao = Sessao.new
  end

  # GET /sessaos/1/edit
  def edit
  end

  # POST /sessaos
  # POST /sessaos.json
  def create

    @sessao = Sessao.new
    @sessao.data = params[:sessao_data]
    @sessao.cliente_id = params[:cliente].to_i

    respond_to do |format|
      if @sessao.save
        format.html { redirect_to sessaos_path(:cliente => @sessao.cliente_id), notice: 'Sessao criada com sucesso' }
        format.json { render :show, status: :created, location: @sessao }
      else
        format.html { render :new }
        format.json { render json: @sessao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sessaos/1
  # PATCH/PUT /sessaos/1.json
  def update
    respond_to do |format|
      if @sessao.update(sessao_params)
        format.html { redirect_to @sessao, notice: 'Sessao was successfully updated.' }
        format.json { render :show, status: :ok, location: @sessao }
      else
        format.html { render :edit }
        format.json { render json: @sessao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessaos/1
  # DELETE /sessaos/1.json
  def destroy
    @sessao.destroy
    respond_to do |format|
      format.html { redirect_to sessaos_url, notice: 'Sessao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sessao
      @sessao = Sessao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sessao_params
      params.require(:sessao).permit(:data)
    end
end
