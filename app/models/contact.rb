require 'valid_email/email_validator'

class Contact

  include ActiveModel::Model

  attr_accessor :name, :email, :message, :group_id

  validates :name, presence: true
  validates :email, presence: true, email: true
  validates :message, presence: true

end