class SalesController < ApplicationController
  before_action :set_sale, only: %i[show edit update destroy]

  # GET /sales or /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1 or /sales/1.json
  def show; end

  # GET /sales/new
  def new
    @sale = Sale.new
  end

  # GET /sales/1/edit
  def edit; end

  # POST /sales or /sales.json
  def create
    @sale = Sale.new(sale_params)
    @sale.date = DateTime.now - 3.hours

    respond_to do |format|
      if @sale.save
        format.html do
          redirect_to sale_url(@sale),
                      notice: 'La venta fue satisfactoriamente creada.'
        end
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1 or /sales/1.json
  def update
    respond_to do |format|
      @sale.date = DateTime.now - 3.hours
      if @sale.update(sale_params)
        format.html do
          redirect_to sale_url(@sale),
                      notice: 'La venta fue satisfactoriamente actualizada.'
        end
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1 or /sales/1.json
  def destroy
    count = 0
    for i in Bill.all
      if i.sale_id == @sale.id
        count = count + 1
      end
    end

    if count == 0
      @sale.destroy
      respond_to do |format|
        format.html { redirect_to rates_url, notice: "La venta se eliminó correctamente." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to rates_url, notice: "La venta no pudo eliminarse porque tiene asociado una facturación." }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sale
    @sale = Sale.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def sale_params
    params.require(:sale).permit(:date, :client_id, :price_list_id)
  end
end
