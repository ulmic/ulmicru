class Web::Users::JoinController < Web::Users::ApplicationController
  before_filter :current_user_can_send_questionary
  before_filter :find_charter_article, only: :new

  def new
    case params[:step]
    when '1'
      current_user.to_step_1
      @user = current_user
    when '2'
      current_user.to_step_2
      questionary = current_user.becomes! Questionary
      @questionary_form = QuestionaryForm.new questionary
    end
  end

  def create
    questionary = current_user.becomes! Questionary
    @questionary_form = QuestionaryForm.new questionary
    @questionary_form.submit params[:questionary]
    User.find(questionary.id).update type: 'Questionary'
    if @questionary_form.save
      current_user.finish
      Organization::Permissions.questionary[:review].each do |member|
        send_notification member, @questionary_form.model, :create
      end
      @questionary_form.model.request_date = Time.zone.now
      @questionary_form.model.save validate: false
      redirect_to account_path
    else
      # FIXME fix this shiiiiit!!!!
      ActiveRecord::Base.connection.execute "UPDATE users SET type = NULL WHERE id = #{questionary.id}"
      find_charter_article
      render action: :new
    end
  end

  private

  def current_user_can_send_questionary
    redirect_to account_path unless current_user.is_user?
  end

  def find_charter_article
    @charter = Article.find_by_title 'Устав'
  end
end
