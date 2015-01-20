# == Schema Information
#
# Table name: clubs
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  adress      :string
#  price       :integer
#  author      :integer
#  phone       :integer
#  confermed   :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Club < ActiveRecord::Base
end
