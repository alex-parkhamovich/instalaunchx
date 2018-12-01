class CreateAccount < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.boolean :automation_enabled
      t.string :current_worker_id

      t.timestamps
    end
  end
end
