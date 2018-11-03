class CreateAccount < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.integer :likes_count, default: 0
      t.boolean :automation_enabled
    end
  end
end
