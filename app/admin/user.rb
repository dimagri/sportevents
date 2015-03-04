ActiveAdmin.register User do

  config.filters = false

  # permit_params Club.column_names

  index do
    id_column
    column :name do |user|
      link_to user.name, user_path(user)
    end
    column :provider
    column :email
    column :admin
    column :email_confirmed
    actions defaults: true
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
