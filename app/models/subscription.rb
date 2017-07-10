class Subscription < ApplicationRecord
  has_one :user
  validates_presence_of :payment_method_token
end
