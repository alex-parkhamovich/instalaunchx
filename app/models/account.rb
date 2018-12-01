class Account < ApplicationRecord
  has_many :likes_counters
  has_many :promotions
end
