class DashboardController < ApplicationController
  before_action :title
  
  def index
    @myprojects = current_user.projects
    @projects = Project.all
  end
  
  private
  
  def title
    @title = "My Dashboard"
  end
end
