class Web::Admin::QuestionariesController < Web::Admin::ApplicationController
  def index
    @questionaries = {}
    @questionaries[:on_the_trial] = Questionary.on_the_trial.order(:id).page(params[:page]).decorate
    @questionaries[:unviewed] = Questionary.unviewed.page(params[:page]).decorate
    @questionaries[:declined] = Questionary.declined.page(params[:page]).decorate
    @questionaries[:search] = Questionary.presented.search_everywhere(params[:search]).page(params[:page]).decorate if params[:search]
  end

  def show
    @questionary = Questionary.find(params[:id]).decorate
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
