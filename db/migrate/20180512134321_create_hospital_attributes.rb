class CreateHospitalAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :hospital_attributes do |t|
      t.string :code
      t.integer :year
      t.string :attribute_type
      t.string :value
      t.string :de
      t.string :fr
      t.string :it
      t.references :hospital, foreign_key: true

      t.timestamps
    end
  end
end
