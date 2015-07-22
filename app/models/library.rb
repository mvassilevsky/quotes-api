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
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  validates :name, uniqueness: { scope: :owner_id }, presence: true
  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  has_many :quotes
  enum access_level: [:hidden, :shown]

  MAX_DESCRIPTION_LENGTH = 40

  def self.get_public_libraries
    Library.where("access_level = ?", Library.access_levels[:shown])
  end

  def slug_candidates
    [
      :name,
      [:name, :owner_id]
    ]
  end

  def display_access_level
    if hidden?
      "private"
    elsif shown?
      "public"
    end
  end

end
