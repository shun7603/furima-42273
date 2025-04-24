class OrderAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id,
                :postal_code, :prefecture_id,
                :city, :address, :building,
                :phone_number, :token

  # 順番に注目！ここが表示順に影響するよ！
  validates :token,        presence: { message: "can't be blank" }
  validates :postal_code,  presence: { message: "can't be blank" }
  validates :postal_code,  format: {
    with: /\A\d{3}-\d{4}\z/,
    message: 'is invalid. Enter it as follows (e.g. 123-4567)'
  }
  validates :prefecture_id, numericality: {
    other_than: 1,
    message: "can't be blank"
  }
  validates :city,         presence: { message: "can't be blank" }
  validates :address,      presence: { message: "can't be blank" }
  validates :phone_number, presence: { message: "can't be blank" }
  validates :phone_number, length: {
    minimum: 10,
    message: 'is too short'
  }
  validates :phone_number, format: {
    with: /\A\d{10,11}\z/,
    message: 'is invalid. Input only number'
  }
  validates :user_id,      presence: { message: "can't be blank" }
  validates :item_id,      presence: { message: "can't be blank" }

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      order = Order.create!(user_id: user_id, item_id: item_id)
      Address.create!(
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        address: address,
        phone_number: phone_number,
        building: building,
        order_id: order.id
      )
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
