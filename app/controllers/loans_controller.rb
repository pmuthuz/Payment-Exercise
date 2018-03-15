class LoansController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: Loan.all
  end

  def show
    render json: Loan.find(params[:id])
  end

  def create
    @loan = Loan.new(funded_amount: params[:funded_amount], balance: params[:funded_amount])
    @loan.save
    #render status "created"
  end

  def update
    @loan = Loan.find(params[:id])
    if @loan.valid?
      @loan.funded_amount = params[:funded_amount]
      @loan.save
    else
      @loan = Loan.new(params[:funded_amount])
      @loan.save
    end
  end
end
