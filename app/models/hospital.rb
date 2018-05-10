class Hospital < ApplicationRecord
	validates(:name, presence: true)
	validates_uniqueness_of :name, scope: :year
end
