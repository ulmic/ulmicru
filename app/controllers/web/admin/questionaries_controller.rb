class Web::Admin::QuestionariesController < Web::Admin::ApplicationController
  include Concerns::RegistrationWithLogs

  def index
    if params[:search]
      questionaries = Questionary.search_everywhere(params[:search])
    else
      questionaries = Questionary.send params[:scope]
    end
    @questionaries = questionaries.page(params[:page]).decorate
  end

  def show
    @questionary = Questionary.find(params[:id]).decorate
    get_registrations_with_logs @questionary.registrations
  end

  def new
    @questionary_form = QuestionaryForm.new_with_model
  end

  def edit
    @questionary_form = QuestionaryForm.find_with_model params[:id]
  end

  def create
    @questionary_form = QuestionaryForm.new_with_model
    @questionary_form.submit params[:questionary]
    if @questionary_form.save
      send_notification corporative_lead, @questionary_form.model, :create
      redirect_to admin_questionaries_path
    else
      render action: :new
    end
  end

  def update
    @questionary_form = QuestionaryForm.find_with_model params[:id]
    @questionary_form.submit params[:questionary]
    if @questionary_form.save
      if @questionary_form.model.member_confirmed?
        User.update params[:id], type: 'Member'
        #FIXME message in controller
        redirect_to edit_admin_member_path(params[:id], message: :fill_member_form)
      else
        redirect_to edit_admin_questionary_path @questionary_form.model
      end
    else
      render action: :edit
    end
  end

  def destroy
    @questionary = Questionary.find params[:id]
    @questionary.remove
    redirect_to admin_questionaries_path
  end
end
