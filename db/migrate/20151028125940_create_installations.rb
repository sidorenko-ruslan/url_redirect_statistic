class CreateInstallations < ActiveRecord::Migration
  def change
  	enable_extension 'uuid-ossp'
    create_table :installations do |t|
      t.string :affitiate_id
      t.string :device_id
      t.timestamps null: false
    end
  end
end
