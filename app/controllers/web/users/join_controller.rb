class Web::Users::JoinController < Web::Users::ApplicationController
  def new
    @questionary = Questionary.new
    @questionary_form = QuestionaryForm.new @questionary
  end

  def create
    @questionary_form = QuestionaryForm.new_with_model
    @questionary_form.submit params[:questionary]
    if @questionary_form.save
      redirect_to account_path
    else
      render action: :new
    end
  end
end
