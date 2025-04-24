class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders
  validates :nickname, presence: true
  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date, presence: true
  validates :last_name, :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'はひらがな・カタカナ・漢字で入力してください' }
  validates :last_name_kana, :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナで入力してください' }

  validate :password_complexity
  def password_complexity
    return unless password.present?

    errors.add(:password, 'は半角英数字混合で入力してください') unless password.match?(/\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/)
    return if password.match?(/\A[a-zA-Z\d]{6,}\z/)

    errors.add(:password, 'は6文字以上で入力してください')
  end
  # validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'は半角英数字混合で入力してください' }
  # validates :password, format: { with: /\A[a-zA-Z\d]{6,}\z/, message: 'は6文字以上で入力してください' }
end
