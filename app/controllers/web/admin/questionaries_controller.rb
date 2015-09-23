class Web::Admin::QuestionariesController < Web::Admin::ApplicationController
  def index
    @questionaries = {}
    @questionaries[:on_the_trial] = Kaminari.paginate_array(Questionary.on_the_trial.decorate).page params[:page]
    @questionaries[:unviewed] = Kaminari.paginate_array(Questionary.unviewed.decorate).page params[:page]
    @questionaries[:declined] = Kaminari.paginate_array(Questionary.declined.decorate).page params[:page]
    @questionaries[:search] = Kaminari.paginate_array(Questionary.search_everywhere(params[:search]).decorate).page(params[:page]) if params[:search]
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
      if @questionary_form.model.member_state == 'confirmed'
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
