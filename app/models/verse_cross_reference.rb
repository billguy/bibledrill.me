class VerseCrossReference < ActiveRecord::Base
  belongs_to :verse, class_name: "Verse"
  belongs_to :cross_reference_verse, class_name: "Verse"
end
