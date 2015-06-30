# == Schema Information
#
# Table name: libraries
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  description  :text
#  owner_id     :integer          not null
#  access_level :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Library < ActiveRecord::Base

  belongs_to :user, class_name: "User", foreign_key: :user_id
  has_many :quotes

  enum access_level: [:private, :public]

end
