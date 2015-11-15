class Affiliate < ActiveRecord::Base
	belongs_to :company
	default_scope { order('name') }
end
