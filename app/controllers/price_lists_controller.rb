class PriceListsController < ApplicationController
  before_action :set_price_list, only: %i[ show edit update destroy ]

  # GET /price_lists or /price_lists.json
  def index
    @price_lists = PriceList.where(:expiration_date => nil)
  end

  # GET /price_lists/1 or /price_lists/1.json
  def show
  end

  # GET /price_lists/new
  def new
    @price_list = PriceList.new
  end

  # GET /price_lists/1/edit
  def edit
  end

  # POST /price_lists or /price_lists.json
  def create
    @price_list = PriceList.new(price_list_params)
    @price_list.date = DateTime.now - 3.hours

    respond_to do |format|
      if @price_list.save
        format.html { redirect_to price_list_url(@price_list), notice: "La lista de precios fue satisfactoriamente creada." }
        format.json { render :show, status: :created, location: @price_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @price_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /price_lists/1 or /price_lists/1.json
  def update
    @oldList = PriceList.where(:id => @price_list.id, :expiration_date => nil).first
    @oldList.expiration_date = DateTime.now -3.hours
    @newList = PriceList.new()
    @newList.name = @price_list.name
    @newList.date = @price_list.date
    @newList.percentage = @price_list.percentage
    
    #Actualizar fecha de vencimiento de la lista antigua y crear nueva lista con nuevos valores
    if @newList.name != @oldList.name || @newList.percentage != @oldList.percentage
      if @oldList.update(:expiration_date => DateTime.now - 3.hours ) && @newList.save
        format.html { redirect_to price_lists_url, notice: "La lista de precios fue satisfactoriamente actualizada." }
        format.json { render :show, status: :ok, location: @price_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @price_list.errors, status: :unprocessable_entity }
      end
    else
      redirect_to price_lists_url
    end
  end

  # DELETE /price_lists/1 or /price_lists/1.json
  def destroy
    @price_list.destroy

    respond_to do |format|
      format.html { redirect_to price_lists_url, notice: "La lista de precios fue satisfactoriamente eliminada." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price_list
      @price_list = PriceList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def price_list_params
      params.require(:price_list).permit(:name, :date, :expiration_date, :percentage)
    end
end
