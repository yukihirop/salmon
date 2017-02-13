class Todo < ApplicationRecord
  belongs_to :user
  validates :title, presence:true
  validates :content, presence:true
  # boolean型だけ特殊
  validates :done, inclusion: [true, false]
end
