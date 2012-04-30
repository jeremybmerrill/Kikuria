class UsersController < ApplicationController
  # GET /wishes/1
  # GET /wishes/1.json

  load_and_authorize_resource #cancan

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

end
