class ProjectsController < ApplicationController
	before_action :set_project, only: [:show, :edit, :update, :destory]

	def index
		@projects = Project.all
	end

	def new
		@project = Project.new
	end

	def create
		if @project = Project.create(project_params)
			redirect_to projects_path
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @project.update(project_params)
			redirect_to(project_path(@project))
		else
			render :edit
		end
	end

	def destroy
		@project.destroy
		redirect_to root_path
	end

	private

	def project_params
		params.require(:project).permit(:image, :genre, :duration, :title, :synopsis, :director, :writer, :actor, :editor, :composer, :cinematographer, :makeup)
	end

	def set_project
		@project = Project.find(params[:id])
	end
end
