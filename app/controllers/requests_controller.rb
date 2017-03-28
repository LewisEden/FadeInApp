class RequestsController < ApplicationController
  
  def new
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
    else
      if @request.save
        redirect_to root_path
      else
        redirect_to project_path
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
    redirect_to root_path
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
      @request.destroy
      redirect_to request_view_path
    end
  end
  
  private
  
  def request_params
    params.require(:request).permit(:bio, :role, :project_id, :user_id)
  end

end