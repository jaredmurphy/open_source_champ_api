class CreateLosers < ActiveRecord::Migration[5.0]
  def change
    create_table :losers do |t|

      t.timestamps
    end
  end
end
