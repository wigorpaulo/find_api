FactoryBot.define do
  factory :zip_code do
    id { 1 }
    zip_code { '74463500' }
    address { 'rua 18' }
    neighborhood { 'Central' }
    city { 'Goiania' }
    state { 'GO' }
    complement { 'Proximo ao supermecado' }
  end
end
