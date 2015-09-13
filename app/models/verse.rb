class Verse < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_text, against: :text

  scope :search_by_text, ->(text){where("text like ?", "%#{text}%")} unless Rails.env.production? # since postgres only in production

  belongs_to :chapter

  delegate :book_permalink, to: :chapter
  delegate :book_name, to: :chapter
  delegate :chapter_id, to: :chapter
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

  def self.pages
    last.page
  end

  def self.random
    find(rand(1...count))
  end

  def prev
    id == 1 ? Verse.includes(chapter: :book).last : Verse.includes(chapter: :book).find_by_id(id-1)
  end

  def next
    id == self.class.count ? Verse.includes(chapter: :book).first : Verse.includes(chapter: :book).find_by_id(id+1)
  end

end