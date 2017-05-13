class ChallengesController < ApplicationController
  before_action :admin_rights, only: [:new, :create, :edit, :update, :destroy]
  before_action :title
  
  def index
	@challenges = Challenge.all.order('created_at DESC')
  end
	
	def new
	  @challenge = Challenge.new
	end
	
	def create
	  @challenge = Challenge.new(challenge_params)
	  @challenge.save
	  
	  if @challenge.save
	  	redirect_to challenges_path
	  	flash[:success] = "Challenge successfully created"
	  else
	  	flash[:danger] = "unable to save"
	  end
	end
	
	def edit
	  @challenge = Challenge.find(params[:id])
	end
	
	def update
	  @challenge = Challenge.find(params[:id])
	  if @challenge.update(challenge_params)
	    redirect_to challenges_path
	    flash[:success] = "Challenge succesfully updated"
	  else
	    render :edit
	    flash[:danger] = "couldnt update"
	  end
	end
	
	def show
	  @challenge = Challenge.find(params[:id])
	end
	
	def destroy
	  @challenge = Challenge.find(params[:id])
	  @challenge.destroy
	  redirect_to :challenges_path
	end
	
	private
	
		def title
			@title = "Challenges"
		end
	
	  def challenge_params
	    # params.require(:challenge).permit(:header_url, :genre, :duration, :title, :synopsis, :reward, :featured, :requirements)
	    params.require(:challenge).permit(:header_url, :genre, :duration, :title, :synopsis)
	  end
	  
	  def admin_rights
	    unless(current_user.admin == true)
	      redirect_to challenges_path
	    end
	  end
end
