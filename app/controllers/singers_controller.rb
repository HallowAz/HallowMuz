class SingersController < ApplicationController
  before_action :new_singer

  def profile
    
  end
  
  private
  def new_singer
    @singer = Singer.find_by_name(params[:name])
  end
end
