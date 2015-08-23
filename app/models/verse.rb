class Verse < ActiveRecord::Base
  include Readable

  belongs_to :chapter

  delegate :book_permalink, to: :chapter
  delegate :book_name, to: :chapter
  delegate :chapter_number, to: :chapter

  def title
    "#{book_name} #{chapter_number}:#{number}"
  end

  def to_param
    number
  end

  def self.count
    31102
  end
end