FactoryBot.define do
  factory :item do
    name           { '物' }
    introduce      { 'とても綺麗な物です' }
    category_id       { 2 }
    state_id          { 2 }
    postage_id        { 2 }
    prefecture_id     { 2 }
    shipping_date_id  { 2 }
    price             { 300 }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
