class Web::Users::JoinController < Web::Users::ApplicationController
  def new
    questionary = current_user.becomes! Questionary
    @questionary_form = QuestionaryForm.new questionary
  end

  def create
    exists_questionary = Questionary.find_by_ticket params[:questionary][:ticket]
    questionary = exists_questionary
    if exists_questionary
      if exists_questionary.unavailable?
        current_user.authentications.each do |auth|
          auth.user_id = exists_questionary.id
          auth.save
        end
        current_user.destroy
        sign_in exists_questionary
      end
    else
      questionary = current_user.becomes! Questionary
      User.find(questionary.id).update type: 'Questionary'
    end
    @questionary_form = QuestionaryForm.new questionary
    @questionary_form.submit params[:questionary]
    if @questionary_form.save
      redirect_to account_path
    else
      render action: :new
    end
  end
end
