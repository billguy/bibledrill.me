class Book < ActiveRecord::Base

  has_many :chapters
  scope :old_testament, ->{where("id < 40") }
  scope :new_testament, ->{where("id > 39") }

  def to_param
    permalink
  end

end