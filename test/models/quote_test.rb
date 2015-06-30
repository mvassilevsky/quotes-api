# == Schema Information
#
# Table name: quotes
#
#  id          :integer          not null, primary key
#  text        :text             not null
#  author      :string(255)      not null
#  source      :string(255)
#  char_length :integer          not null
#  category    :string(255)      not null
#  created_at  :datetime
#  updated_at  :datetime
#  library_id  :integer
#

require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
