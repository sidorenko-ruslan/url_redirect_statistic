class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.timestamps null: false
    end
    Company.create( :name => "cpa.clicksure")
  end
end
