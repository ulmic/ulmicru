class Web::MembersController < Web::ApplicationController
  before_filter :authenticate_user!, only: [ :new, :create ]

  def new
    member = current_user.becomes! Member
    @member_form = MemberForm.new member
  end

  def create
    # FIXME fix with reform
    members = Member.where ticket: params[:member][:ticket] 
    if members.any?
      @member_form = MemberForm.find_with_model_by ticket: params[:member][:ticket]
      @member_form.check_repeated_registration
      @member_form.check_complies params[:member]
      @member_form.submit params[:member]
      if @member_form.errors.empty? && @member_form.save
	@member_form.state_renew
	@member_form.update member_state: :unviewed
	[:authentications, :registrations, :comments].each do |collection|
	  current_user.send(collection).update_all user_id: @member_form.id
	end
	@member_form.update password_digest: current_user.password_digest
	old_user = current_user
	sign_in @member_form.model
	old_user.remove
	redirect_to account_path
      else
	render :new
      end
    else
      member = current_user.becomes! Member
      @member_form = MemberForm.new member
      @member_form.errors.add :ticket, 
	I18n.t('validations.errors.there_is_not_such_ticket_or_your_account_still_out_of_database')
      render :new
    end
  end

  def show
    member = Member.includes(:attribute_accesses, :authored_news, :authored_articles).presented.find_by_ticket(params[:ticket])
    @member = member.decorate
    @children = MemberDecorator.decorate_collection member.children.shuffle
    @parent = MemberDecorator.decorate member.parent
    @registrations = ::Event::RegistrationDecorator.decorate_collection member.registrations.date_order
    @news = News.order(published_at: :desc).where(id: member.tags.active.news.map(&:record_id)).decorate
    @articles = Article.order(created_at: :desc).where(id: member.tags.active.articles.map(&:record_id).uniq)
    @teams = member.teams.active.visible.decorate
  end
end
