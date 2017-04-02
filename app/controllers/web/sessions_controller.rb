class Web::SessionsController < Web::ApplicationController
  before_filter :redirect_if_signed_in, except: :destroy

  def new
    @user = UserForm.new_with_model
  end

  def create
    @user = User.find_by_email params[:user][:email]
    if @user
      if @user.authenticate(params[:user][:password]) 
	if @user.has_access?
	  sign_in @user
	  log_action :sign_in
	  redirect_to params[:url] || account_path
	else
	  @user.errors.add :email, I18n.t('notifications.web.sessions.create.your_account_is_not_active')
	  render :new
	end
      else
        @user = @user.becomes! User
        render :new
      end
    else
      @user = UserForm.new_with_model
      render :new
    end
  end

  def destroy
    sign_out
    log_action :sign_out
    redirect_to params[:url] || root_path
  end

  private

  def redirect_if_signed_in
    if signed_in?
      if current_user.is_ya_lider_participant?
        token = Token.where(record_type: 'ActivityLines::Lider::YaLider::Participant', record_id: current_user.current_ya_lider_participant.id).first
        if params[:url].include?('activity_lines/lider/ya_liders') && token.present?
          redirect_to "#{params[:url]}?token=#{token.content}"
        else
          redirect_to account_path
        end
      else
        redirect_to account_path
      end
    end
  end
end
