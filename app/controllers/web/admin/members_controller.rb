class Web::Admin::MembersController < Web::Admin::ApplicationController
  before_filter :choose_members, only: [ :new, :edit ]
  def index
    if params[:search]
      members = Member.presented.search_everywhere params[:search]
    else
      members = Member.send params[:scope]
    end
    @members = members.page(params[:page]).decorate
  end

  def show
    @member = Member.includes(:positions).find(params[:id]).decorate
    registrations = @member.registrations
    @registrations = {}
    registrations.each do |registration|
      registration.event.logged_actions.each do |logged_action|
        @registrations.merge! registration => logged_action if nested_params_contains? logged_action, :registrations, user_id: @member.id
      end
    end
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
