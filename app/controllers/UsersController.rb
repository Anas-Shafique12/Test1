# In app/controllers/users_controller.rb
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      # Enqueue the background job
      SendWelcomeEmailJob.perform_later(@user.id)
      redirect_to @user, notice: "User was successfully created."
    else
      render :new
    end
  end

  def index
    # Fetch all users, including their associated posts
    users = User.includes(:posts).all

    render json: users.as_json(include: :posts)
  end
  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
