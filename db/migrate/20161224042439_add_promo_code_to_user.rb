class AddPromoCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :promocode, :string
  end
end
