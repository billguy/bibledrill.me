class Verse < ActiveRecord::Base

  belongs_to :chapter
  has_many :highlights

  has_many :section_verses
  has_many :sections, through: :section_verses
  has_many :studies, through: :sections

  has_many :verse_cross_references, foreign_key: :verse_id
  has_many :verses, through: :verse_cross_references, source: :cross_reference_verse

  delegate :book_permalink, to: :chapter
  delegate :book_name, to: :chapter
  delegate :book_id, to: :chapter
  delegate :chapter_id, to: :chapter
  delegate :chapter_number, to: :chapter

  scope :old_testament, ->{ includes(:chapter).where(chapters: { book_id: 1..39 } ) }
  scope :new_testament, ->{ includes(:chapter).where(chapters: { book_id: 40..66 } ) }

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

  def self.pages
    last.page
  end

  def self.random
    find(rand(1...count))
  end

end