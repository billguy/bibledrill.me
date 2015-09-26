class SectionVerse < ActiveRecord::Base

  default_scope { order(position: :asc) }

  belongs_to :section
  belongs_to :verse

  def verse_title
    verse.try(:title)
  end

  def verse_text
    verse.try(:text)
  end

end