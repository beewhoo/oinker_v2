class UserController < ApplicationController

  def show
    load_user
    @date_plans = @user.date_plans
  end

  def destroy
    load_user
    @user.destroy
    redirect_to root
  end

  private

  def load_user
    @user = User.find_by(id: current_user.id)
  end


end
