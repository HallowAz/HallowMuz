class SingersController < ApplicationController
  before_action :new

  def profile
    
  end
  
  private
  def new
    @singer = Singer.find_by_name(params[:name])
  end
end
