class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :login
      t.string :password
      t.timestamps null: false
    end
    User.create( :login => "qwe", :password => "qwe" )
  end
end
