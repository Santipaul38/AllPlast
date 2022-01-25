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
  def edit 
    if params[:product_id]
      priceListPercentage = (PriceList.where(:id => @sale.price_list_id).first.percentage / 100)
      productPrice = Product.where(:id => params[:product_id]).first.price
      totalPrice = productPrice + (productPrice * priceListPercentage)
      saleDetail = SaleDetail.new
      saleDetail.product_id = params[:product_id]
      saleDetail.sale_id = params[:id]
      saleDetail.unit = params[:quantity]
      saleDetail.import = (params[:quantity] * totalPrice)
      saleDetail.save
    end
  end

  # POST /sales or /sales.json
  def create
    puts("WEPAAAAAAAA")
    puts(params[:products_ids])
    @sale = Sale.new(sale_params)
    @sale.date = DateTime.now - 3.hours

    
    respond_to do |format|
      if @sale.save
        format.html do
          redirect_to edit_sale_url(@sale)
        end
        format.json { render :edit, location: @sale }
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
    @sale.destroy

    respond_to do |format|
      format.html do
        redirect_to sales_url,
                    notice: 'La venta fue satisfactoriamente destruida.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sale
    @sale = Sale.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def sale_params
    params.require(:sale).permit(:date, :client_id, :price_list_id, products_ids: [])
  end
end
