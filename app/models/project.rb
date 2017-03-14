class Project < ApplicationRecord
	belongs_to :user

	validates :user_id, presence: true
	validates :image, presence: true
	validates :genre, presence: true
	validates :duration, presence: true
	validates :title, presence: true
	validates :synopsis, presence: true
	validates :director, presence: true
	validates :writer, presence: true
	validates :actor, presence: true
	validates :editor, presence: true
	validates :composer, presence: true
	validates :cinematographer, presence: true
	validates :makeup, presence: true

	has_attached_file :image, styles: { :medium => "640x"}
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
