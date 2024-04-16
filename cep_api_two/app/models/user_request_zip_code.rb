class UserRequestZipCode < ApplicationRecord
  belongs_to :user
  belongs_to :zip_code
end
