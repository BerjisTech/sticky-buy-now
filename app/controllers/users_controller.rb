class UsersController < AdminapplicationController
  before_action :logged_in_user, only: [:show]
  def show
    @user = User.find(params[:id])
  end
  
  private
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to ologin_path
      end
    end
    
end