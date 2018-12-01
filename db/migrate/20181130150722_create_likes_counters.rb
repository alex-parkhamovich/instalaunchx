class CreateLikesCounters < ActiveRecord::Migration[5.2]
  def change
    create_table :likes_counters do |t|
      t.integer :account_id
      t.integer :amount, default: 0

      t.timestamps
    end
  end
end
