class Web::SessionsController < Web::ApplicationController
  # FIXME forbid access if the user is signed in
  def new
    @user = User.new
    @session = UserForm.new @user
  end

  def create
    @user = User.find_by_email params[:user][:email]
    @session = UserSignInForm.new @user
    if @session
      if @session.password == params[:user][:password]
        sign_in @session.model
        redirect_to admin_root_path
      else
        render :new
      end
    else
      render :new
    end
  end

  def destroy
    sign_out
    root_path
  end
end
