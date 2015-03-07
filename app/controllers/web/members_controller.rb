class Web::MembersController < Web::ApplicationController
  before_filter :authenticate_user!, only: [ :new, :create ]

  def new
    @member = Member.new
    @member_form = MemberForm.new @member
  end

  def create
    @member = Member.new
    @member_form = MemberForm.new @member
    @member_form.submit params[:member]
    if @member_form.save
      redirect_to account_index_path
    else
      render action: :new
    end
  end

  def show
    @member = Member.find_by_ticket params[:ticket]
  end
end
