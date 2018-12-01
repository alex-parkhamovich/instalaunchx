class LikesCounter < ApplicationRecord
  belongs_to :account

  scope :todays, -> do
    where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end
end
