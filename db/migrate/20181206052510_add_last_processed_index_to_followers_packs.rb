class AddLastProcessedIndexToFollowersPacks < ActiveRecord::Migration[5.2]
  def change
    add_column :followers_packs, :last_processed_index, :integer, default: 0
  end
end
