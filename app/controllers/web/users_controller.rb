class Web::UsersController < Web::ApplicationController
  def new
    @user = User.new
    @user_form = UserForm.new(@user)
  end

  def create
    @user = User.new
    @user_form = UserForm.new(@user)
    @user_form.submit(params[:user])
    if @user_form.save
      sign_in @user
      redirect_to new_member_path
    else
      render action: :new
    end
  end
end
