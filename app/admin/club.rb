ActiveAdmin.register Club do

  config.filters = false

  scope :all
  scope :confirmed, default: true
  scope :unconfirmed

  permit_params Club.column_names

  index do
    id_column
    column :name
    column "Type" do |club|
      club.type.name
    end
    column :author do |club|
      link_to club.author.name, user_path(club.author)
    end
    column :confirmed
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
