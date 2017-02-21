class User < ApplicationRecord
  has_many :todos
  validates :name, presence:true
  validates :email, presence:true, email: {allow_blank:true}
  before_validation do
    self.email = email.downcase if email
  end

  has_secure_password

  # userを探すのはdefaultでは以下の用になっている
  # def self.from_token_request request
  #   # Returns a valid user, `nil` or raise `Knock.not_found_exception_class_name`
  #   # e.g.
  #   #   email = request.params["auth"] && request.params["auth"]["email"]
  #   #   もしたら
  #   #   email = auth_params["email"]
  #   #   self.find_by email: email
  # end

end
