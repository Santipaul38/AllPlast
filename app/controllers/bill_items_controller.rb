class BillItemsController < ApplicationController
  before_action :set_bill_item, only: %i[ show edit update destroy ]

  # GET /bill_items or /bill_items.json
  def index
    @bill_items = BillItem.all
  end

  # GET /bill_items/1 or /bill_items/1.json
  def show
  end

  # GET /bill_items/new
  def new
    @bill_item = BillItem.new
  end

  # GET /bill_items/1/edit
  def edit
  end

  # POST /bill_items or /bill_items.json
  def create
    @bill_item = BillItem.new(bill_item_params)

    respond_to do |format|
      if @bill_item.save
        format.html { redirect_to bill_item_url(@bill_item), notice: "Bill item was successfully created." }
        format.json { render :show, status: :created, location: @bill_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bill_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bill_items/1 or /bill_items/1.json
  def update
    respond_to do |format|
      if @bill_item.update(bill_item_params)
        format.html { redirect_to bill_item_url(@bill_item), notice: "Bill item was successfully updated." }
        format.json { render :show, status: :ok, location: @bill_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bill_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bill_items/1 or /bill_items/1.json
  def destroy
    @bill_item.destroy

    respond_to do |format|
      format.html { redirect_to bill_items_url, notice: "Bill item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill_item
      @bill_item = BillItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bill_item_params
      params.require(:bill_item).permit(:bill_id, :sale_detail_id)
    end
end
