class Web::Admin::JoinController < Web::Admin::ApplicationController
  def index
    @questionaries = Questionary.presented.decorate
  end

  def new
    @questionary = Questionary.new
    @questionary_form = QuestionaryForm.new @questionary
  end

  def edit
    @questionary = Questionary.find params[:id]
    @questionary_form = QuestionaryForm.new @questionary
  end

  def create
    @questionary = Questionary.new
    @questionary_form = QuestionaryForm.new @questionary
    @questionary_form.submit params[:questionary]
    if @questionary_form.save
      redirect_to admin_join_index_path
    else
      render action: :new
    end
  end

  def update
    @questionary = Questionary.find params[:id]
    @questionary_form = QuestionaryForm.new @questionary
    @questionary_form.submit params[:questionary]
    if @questionary_form.save
      @questionary_form.member.confirm if @questionary_form.confirmed?
      redirect_to admin_join_index_path
    else
      render action: :edit
    end
  end

  def destroy
    @questionary = Questionary.find params[:id]
    @questionary.remove
    redirect_to admin_join_index_path
  end
end
