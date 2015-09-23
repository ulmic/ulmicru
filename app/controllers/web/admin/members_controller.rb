class Web::Admin::MembersController < Web::Admin::ApplicationController
  before_filter :choose_members, only: [ :new, :edit ]
  def index
    @members = {}
    @members[:confirmed] = Kaminari.paginate_array(::MemberDecorator.decorate_collection(Member.confirmed)).page params[:page]
    @members[:unviewed] = Kaminari.paginate_array(::MemberDecorator.decorate_collection(Member.unviewed)).page params[:page]
    @members[:declined] = Kaminari.paginate_array(::MemberDecorator.decorate_collection(Member.declined)).page params[:page]
    @members[:unavailable] = Kaminari.paginate_array(::MemberDecorator.decorate_collection(Member.unavailable)).page params[:page]
    @members[:search] = Kaminari.paginate_array(Member.search_everywhere(params[:search]).decorate).page(params[:page]) if params[:search]
  end

  def new
    if params[:id]
      user = User.find params[:id]
      user.update(type: 'Member')
      @member = user.becomes! Member
    else
      @member = Member.new
    end
    @member_form = MemberForm.new(@member)
  end

  def edit
    member = Member.find params[:id]
    @member_form = member_form(member).new member
  end

  def create
    member = Member.find_by_ticket params[:member][:ticket]
    if member
      if member.unavailable?
        @member_form = MemberForm.find_with_model member.id
      else
        redirect_to admin_members_path
      end
    else
      @member_form = MemberForm.new_with_model
    end
    @member_form.submit params[:member]
    if @member_form.save
      redirect_to admin_members_path
    else
      choose_members
      render action: :new
    end
  end

  def update
    member = Member.find params[:id]
    @member_form = member_form(member).new member
    @member_form.submit params[:member]
    if @member_form.save
      redirect_to edit_admin_member_path @member_form.model
    else
      choose_members
      render action: :edit
    end
  end

  def destroy
    @member = Member.find params[:id]
    @member.remove
    redirect_to admin_members_path
  end

  private

  def member_form(member)
    member.unavailable? ? ::Admin::Member::UnavailableMemberForm : MemberForm
  end

end
