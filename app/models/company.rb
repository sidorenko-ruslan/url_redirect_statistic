class Company < ActiveRecord::Base
	#validates :name, presense: true
	has_many :affiliates
end
