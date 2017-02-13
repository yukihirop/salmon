class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :email_for_index,
             :password_digest

end