class Post < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates :title, presence: true,
  			length: {minimum: 6}, 
  			uniqueness: { case_sensitive: false } 
  validates :content, presence: true, 
  			length: {minimum: 6}
end
