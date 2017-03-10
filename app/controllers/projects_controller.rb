class ProjectsController < ApplicationController
	def index
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.create(project_params)
		redirect_to posts_path
	end

	private

	def post_params
		params.require(:project).permit(:image, :genre, :duration, :title, :synopsis, :director, :writer, :actor, :editor, :composer, :cinematographer, :makeup)
	end
end
