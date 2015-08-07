class Recipe < ActiveRecord::Base
	belongs_to :user
	has_many :likes
	validates :user_id, presence: true
	validates :title, presence: true, length: { minimum: 5, maximum: 19 }
	validates :summary, presence: true, length: { minimum: 11, maximum: 38 }
	validates :description, presence: true, length: { minimum: 6, maximum: 100}
	mount_uploader :picture, PictureUploader
	validate :picture_size

	def thumbs_up_total
		self.likes.where(like: true).size
	end

	def thumbs_down_total
		self.likes.where(like: false).size
	end

	private
		def picture_size
			if picture.size > 5.megabytes
				errors.add(:picture, "should be less than 5MB")
			end
		end

end
