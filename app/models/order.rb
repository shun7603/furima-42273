# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
end
