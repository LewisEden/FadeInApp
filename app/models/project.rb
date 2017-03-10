class Project < ApplicationRecord
	validates :image, presence: true

	has_attached_file :image, styles: { :medium => "640x"}
	validates_attchment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
