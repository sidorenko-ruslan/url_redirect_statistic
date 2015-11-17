class Affiliate < ActiveRecord::Base
	#validates :name, presense: true
	belongs_to :company
	default_scope { order('name') }

end
