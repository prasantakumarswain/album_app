class Comment < ActiveRecord::Base
  belongs_to :image
  belongs_to :album, :counter_cache => true
  belongs_to :user
  validates :content, :presence => true
end
