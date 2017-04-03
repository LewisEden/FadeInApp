class Challenge < ApplicationRecord
  
  validates :image, presence: true
	validates :genre, presence: true
	validates :duration, presence: true
	validates :title, presence: true
	validates :synopsis, presence: true
	validates :reward, presence: true
	validates :requirements, presence: true

	has_attached_file :image, styles: { :medium => "640x427#" }
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	
end
