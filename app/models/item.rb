class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  with_options presence: true do
    validates :item_name
    validates :description
    validates :category_id
    validates :status_id
    validates :charge_id
    validates :sellerprefecture_id
    validates :day_id
    validates :price
    validates :image
  end
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :charge_id
    validates :sellerprefecture_id
    validates :day_id
  end
  
  validates_inclusion_of :price, in: 300..9999999, message: 'should be entered as a half-width number from 300 to 9999999'
  belongs_to :user
  belongs_to :category
  belongs_to :status
  belongs_to :charge
  belongs_to :sellerprefecture
  belongs_to :day

  has_one_attached :image

end
