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

require 'test_helper'

class LibraryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
