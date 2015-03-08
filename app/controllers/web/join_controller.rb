class Web::JoinController < Web::ApplicationController
  before_filter :authenticate_user!, only: [ :new, :create ]

  def new
    @questionary = Questionary.new
    @questionary_form = QuestionaryForm.new @questionary
  end

  def create
    @questionary = Questionary.new
    @questionary_form = QuestionaryForm.new @questionary
    @questionary_form.submit params[:questionary]
    if @questionary_form.save
      redirect_to account_path
    else
      render action: :new
    end
  end
end
