class Chapter < ActiveRecord::Base

  belongs_to :book
  has_many :verses
  serialize :abbreviations

  delegate :name, to: :book, prefix: :book
  delegate :permalink, to: :book, prefix: :book

  alias_attribute :chapter_id, :id
  alias_attribute :chapter_number, :number

  def title
    "#{book_name} #{number}"
  end

  def to_param
    number
  end

  def self.count
    1189
  end

  def prev
    id == 1 ? Chapter.includes(:book).last : Chapter.includes(:book).find_by_id(id-1)
  end

  def next
    id == self.class.count ? Chapter.includes(:book).first : Chapter.includes(:book).find_by_id(id+1)
  end

end