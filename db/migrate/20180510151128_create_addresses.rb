class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :streetAndNumber
      t.string :plzAndCity

      t.timestamps
    end
  end
end
