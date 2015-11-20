class Affiliate < ActiveRecord::Base
	validates :name, presence: true
	belongs_to :company
	default_scope { order('name') }

end
