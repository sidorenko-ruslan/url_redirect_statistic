class CreateInstallations < ActiveRecord::Migration
  def change
    create_table :installations do |t|
      t.date :date
      t.integer :count
      t.string :source
      t.timestamps null: false
    end
  end
end
