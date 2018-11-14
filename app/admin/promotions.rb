ActiveAdmin.register Promotion do
  permit_params :account_id, :profile_names, :tag_names

  index do
    selectable_column
    id_column
    column :account
    column :profile_names
    column :tag_names
    column :status
    column :likes_count
    column :worker_uuid
    actions
  end

  filter :account
  filter :status
  filter :likes_count

  form do |f|
    f.inputs do
      f.input :account
      f.input :profile_names
      f.input :tag_names
    end
    f.actions
  end
end
