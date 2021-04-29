class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :nickname
    validates :birthday
  end
  with_options presence: true, format: { with: /\A(?=.*?[ぁ-んァ-ヶ一-龥々])[ぁ-んァ-ヶ一-龥々]+\z/i, message: 'Full-width characters' } do
    validates :family_name
    validates :first_name
  end
  with_options presence: true, format: { with: /\A(?=.*?[ァ-ヴ])[ァ-ヴ]+\z/i, message: 'Full-width katakana characters' } do
    validates :family_name_kana
    validates :first_name_kana
  end
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には半角英字と半角数字の両方を含めて設定してください'


  has_many :items
end
