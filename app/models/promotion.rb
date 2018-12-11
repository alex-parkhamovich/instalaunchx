class Promotion < ApplicationRecord
  belongs_to :account

  has_many :followers_packs

  def last_processed_profiles_status
    return '-' unless followers_packs.last
    "#{followers_packs.last.last_processed_index}/" \
    "#{followers_packs.last.followers&.count} profiles processed from last fetched followers pack"
  end

  def overall_processed_profiles_status
    return '-' unless followers_packs.map(&:followers).any?
    "#{followers_packs.map(&:last_processed_index).sum}/" \
    "#{followers_packs.map(&:followers).sum.count} profiles processed overall"
  end
end
