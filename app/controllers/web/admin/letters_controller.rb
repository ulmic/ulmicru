class Web::Admin::LettersController < Web::Admin::ApplicationController
  before_filter :choose_members, only: [ :new, :edit ]
  before_filter :last_letter, only: [ :new, :edit ]

  def index
    if params[:search]
      letters = Letter.presented.search_everywhere params[:search]
    else
      letters = Letter.send params[:scope]
    end
    @letters = letters.page(params[:page]).decorate
  end

  def new
    @letter_form = LetterForm.new_with_model
  end

  def edit
    @letter_form = LetterForm.find_with_model params[:id]
  end

  def create
    @letter_form = LetterForm.new_with_model
    @letter_form.submit(params[:letter])
    if @letter_form.save
      redirect_to admin_letters_path
    else
      choose_members
      last_letter
      render action: :new
    end
  end

  def update
    @letter_form = LetterForm.find_with_model params[:id]
    @letter_form.submit params[:letter]
    if @letter_form.save
      redirect_to edit_admin_letter_path @letter_form.model
    else
      choose_members
      last_letter
      render action: :edit
    end
  end

  def destroy
    @letter = Letter.find params[:id]
    @letter.destroy
    redirect_to admin_letters_path
  end

  private

  def last_letter
    last_letter = Letter.order('number ASC').last
    @last_letter_number = last_letter ? last_letter.number : 0
  end
end
