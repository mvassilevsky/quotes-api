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

class Quote < ActiveRecord::Base
  validates(
    :text,
    :author,
    :char_length,
    :category,
    presence: true
  )

  belongs_to :library

  MAX_QUOTE_LENGTH = 200
  MAX_AUTHOR_LENGTH = 24
  MAX_SOURCE_LENGTH = 24

  before_validation :set_char_length

  def full_quote
    if text.blank? && author.blank?
      ""
    elsif author.blank?
      text
    else
      text + " -- " + author
    end
  end

  def set_char_length
    self.char_length = full_quote.length
  end

end
