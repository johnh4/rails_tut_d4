class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.all.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "You have signed up!"
      sign_in @user
  		redirect_to @user
  	else
  		flash.now[:error] = "There was an error during signup. Please try again."
  		render 'new'
  	end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Update successful!"
      redirect_to @user
    else
      flash.now[:error] = "Update unsuccessful. Please Try again."
      render 'edit'
    end
  end

  def destroy

  end


  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    #before actions
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
























