class BillsController < ApplicationController
  before_action :set_bill, only: %i[show edit update destroy]

  # GET /bills or /bills.json
  def index
    # @bills = Bill.all
    redirect_to sales_path
  end

  # GET /bills/1 or /bills/1.json
  def show; end

  # GET /bills/new
  def new
    @bill = Bill.new
  end

  # GET /bills/1/edit
  def edit; end

  # POST /bills or /bills.json
  def create
    @bill = Bill.new(bill_params)
    @bill.date = DateTime.now - 3.hours

    respond_to do |format|
      if @bill.save
        for d in @bill.sale.sale_details
          item = BillItem.new
          item.bill_id = @bill.id
          item.sale_detail_id = d.id
          item.save
        end
        format.html do
          redirect_to bill_url(@bill),
                      notice: 'La factura fue creada satisfactoriamente.'
        end
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1 or /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html do
          redirect_to bill_url(@bill),
                      notice: 'La factura fue actualizada satifactoriamente.'
        end
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1 or /bills/1.json
  def destroy
    # @bill.destroy

    respond_to do |format|
      format.html do
        redirect_to bills_url,
                    notice: 'La factura fue eliminada satisfactoriamente.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bill
    @bill = Bill.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bill_params
    params.require(:bill).permit(:total, :sale_id, :date)
  end
end
