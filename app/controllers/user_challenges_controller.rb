class UserChallengesController < ApplicationController
  def new
    @challenge = Challenge.find(params[:id])
    
    if current_user.projects.where(title: @challenge.title, challenge: true)
      redirect_to challenge_path(@challenge.id)
      flash[:danger] = "You have already entered this challenge"
    else
      @project = Project.new
      @project.image = @challenge.image
      @project.title = @challenge.title
      @project.synopsis = @challenge.synopsis
      @project.genre = @challenge.genre
      @project.duration = @challenge.duration
      @project.user_id = current_user.id
      @project.challenge = true
      @project.director = 0
      @project.writer = 0
      @project.actor = 0
      @project.cinematographer = 0
      @project.editor = 0
      @project.makeup = 0
      @project.composer = 0
      @project.vfx = 0
      @project.public = true
  		
      if current_user.pref_role.blank?
        @project.leader_role = "Director"
      else
        @project.leader_role = current_user.pref_role
      end
      @project.save
      current_user.projects << @project
    
      if @project.save
        @chat_room = ChatRoom.new
    		@chat_room.title = @project.title
    		current_user.chat_rooms << @chat_room
    		@chat_room.project_id = @project.id
    		@chat_room.save
        redirect_to edit_project_path(@project)
      else
        redirect_to challenges_path
        flash[:danger] = "Something went wrong..."
      end
    end
  end
end
