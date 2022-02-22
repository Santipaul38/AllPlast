class ClientsController < ApplicationController
  before_action :set_client, only: %i[ show edit update destroy ]

  # GET /clients or /clients.json
  def index
    @clients = Client.all

    if params[:name]
      @clients= @clients.where('name LIKE ?', "%#{params[:name]}%")
    end
    if params[:surname]
      @clients= @clients.where('surname LIKE ?', "%#{params[:surname]}%")
    end


  end

  # GET /clients/1 or /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients or /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to client_url(@client), notice: "El cliente fue satisfactoriamente creado." }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to client_url(@client), notice: "El cliente fue satisfactoriamente actualizado." }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1 or /clients/1.json
  def destroy
    count = 0
    for i in Sale.all
      if i.client_id == @client.id
        count = count + 1
      end
    end

    if count == 0
      @client.destroy
      respond_to do |format|
        format.html { redirect_to clients_url, notice: "El cliente se eliminó correctamente." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to client_url(@client), notice: "El cliente no pudo eliminarse porque tiene asociado una venta." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:name, :surname, :business, :phone_number, :email)
    end
end
