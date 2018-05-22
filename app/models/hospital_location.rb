class HospitalLocation < ApplicationRecord
  validates(:name, presence: true)
  validates(:hospital_id, presence: true)
  belongs_to :hospital
end
