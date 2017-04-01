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
		@projectmade = UserProject.last
		@projectmade.user_role = @project.leader_role
		@projectmade.save
		
		@chat_room = ChatRoom.new
		@chat_room.title = @project.title
		current_user.chat_rooms << @chat_room
		@chat_room.project_id = @project.id
		@chat_room.save
		
		if @project.save && @chat_room.save
			flash[:success] = "Project successfully created"
			redirect_to(project_path(@project))
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

	private

	def project_params
		params.require(:project).permit(:image, :public, :genre, :duration, :title, :synopsis, :director, :writer, :actor, :editor, :composer, :cinematographer, :makeup, :vfx, :leader_role)
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
