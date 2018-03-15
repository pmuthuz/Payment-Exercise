class PaymentsController < ActionController::API
  before_action :set_payment, only: [:show, :update, :destroy, :create]

  # GET /payments.json
  def index
    @payments = Payment.all
    render json: @payments
  end

  # GET /payments/1.json
  def show
  end

  # POST /payments.json
  def create
     if params[:loan_id].to_i.is_a? Integer
        begin
          @payment = Payment.new(:amount => params[:amount].to_f, :loan_id => params[:loan_id].to_i)
          if @payment.can_process_payment?
          Payment.transaction do
            @payment.process_payment
          end
          render :json => @payment, :methods => :balance
        else
          render json: {status: "Error", message: "Balance is less than Payment amount" }, :status => 400
        end
        rescue StandardError => e
          render json: {status: "Error", message: "Invlaid input parameters" }, :status => 400
        end
     else
       render json: {status: "Error", message: "Invlaid input parameters 2" }, :status => 400
     end
  end

  # PATCH/PUT /payments/1.json
  def update
     @payment.update(payment_params)
     render json: @payment.errors, status: :unprocessable_entity
  end

  # DELETE /payments/1.json
  def destroy
    @payment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.fetch(:payment, {})
    end
end
