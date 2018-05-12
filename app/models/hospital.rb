class Hospital < ApplicationRecord
	validates(:name, presence: true, uniqueness: {case_sensitive: false})
	has_many :hospital_locations, :dependent => :destroy
end
