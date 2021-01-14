FactoryBot.define do
  factory :purchase_address do
    user_id { 1 }
    item_id { 1 }
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '横浜市' }
    address { ' 青山11-1' }
    building_name { '柳ビル101' }
    phone_number { '09099999999' }
  end
end
