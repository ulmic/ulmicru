class Web::Admin::MembersController < Web::Admin::ApplicationController
  def index
    @unviewed_members = ::MemberDecorator.decorate_collection Member.unviewed
    @confirmed_members = ::MemberDecorator.decorate_collection Member.confirmed
    @declined_members = ::MemberDecorator.decorate_collection Member.declined
    @unavailable_members = ::MemberDecorator.decorate_collection Member.unavailable
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
    if member.unavailable?
      @member_form = ::Admin::Member::UnavailableMemberForm.new member
    else
      @member_form = MemberForm.new member
    end
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
      render action: :new
    end
  end

  def update
    @member = Member.find params[:id]
    @member_form = MemberForm.new(@member)
    @member_form.submit(params[:member])
    if @member_form.save
      redirect_to admin_members_path
    else
      render action: :edit
    end
  end

  def destroy
    @member = Member.find params[:id]
    @member.remove
    redirect_to admin_members_path
  end
end
