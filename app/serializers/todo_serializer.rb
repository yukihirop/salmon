class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :done, :user_id
end
