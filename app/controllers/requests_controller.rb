class RequestsController < ApplicationController
  def create
    @project = Project.find(params[:id])
    
    if @project.users.ids.include?(current_user.id)
      redirect_to root_path
    else
      current_user.projects << @project
      redirect_to project_path
    end
  end
end