FactoryBot.define do
  factory :item do
    item_name            { 'サンプル' }
    description          { 'サンプル' }
    category_id          { 2 }
    status_id            { 2 }
    charge_id            { 2 }
    sellerprefecture_id  { 2 }
    day_id               { 2 }
    price                { 10_000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
