ActiveAdmin.register Account do
  permit_params :automation_enabled

  index do
    selectable_column
    id_column
    column :automation_enabled
    column :current_worker_id
    column :created_at
    column :updated_at
    actions
  end
end
