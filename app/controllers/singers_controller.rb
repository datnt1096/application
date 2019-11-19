class SingersController < ApplicationController
  def show
    @singer = Singer.find_by id: params[:id]
    redirect_to root_url unless @singer
  end
end
