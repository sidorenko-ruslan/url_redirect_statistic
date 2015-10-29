class CreateInstallations < ActiveRecord::Migration
  def change
    create_table :installations do |t|
      t.string :source
      t.string :device_id
      t.timestamps null: false
    end
  end
end
