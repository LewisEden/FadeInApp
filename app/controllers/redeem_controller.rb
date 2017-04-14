class RedeemController < ApplicationController
  before_action :title
  
  def index
  end
  
  def show
    
  end
  
  private
  
  def title
    @title = "Redeem"
  end
end
