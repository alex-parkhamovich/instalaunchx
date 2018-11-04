class AddCurrentWorkerIdToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :current_worker_id, :string
  end
end
