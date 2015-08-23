class Book < ActiveRecord::Base
  include Readable

  has_many :chapters
  scope :old_testament, ->{where("id < 40") }
  scope :new_testament, ->{where("id > 39") }

  def to_param
    permalink
  end

  def self.count
    66
  end
end