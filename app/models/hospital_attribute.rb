class HospitalAttribute < ApplicationRecord
  validates(:code, presence: true)
  validates(:year, presence: true)
  validates(:value, presence: true)
  validates(:attribute_type, presence: true, inclusion: { in: %w(string number) })
  validates(:hospital_id, presence: true)
  validates(:code, uniqueness: {scope: [:year, :hospital_id]})
  belongs_to :hospital
end
