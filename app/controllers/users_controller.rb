class UsersController < ApplicationController
  # before_action :ensure_correct_user, only: [:update]
  before_action :ensure_correct_user, only: [:update, :edit] #2022/2/16(debug)

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end #2022/2/15(debug)

  def edit
    @user = User.find(params[:id]) #2022/2/16(debug)
  end

  def update
    if @user.update(user_params)
      # redirect_to users_path(@user), notice: "You have updated user successfully."
      redirect_to user_path(@user), notice: "You have updated user successfully." #2022/2/16(debug)
    else
      # render "show"
      render "edit" #2022/2/16(debug)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
