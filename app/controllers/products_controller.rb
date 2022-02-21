class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    @products = Product.where(:state => 0)
  end

  # GET /products/1 or /products/1.json
  def show; end

  # GET /products/new
  def new
    @product = Product.new
    @categories = []

    for c in Category.all
      name = c.name
      id = c.id
      opt = [name, id]

      @categories.push(opt)
    end
  end

  # GET /products/1/edit
  def edit; 
    @categories = []

    for c in Category.all
      p = CategoryProduct.find_by(:product_id => @product.id, :category_id => c.id)
      
      name = c.name
      id = c.id
      opt = [name, id]

      if !p
        @categories.push(opt)
      end
    end

    if params[:category_id]
      cat = Category.find_by(id: params[:category_id])
      pcat = CategoryProduct.new
      pcat.category_id = params[:category_id]
      pcat.product_id = @product.id
      pcat.save

      redirect_to edit_product_url(@product)
    end

  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    @product.registration_date = DateTime.now - 3.hours
    @product.state = 0
    @product.max_stock = @product.stock

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
      @product.registration_date = DateTime.now - 3.hours
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
    if SaleDetail.where(:product_id => @product.id).count == 0
      CategoryProduct.where(product_id: @product.id).destroy_all
    else
      @product.update(:state => 2)
    end

    respond_to do |format|
      format.html do
        redirect_to products_url,
                    notice: 'El producto fue satisfactoriamente eliminado.'
      end
      format.json { head :no_content }
    end
  end

  def deleteCategory
    @product = Product.find_by(id: params[:product_id])
    @category = CategoryProduct.find_by(category_id: params[:category_id], product_id: params[:product_id])
    @category.destroy
    # puts("El producto a eliminar es #{@category.id}")
    redirect_to edit_product_path(@product)

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
      .permit(:name, :price, :state, :stock, :registration_date, category_ids: [])
  end
end
