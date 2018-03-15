require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do

 describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 1000.0) }
    let(:payment) { Payment.create!(amount: 10.0, loan_id: loan.id) }

    it 'responds with a 200' do
      get :index, params: { loan_id: loan.id }
      expect(response).to have_http_status(:ok)
    end

    it 'responds with a 200' do
      get :create, params: { loan_id: loan.id, amount: 50 }
      expect(response).to have_http_status(:ok)
    end

    it 'responds with error' do
      get :create, params: { loan_id: loan.id, amount: 1500 }
      expect(response.status).to eq(400)
    end

   end
end
