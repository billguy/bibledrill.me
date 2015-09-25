class Study < ActiveRecord::Base

  acts_as_votable
  is_impressionable counter_cache: true, column_name: :cached_views_total
  include PgSearch
  pg_search_scope :search_by_keyword, against: [:title, :description]

  has_permalink(:title, true)

  belongs_to :user
  has_many :sections, dependent: :destroy

  accepts_nested_attributes_for :sections, allow_destroy: true

  validates_presence_of :title, :description

  scope :active, ->{ where(active: true) }
  scope :recent, ->{ active.order(created_at: :desc) }
  scope :popular, ->{ active.where("cached_votes_up > 0").order(cached_weighted_average: :desc) }
  scope :mine, ->(user_id){ where(user_id: user_id).order(created_at: :desc) }

  def to_param
    permalink
  end

end