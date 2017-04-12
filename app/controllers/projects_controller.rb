class ProjectsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_project, only: [:show, :edit, :update, :destroy]
	before_action :owned_post, only: [:edit, :update, :destroy]
	before_action :title
	
	def index
		@projects = Project.all.order('created_at DESC')
	end

	def new
		@project = current_user.projects.build
	end

	def create
		@project = current_user.projects.build(project_params)
		current_user.projects << @project
		@projectmade = UserProject.last
		@projectmade.user_role = @project.leader_role
		@projectmade.save
		
		@chat_room = ChatRoom.new
		@chat_room.title = @project.title
		current_user.chat_rooms << @chat_room
		@chat_room.project_id = @project.id
		@chat_room.save
		
		if @project.save && @chat_room.save
			flash[:success] = "Project successfully created, please specify what requirements are needed."
			redirect_to(edit_project_path(@project))
		else
			render :new
			flash[:notice] = "Something went wrong"
		end
	end

	def show
	end

	def edit
	end

	def update
		if @project.update(project_params)
			@projectmade = UserProject.where(project_id: @project.id, user_id: current_user.id)
			@theproject = @projectmade.first
			@theproject.user_role = @project.leader_role
			@theproject.save
			if @project.director <= 0 && @project.writer <= 0 && @project.editor <= 0 && @project.actor <= 0 && @project.cinematographer <= 0 && @project.makeup <= 0 && @project.vfx <= 0 && @project.composer <= 0
				@project.public = false
				@project.save
			end
			redirect_to(project_path(@project))
			flash[:success] = "Project succesfully updated"
		else
			render :edit
		end
	end

	def destroy
		@requests = Request.where(project_id: @project.id)
		@chat_rooms = ChatRoom.where(project_id: @project.id)
		@chat_rooms.each do |c|
			c.destroy
		end
		@requests.each do |r|
			r.destroy
		end
		@project.destroy
		redirect_to root_path
		flash[:success] = "Project successfully deleted"
	end
	
	def removeuser
		@project = Project.find(params[:project_id])
		@user = User.find(params[:user_id])
		unless @project.users.first.id == current_user.id
			redirect_to project_path(@project)
			flash[:danger] = "You must be the project leader to remove members"
		end
		if @project.users.destroy(@user)
			redirect_to project_path(@project)
			flash[:success] = "Successfully removed #{@user.user_name}"
		else
			redirect_to project_path(@project)
			flash[:danger] = "Something went wrong..."
		end
	end
	
	private

	def title
		@title = "Projects"
	end

	def project_params
		params.require(:project).permit(:image, :public, :genre, :duration, :title, :synopsis, :director, :writer, :actor, :editor, :composer, :cinematographer, :makeup, :vfx, :leader_role, :r_director, :r_writer, :r_actor, :r_editor, :r_cinematographer, :r_composer, :r_makeup, :r_vfx)
	end

	def set_project
		@project = Project.find(params[:id])
	end

	def owned_post
		unless(current_user.id == @project.users.ids.first || current_user.admin == true)
			redirect_to root_path
		end
	end
end
