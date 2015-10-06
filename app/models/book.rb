class Book < ActiveRecord::Base

  has_many :chapters
  scope :old_testament, ->{where("id < 40") }
  scope :new_testament, ->{where("id > 39") }

  serialize :abbreviations, Array

  def to_param
    permalink
  end

  def abbreviation(position=:first)
    abbreviations.send(:try, position)
  end

  def self.old_paths
    [{:name=>"Gen", :path=>"/books/genesis/chapters"}, {:name=>"Exo", :path=>"/books/exodus/chapters"}, {:name=>"Lev", :path=>"/books/leviticus/chapters"}, {:name=>"Num", :path=>"/books/numbers/chapters"}, {:name=>"Deut", :path=>"/books/deuteronomy/chapters"}, {:name=>"Josh", :path=>"/books/joshua/chapters"}, {:name=>"Judg", :path=>"/books/judges/chapters"}, {:name=>"Rth", :path=>"/books/ruth/chapters"}, {:name=>"1Sam", :path=>"/books/1-samuel/chapters"}, {:name=>"2Sam", :path=>"/books/2-samuel/chapters"}, {:name=>"1Kgs", :path=>"/books/1-kings/chapters"}, {:name=>"2Kgs", :path=>"/books/2-kings/chapters"}, {:name=>"1Chron", :path=>"/books/1-chronicles/chapters"}, {:name=>"2Chron", :path=>"/books/2-chronicles/chapters"}, {:name=>"Ezra", :path=>"/books/ezra/chapters"}, {:name=>"Neh", :path=>"/books/nehemiah/chapters"}, {:name=>"Esth", :path=>"/books/esther/chapters"}, {:name=>"Job", :path=>"/books/job/chapters"}, {:name=>"Pslm", :path=>"/books/psalms/chapters"}, {:name=>"Prov", :path=>"/books/proverbs/chapters"}, {:name=>"Eccles", :path=>"/books/ecclesiastes/chapters"}, {:name=>"Song", :path=>"/books/song-of-solomon/chapters"}, {:name=>"Isa", :path=>"/books/isaiah/chapters"}, {:name=>"Jer", :path=>"/books/jeremiah/chapters"}, {:name=>"Lam", :path=>"/books/lamentations/chapters"}, {:name=>"Ezek", :path=>"/books/ezekiel/chapters"}, {:name=>"Dan", :path=>"/books/daniel/chapters"}, {:name=>"Hos", :path=>"/books/hosea/chapters"}, {:name=>"Joel", :path=>"/books/joel/chapters"}, {:name=>"Amos", :path=>"/books/amos/chapters"}, {:name=>"Obad", :path=>"/books/obadiah/chapters"}, {:name=>"Jnh", :path=>"/books/jonah/chapters"}, {:name=>"Micah", :path=>"/books/micah/chapters"}, {:name=>"Nah", :path=>"/books/nahum/chapters"}, {:name=>"Hab", :path=>"/books/habakkuk/chapters"}, {:name=>"Zeph", :path=>"/books/zephaniah/chapters"}, {:name=>"Haggai", :path=>"/books/haggai/chapters"}, {:name=>"Zech", :path=>"/books/zechariah/chapters"}, {:name=>"Mal", :path=>"/books/malachi/chapters"}]
  end

  def self.new_paths
    [{:name=>"Matt", :path=>"/books/matthew/chapters"}, {:name=>"Mrk", :path=>"/books/mark/chapters"}, {:name=>"Luk", :path=>"/books/luke/chapters"}, {:name=>"John", :path=>"/books/john/chapters"}, {:name=>"Acts", :path=>"/books/acts/chapters"}, {:name=>"Rom", :path=>"/books/romans/chapters"}, {:name=>"1Cor", :path=>"/books/1-corinthians/chapters"}, {:name=>"2Cor", :path=>"/books/2-corinthians/chapters"}, {:name=>"Gal", :path=>"/books/galatians/chapters"}, {:name=>"Ephes", :path=>"/books/ephesians/chapters"}, {:name=>"Phil", :path=>"/books/philippians/chapters"}, {:name=>"Col", :path=>"/books/colossians/chapters"}, {:name=>"1Thess", :path=>"/books/1-thessalonians/chapters"}, {:name=>"2Thess", :path=>"/books/2-thessalonians/chapters"}, {:name=>"1Tim", :path=>"/books/1-timothy/chapters"}, {:name=>"2Tim", :path=>"/books/2-timothy/chapters"}, {:name=>"Titus", :path=>"/books/titus/chapters"}, {:name=>"Philem", :path=>"/books/philemon/chapters"}, {:name=>"Hebrews", :path=>"/books/hebrews/chapters"}, {:name=>"James", :path=>"/books/james/chapters"}, {:name=>"1Pet", :path=>"/books/1-peter/chapters"}, {:name=>"2Pet", :path=>"/books/2-peter/chapters"}, {:name=>"1John", :path=>"/books/1-john/chapters"}, {:name=>"2John", :path=>"/books/2-john/chapters"}, {:name=>"3John", :path=>"/books/3-john/chapters"}, {:name=>"Jude", :path=>"/books/jude/chapters"}, {:name=>"Rev", :path=>"/books/revelation/chapters"}]
  end

end