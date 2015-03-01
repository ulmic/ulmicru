class Web::Admin::MembersController < Web::Admin::ApplicationController
  def index
    @members = Member.all
  end

  def new
    @member = Member.new
    @member_form = MemberForm.new(@member)
  end

  def edit
    @member = Member.find params[:id]
    @member_form = MemberForm.new(@member)
  end

  def create
    @member = Member.new
    @member_form = MemberForm.new(@member)
    @member_form.submit(params[:member])
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
