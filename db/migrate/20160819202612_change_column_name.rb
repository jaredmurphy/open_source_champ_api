class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :players, :type, :kind
  end
end
