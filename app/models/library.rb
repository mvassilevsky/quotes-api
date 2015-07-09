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

  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  has_many :quotes
  enum access_level: [:hidden, :shown]

  after_initialize :set_hidden

  def self.get_public_libraries
    Library.where("access_level = ?", Library.access_levels[:shown])
  end

  def display_access_level
    if hidden?
      "private"
    elsif shown?
      "public"
    end
  end

  def set_hidden
    self.access_level = :hidden
  end

end
