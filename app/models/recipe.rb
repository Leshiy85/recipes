class Recipe < ActiveRecord::Base
	validates :user_id, presence: true
	validates :title, presence: true, length: { minimum: 5, maximum: 19 }
	validates :summary, presence: true, length: { minimum: 11, maximum: 38 }
	validates :description, presence: true, length: { minimum: 6, maximum: 100}
	belongs_to :user
end
