class Promotion < ApplicationRecord
  belongs_to :account

  has_one :followers_pack
end
