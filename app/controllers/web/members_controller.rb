class Web::MembersController < Web::ApplicationController
  before_filter :authenticate_user!, only: [ :new, :create ]

  def new
    member = current_user.becomes! Member
    member.avail
    @member_form = MemberForm.new member
    @active_members = Member.where.not(state: :removed).where.not(state: :declined).order('ticket ASC').decorate
  end

  def create
    exists_member = Member.find_by_ticket params[:member][:ticket]
    member = exists_member
    if exists_member
      if exists_member.unavailable?
        current_user.destroy
        sign_in exists_member
      end
    else
      member = current_user.becomes! Member
      User.find(member.id).update type: 'Member'
    end
    @member_form = MemberForm.new member
    @member_form.submit params[:member]
    if @member_form.save
      redirect_to account_path
    else
      @active_members = Member.where.not(state: :removed).where.not(state: :declined).order('ticket ASC').decorate
      render action: :new
    end
  end

  def show
    member = Member.find_by_ticket(params[:ticket])
    if member.confirmed?
      @member = member.decorate
      @children = MemberDecorator.decorate_collection member.children.shuffle
      @parent = MemberDecorator.decorate member.parent
      @registrations = Event::RegistrationDecorator.decorate_collection member.registrations.reverse
      @news = NewsDecorator.decorate_collection member.tags.news.map &:record
      @articles = member.tags.articles.map &:record
      @attribute_accesses = member.attribute_accesses
    end
  end
end
