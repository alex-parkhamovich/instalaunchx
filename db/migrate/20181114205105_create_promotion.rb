class CreatePromotion < ActiveRecord::Migration[5.2]
  def change
    create_table :promotions do |t|
      t.integer :account_id

      t.string :profile_names
      t.string :status
      t.string :tag_names
      t.string :worker_uuid

      t.timestamps
    end
  end
end
