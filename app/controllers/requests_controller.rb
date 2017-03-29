class RequestsController < ApplicationController
  
  def new
    @project = Project.find(params[:id])
    @request = Request.new()
  end
  
  def create
    @project = Project.find(params[:id])
    @request = Request.new(request_params)
    @request.sent = true
    @request.user_id = current_user.id
    @request.project_id = @project.id
    
    if @project.users.ids.include?(@request.user_id)
      redirect_to profile_path(current_user.user_name)
      flash[:danger] = "You can't request to join your own project"
    else
      if @request.save
        redirect_to project_path
        flash[:success] = "You have successfully sent an application to: " + @project.title
      else
        redirect_to project_path
        flash[:danger] = "Could not send an application"
      end
    end
  end
  
  def show
    @projects = Project.all
    @requests = Request.all
  end
  
  def destroy
    @request = Request.find(params[:request_id])
    @request.destroy
    redirect_to request_view_path
  end

  def update
    @project = Project.find(params[:project_id])
    @request = Request.find(params[:request_id])
    @userid = @request.user_id.to_i
    @user = User.find(@userid)
    if @project.users.ids.include?(@request.user_id)
      redirect_to root_path
    else
      @user.projects << @project
      @userprojects = UserProject.last
      @userprojects.user_role = @request.role
      @userprojects.save
      if @userprojects.user_role == "Actor"
        @project.actor -= 1
      elsif @userprojects.user_role == "Director"
        @project.director -= 1
      elsif @userprojects.user_role == "Editor"
        @project.editor -= 1
      elsif @userprojects.user_role == "Composer"
        @project.composer -= 1
      elsif @userprojects.user_role == "cinematographer"
        @project.cinematographer -= 1
      elsif @userprojects.user_role == "Writer"
        @project.writer -= 1
      elsif @userprojects.user_role == "VFX"
        @project.vfx -= 1
      end
      @project.save
      if(@project.director == 0 && @project.actor == 0 && @project.writer == 0 && @project.editor == 0 && @project.cinematographer == 0 && @project.composer == 0 && @project.makeup == 0 && @project.vfx == 0)
        @project.public = false
      end
      @project.save
      @request.destroy
      redirect_to request_view_path
      flash[:success] = @user.user_name + " has been added to " + @project.title
    end
  end
  
  private
  
  def request_params
    params.require(:request).permit(:bio, :role, :project_id, :user_id)
  end

end