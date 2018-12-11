class Account < ApplicationRecord
  has_many :likes_counters
  has_many :promotions

  def likes_today
    likes_counters.todays.map(&:amount).sum
  end
end
