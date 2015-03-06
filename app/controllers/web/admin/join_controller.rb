class Web::Admin::JoinController < Web::Admin::ApplicationController
  def index
    @questionarys = ::MemberDecorator.decorate_collection questionary.presented
  end

  def new
    @questionary = Member.new
    @questionary_form = MemberForm.new @questionary
  end

  def edit
    @questionary = Member.find params[:id]
    @questionary_form = MemberForm.new @questionary
  end

  def create
    @questionary = Member.new
    @questionary_form = MemberForm.new @questionary
    @questionary_form.submit params[:questionary]
    if @questionary_form.save
      redirect_to admin_join_index_path
    else
      render action: :new
    end
  end

  def update
    @questionary = Member.find params[:id]
    @questionary_form = MemberForm.new @questionary
    @questionary_form.submit params[:questionary]
    if @questionary_form.save
      redirect_to admin_join_index_path
    else
      render action: :edit
    end
  end

  def destroy
    @questionary = Member.find params[:id]
    @questionary.remove
    redirect_to admin_join_index_path
  end
end
