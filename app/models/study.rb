class Study < ActiveRecord::Base

  has_permalink(:title, true)

  belongs_to :user
  has_many :sections

  accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :title, :description

  scope :active, ->{ where(active: true) }

  def to_param
    permalink
  end

end