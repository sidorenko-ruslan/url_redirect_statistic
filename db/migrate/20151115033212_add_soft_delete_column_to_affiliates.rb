class AddSoftDeleteColumnToAffiliates < ActiveRecord::Migration
  def change
  	add_column :affiliates, :is_deleted, :boolean, default: false
  end
end
