FactoryBot.define do
  factory :zip_code do
    id { 1 }
    address { 'MyString' }
    neighborhood { 'MyString' }
    city { 'MyString' }
    state { 'MyString' }
    complement { 'MyString' }
  end
end
