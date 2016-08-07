class Article < ActiveRecord::Base
  belongs_to :user # singular because is the "many side" of association
  validates :title, presence:true, length: { minimum: 3, maximum: 50 }
  validates :description, presence:true, length: { minimum: 10, maximum: 100 }
  validates :user_id, presence: true
end