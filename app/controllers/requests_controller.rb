class RequestsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @project = Project.find(params[:id])
    #checks if user has already made a request for the project they are viewing
    #sets @requests to equal all requests where user_id is the same as the current user id viewing
    @requests = Request.where(user_id: current_user.id)
    @requests.each do |r|
      #if a request project id is the same as the current project they're viewing's id
      if r.project_id == @project.id
        #link them back to the project
        redirect_to project_path
      end
    end
    @request = Request.new()
  end
  
  def create
    @project = Project.find(params[:id])
    @request = Request.new(request_params)
    @request.sent = true
    @request.user_id = current_user.id
    @request.project_id = @project.id
    
    if @project.users.ids.include?(@request.user_id)
      redirect_to project_path
      flash[:danger] = "You can't request to join your own project"
    else
      if @request.save
        redirect_to project_path
        flash[:success] = "You have successfully sent an application to: " + @project.title
      else
        flash[:danger] = "Could not send application: make sure all forms are filled."
        render :new
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
        #if all roles have been filled then it will destroy all same role requests
        if @project.actor <= 0
          @req = Request.where(role: "Actor", project_id: @project.id)
          @req.each do |r|
            r.destroy
          end
        end
      elsif @userprojects.user_role == "Director"
        @project.director -= 1
        if @project.actor <= 0
          @req = Request.where(role: "Actor", project_id: @project.id)
          @req.each do |r|
            r.destroy
          end
        end
      elsif @userprojects.user_role == "Editor"
        @project.editor -= 1
        if @project.editor <= 0
          @req = Request.where(role: "Editor", project_id: @project.id)
          @req.each do |r|
            r.destroy
          end
        end
      elsif @userprojects.user_role == "Composer"
        @project.composer -= 1
        if @project.composer <= 0
          @req = Request.where(role: "Composer", project_id: @project.id)
          @req.each do |r|
            r.destroy
          end
        end
      elsif @userprojects.user_role == "Cinematographer"
        @project.cinematographer -= 1
        if @project.cinematographer <= 0
          @req = Request.where(role: "Cinematographer", project_id: @project.id)
          @req.each do |r|
            r.destroy
          end
        end
      elsif @userprojects.user_role == "Writer"
        @project.writer -= 1
        if @project.writer <= 0
          @req = Request.where(role: "Writer", project_id: @project.id)
          @req.each do |r|
            r.destroy
          end
        end
      elsif @userprojects.user_role == "Makeup"
        @project.makeup -= 1
        if @project.makeup <= 0
          @req = Request.where(role: "Makeup", project_id: @project.id)
          @req.each do |r|
            r.destroy
          end
        end
      elsif @userprojects.user_role == "VFX"
        @project.vfx -= 1
        if @project.vfx <= 0
          @req = Request.where(role: "VFX", project_id: @project.id)
          @req.each do |r|
            r.destroy
          end
        end
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