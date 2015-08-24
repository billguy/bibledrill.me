class Verse < ActiveRecord::Base

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

  def prev
    id == 1 ? Verse.includes(chapter: :book).last : Verse.includes(chapter: :book).find_by_id(id-1)
  end

  def next
    id == self.class.count ? Verse.includes(chapter: :book).first : Verse.includes(chapter: :book).find_by_id(id+1)
  end

end