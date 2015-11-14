class CreateAffiliates < ActiveRecord::Migration
  def change
    create_table :affiliates do |t|
      t.string :name
      t.string :company_id
      t.boolean :is_enabled
      t.timestamps null: false
    end
    Affiliate.create( :name => "lilianarex", :company_id => Company.first.id, :is_enabled => true)
  end
end
