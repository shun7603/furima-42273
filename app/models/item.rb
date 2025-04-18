class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :prefecture
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :shipping_day

  has_one :order
  belongs_to :user
  has_one_attached :image

  with_options presence: { message: "can't be blank" } do
    validates :item_name
    validates :description
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :shipping_day_id
    validates :image
    validates :price
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :shipping_day_id
  end

  validate :price_custom_validation

  private

  def price_custom_validation
    if price_before_type_cast.blank?
      errors.add(:price, "can't be blank")
      return
    end

    unless price_before_type_cast.to_s.match?(/\A[0-9]+\z/)
      errors.add(:price, 'is not a number')
      return
    end

    price_num = price_before_type_cast.to_i

    if price_num < 300
      errors.add(:price, 'Price must be greater than or equal to 300')
    elsif price_num > 9_999_999
      errors.add(:price, 'Price must be less than or equal to 9999999')
    end
  end
end
