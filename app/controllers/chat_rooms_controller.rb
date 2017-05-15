class ChatRoomsController < ApplicationController
  before_action :title
  
  def index
    @projects = current_user.projects
    @chat_rooms = ChatRoom.where(project_id: @projects.ids)
    if @projects.count > 0
      redirect_to chat_show_path(@projects.first.id)
    end
  end
  
  def show
    @projects = current_user.projects
    @chat_rooms = ChatRoom.where(project_id: @projects.ids)
    @current_room = ChatRoom.find(params[:id])
    
    @projects.each do |project|
      if project.id == @current_room.project_id
        @yep = true
      end 
    end
    
    if @yep == true
      @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
      @message = Message.new
    else
      redirect_to root_path
      flash[:danger] = "You do not have access to this project chat"
    end
  end

  private

  def title
    @title = "Messages"
  end

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end