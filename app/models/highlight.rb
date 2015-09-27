class Highlight < ActiveRecord::Base
  belongs_to :user
  belongs_to :verse

  validates_presence_of :user, :verse

  validates_uniqueness_of :verse_id, scope: :user_id

  delegate :book_permalink, to: :verse
  delegate :book_name, to: :verse
  delegate :chapter_id, to: :verse
  delegate :chapter_number, to: :verse

end
