class Web::Users::AccountController < Web::Users::ApplicationController
  def index
    @user = User.find current_user.id
    @member = @user.member
    @authentications = current_user.authentications
  end

  def update
    if params[:user]
      @user = User.find params[:id]
      @user_form = UserForm.new @user
      @user_form.submit params[:user]
      if @user_form.save
        redirect_to account_path
      else
        redirect_to account_path
      end
    end
  end
end
