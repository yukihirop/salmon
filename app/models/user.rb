class User < ApplicationRecord
  has_many :todos
  validates :name, presence:true
  validates :email, presence:true, email: {allow_blank:true}
  before_validation do
    self.email_for_index = email.downcase if email
  end

  has_secure_password

end
