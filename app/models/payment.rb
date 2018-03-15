class Payment < ApplicationRecord
  belongs_to :loan
  before_create :set_payment_date_as_today

  def process_payment
    self.loan.balance -= self.amount
    self.save
    self.loan.save 
  end

  def balance
    self.loan.balance
  end

  def set_payment_date_as_today
    self.payment_date = Time.now
  end

  def can_process_payment?
    self.loan.balance > self.amount
  end
end
