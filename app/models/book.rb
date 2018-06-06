class Book < ActiveRecord::Base

  has_many :chapters
  scope :old_testament, ->{where("id < 40").order(id: :asc) }
  scope :new_testament, ->{where("id > 39").order(id: :asc) }

  serialize :abbreviations, Array

  def to_param
    permalink
  end

  def abbreviation(position=:first)
    abbreviations.send(:try, position)
  end

  def old?
    id <= 43
  end

  def new?
    id > 39
  end

  def first_chapter
    chapters.first
  end

  def first_chapter_number
    first_chapter.try(:number)
  end

end