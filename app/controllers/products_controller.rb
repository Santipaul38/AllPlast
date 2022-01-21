class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show; end

  # GET /products/new
  def new
    @product = Product.new
    @categories = Category.all
  end

  # GET /products/1/edit
  def edit; end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    @product.registration_date = DateTime.now

    respond_to do |format|
      if @product.save
        format.html do
          redirect_to product_url(@product),
                      notice: 'El producto fue satisfactoriamente creado.'
        end
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @product.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      @product.registration_date = DateTime.now
      if @product.update(product_params)
        format.html do
          redirect_to product_url(@product),
                      notice: 'El producto fue satisfactoriamente actualizado.'
        end
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @product.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    CategoryProduct.where(product_id: @product.id).destroy_all
    @product.destroy

    respond_to do |format|
      format.html do
        redirect_to products_url,
                    notice: 'El producto fue satisfactoriamente eliminado.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params
      .require(:product)
      .permit(:name, :price, :stock, :registration_date, category_ids: [])
  end
end
