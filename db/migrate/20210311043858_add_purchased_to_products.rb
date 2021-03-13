class AddPurchasedToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :purchased, :boolean, default: false
    end
end
