class FollowersPack < ApplicationRecord
  belongs_to :promotion

  def status
    "#{last_processed_index}/#{followers.count} profiles processed"
  end
end
