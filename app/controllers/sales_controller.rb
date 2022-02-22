class SalesController < ApplicationController
  before_action :set_sale, only: %i[show edit update destroy]

  # GET /sales or /sales.json
  def index
    @sales = Sale.all.order(date: :desc)

    if params[:name]
      @salesF = []
      for s in @sales
        name = "#{s.client.surname} #{s.client.name}".downcase
        if name.include?(params[:name].downcase) == true
          @salesF.push(s)
        end
      end
      @sales = @salesF
    end
  end

  # GET /sales/1 or /sales/1.json
  def show; end

  # GET /sales/new
  def new
    @sale = Sale.new

    @clients = []
    @lists = []

    for c in Client.all
      name = c.name+" "+c.surname
      id = c.id
      opt = [name, id]

      @clients.push(opt)
    end

    for l in PriceList.where(expiration_date: nil)
      name = l.name
      id = l.id
      opt = [name, id]

      @lists.push(opt)
    end

  end

  # GET /sales/1/edit
  # GET /sales/1/edit?product_id
  def edit

    if params[:product_id] and params[:quantity]
      priceListPercentage = (PriceList.where(:id => @sale.price_list_id).first.percentage / 100)
      productPrice = Product.where(:id => params[:product_id]).first.price
      totalPrice = productPrice.to_f + (productPrice.to_f * priceListPercentage)
      saleDetail = SaleDetail.new
      saleDetail.product_id = params[:product_id]
      saleDetail.sale_id = params[:id]
      saleDetail.unit = params[:quantity]
      saleDetail.import = (params[:quantity].to_i * totalPrice).to_f
      saleDetail.save
      
      product = Product.find_by(:id => params[:product_id])
      stock = product.stock - params[:quantity].to_i
      product.update(stock: stock)

      redirect_to edit_sale_url(@sale)
    end
    
  end

  # POST /sales or /sales.json
  def create
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
    count = 0
    for i in Bill.all
      if i.sale_id == @sale.id
        count = count + 1
      end
    end
    for d in @sale.sale_details
      product = Product.find_by(id: d.product_id)
      stock = product.stock + d.unit
      if d.destroy
        product.update(stock: stock)
      end
    end

    if count == 0
      @sale.destroy
      respond_to do |format|
        format.html { redirect_to sales_url, notice: "La venta se eliminó correctamente." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to sales_url, notice: "La venta no pudo eliminarse porque tiene asociado una facturación." }
        format.json { head :no_content }
      end
    end
  end

  # GET /sales/deleteDetails
  def deleteDetail
    @sale = Sale.find_by(id: params[:sale_id])
    @detail = SaleDetail.find_by(id: params[:detail_id])
    @product = Product.find_by(id: @detail.product_id)
    stock = @product.stock + @detail.unit
    if @detail.destroy
      @product.update(stock: stock)
      redirect_to edit_sale_path(@sale)
    end
  end

  def actualizarEdit
    
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
