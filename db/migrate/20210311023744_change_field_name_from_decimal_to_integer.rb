class ChangeFieldNameFromDecimalToInteger < ActiveRecord::Migration[6.1]
  def change
    change_column :products, :price, :integer
  end
end
