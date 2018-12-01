class CreateFollowersPack < ActiveRecord::Migration[5.2]
  def change
    create_table :followers_packs do |t|
      t.integer :promotion_id
      t.string :followers, array: true, default: []

      t.timestamps
    end
  end
end
