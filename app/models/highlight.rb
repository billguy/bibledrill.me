class Highlight < ActiveRecord::Base
  belongs_to :user
  belongs_to :verse

  validates_presence_of :user, :verse

  validates_uniqueness_of :verse, scope: :user
end
