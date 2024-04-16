class CreateUserRequestZipCodes < ActiveRecord::Migration[7.0]
  def up
    create_table :user_request_zip_codes do |t|
      t.integer :user_id
      t.integer :zip_code_id

      t.timestamps
    end
  end

  def down
    drop_table :user_request_zip_codes
  end
end
