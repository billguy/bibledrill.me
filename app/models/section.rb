class Section < ActiveRecord::Base

  default_scope { order(position: :asc) }

  belongs_to :study
  has_many :section_verses, dependent: :destroy
  has_many :verses, through: :section_verses

  accepts_nested_attributes_for :section_verses, allow_destroy: true

  def formatted_title
    title.present? ? title : "Section ##{section_position}"
  end

  def section_position
    study.sections.index{|s| s.id == id} + 1
  end

end