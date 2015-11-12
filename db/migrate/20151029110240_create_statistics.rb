class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.date :date
      t.integer :count
      t.string :affiliate_id
      t.timestamps null: false
    end
  end
end
