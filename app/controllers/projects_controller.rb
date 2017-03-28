class ProjectsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_project, only: [:show, :edit, :update, :destroy]
	before_action :owned_post, only: [:edit, :update, :destroy]
	
	def index
		@projects = Project.all
	end

	def new
		@project = current_user.projects.build
	end

	def create
		@project = current_user.projects.build(project_params)
		current_user.projects << @project

		if @project.save
			flash[:notice] = "it worked!"
			redirect_to(project_path(@project))
		else
			render :new
			flash[:notice] = "something else happened"
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
		params.require(:project).permit(:image, :genre, :duration, :title, :synopsis, :director, :writer, :actor, :editor, :composer, :cinematographer, :makeup, :public)
	end

	def set_project
		@project = Project.find(params[:id])
	end

	def owned_post
		unless current_user.id == @project.users.ids.first
			redirect_to root_path
		end
	end
end
