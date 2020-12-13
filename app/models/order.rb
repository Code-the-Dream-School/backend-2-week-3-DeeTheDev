class Order < ApplicationRecord
  belongs_to :customer

  validates_presence_of :customer_id
  validates :product_name, presence: true
  validates :product_count, presence: true
  
  # validate :validate_customer_id
  
  # def validate_customer_id
  #   errors.add(:customer_id, "is invalid") unless Customer.exists?(self.customer_id)
  # end
end
