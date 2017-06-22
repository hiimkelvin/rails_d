class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]
  before_action :require_correct_user, only: [:edit, :show, :update, :destroy]

  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def registration
    @user = User.new( user_params )
  	if @user.save
  		session[:user_id] = @user.id 
  		redirect_to '/sessions/new'
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to :back
  	end
  end

  def update
    @user = User.find(params[:id])
    if @user.update( curr_user_params ) 
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages     
      redirect_to "/users/#{@user.id}/edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      reset_session
      redirect_to "/users/new"
    else
      redirect_to "/users/#{@user.id}/edit"
    end
  end  

  private
    def curr_user_params
  	  params.require(:users).permit(:name, :email)
    end

    def user_params
  	  params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def require_correct_user
      if current_user != User.find(params[:id])
        redirect_to "/users/#{session[:user_id]}"
      end
    end
end
