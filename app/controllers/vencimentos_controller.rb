class VencimentosController < ApplicationController
  before_action :set_vencimento, only: [:show, :edit, :update, :destroy]

  # GET /vencimentos
  # GET /vencimentos.json
  def index
    conditions = 
	@vencimentos = Vencimento.where(current_user.isAdmin? ? "" : "user_id = #{current_user.id}").order('vencimentos.id desc').paginate(:page => params[:page], :per_page => 10)
  end

  # GET /vencimentos/1
  # GET /vencimentos/1.json
  def show
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
        format.html { redirect_to @vencimento, notice: 'Vencimento was successfully created.' }
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
        format.html { redirect_to @vencimento, notice: 'Vencimento was successfully updated.' }
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
    @vencimento.destroy
    respond_to do |format|
      format.html { redirect_to vencimentos_url, notice: 'Vencimento was successfully destroyed.' }
      format.json { head :no_content }
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
