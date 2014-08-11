class Album < ActiveRecord::Base
  has_many :images
  belongs_to :user
  has_many  :comments
  validates :name, :presence => true#,{:message => 'name should present'}
end
