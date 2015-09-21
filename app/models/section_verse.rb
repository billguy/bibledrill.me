class SectionVerse < ActiveRecord::Base

  belongs_to :section
  belongs_to :verse

  def verse_title
    verse.try(:title)
  end

  def verse_text
    verse.try(:text)
  end

end