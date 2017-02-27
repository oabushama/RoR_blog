class Article < ActiveRecord::Base
  has_many :article_categories
  has_many :categories, through: :article_categories
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }  # this will only allow data to hit table if a title is present and the lenth is within range
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
end
