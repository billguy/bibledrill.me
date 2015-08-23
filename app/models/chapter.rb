class Chapter < ActiveRecord::Base
  include Readable
  belongs_to :book
  has_many :verses
  serialize :abbreviations

  delegate :name, to: :book, prefix: :book
  delegate :permalink, to: :book, prefix: :book

  alias_attribute :chapter_number, :number

  def title
    "#{book_name} #{number}"
  end

  def to_param
    number
  end

  def self.count
    1189
  end
end