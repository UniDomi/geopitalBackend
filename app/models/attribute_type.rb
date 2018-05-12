class AttributeType < ApplicationRecord
  validates(:code, presence: true, uniqueness: true)
  validates(:nameDE, presence: true)
  validates(:nameFR, presence: true)
  validates(:nameIT, presence: true)
end
