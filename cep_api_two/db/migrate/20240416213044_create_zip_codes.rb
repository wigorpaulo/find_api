class CreateZipCodes < ActiveRecord::Migration[7.0]
  def up
    create_table :zip_codes do |t|
      t.string :zip_code
      t.string :address
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :complement

      t.timestamps
    end
  end

  def down
    drop_table :zip_codes
  end
end
