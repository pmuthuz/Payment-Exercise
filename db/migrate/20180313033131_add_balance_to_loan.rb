class AddBalanceToLoan < ActiveRecord::Migration[5.1]
  def change
    add_column :loans, :balance, :decimal, precision: 8, scale: 2
  end
end
