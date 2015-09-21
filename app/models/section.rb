class Section < ActiveRecord::Base

  acts_as_nested_set

  belongs_to :study
  has_many :section_verses
  has_many :verses, through: :section_verses

  accepts_nested_attributes_for :section_verses, allow_destroy: true

  def title_formatted
    title || "Section ##{lft}"
  end

end