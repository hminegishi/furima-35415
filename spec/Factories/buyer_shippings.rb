FactoryBot.define do
  factory :buyer_shipping do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    phone { '09012345678' }
    user_id { 1 }
    item_id { 1 }
  end
end
