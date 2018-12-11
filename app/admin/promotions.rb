ActiveAdmin.register Promotion do
  permit_params :account_id, :profile_names, :tag_names

  index do
    selectable_column
    id_column
    column :account
    column :profile_names

    column :last_processed_profiles_status do |resource|
      resource.last_processed_profiles_status
    end
    column :overall_processed_profiles_status do |resource|
      resource.overall_processed_profiles_status
    end

    column :status
    column :worker_uuid

    actions do |resource|
      item 'Fetch',
        followers_packs_path(promotion_id: resource.id),
        method: :post,
        class: 'member_link',
        data: {
          confirm: 'Are you sure you want to fetch new followers pack?'
        }
      item 'Run',
        promotions_path(promotion_id: resource.id),
        method: :post,
        class: 'member_link',
        data: {
          confirm: 'Are you sure you want to run promotion (autolike process will be started)?'
        }
    end
  end

  show do
    attributes_table do
      row :account
      row :profile_names

      row :last_processed_profiles_status do |resource|
        resource.last_processed_profiles_status
      end

      row :overall_processed_profiles_status do |resource|
        resource.overall_processed_profiles_status
      end

      row :status
      row :worker_uuid
    end
  end

  form do |f|
    f.inputs do
      f.input :account
      f.input :profile_names
      f.input :tag_names
    end
    f.actions
  end
end
