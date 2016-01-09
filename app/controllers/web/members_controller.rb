class Web::MembersController < Web::ApplicationController
  before_filter :authenticate_user!, only: [ :new, :create ]

  def new
    member = current_user.becomes! Member
    @member_form = MemberForm.new member
  end

  def create
    exists_member = Member.find_by_ticket params[:member][:ticket]
    member = exists_member
    if exists_member
      if exists_member.state == 'unavailable'
        exists_member.password_digest = current_user.password_digest
        exists_member.save
        current_user.authentications.each do |auth|
          auth.user_id = exists_member.id
          auth.save
        end
        current_user.registrations.each do |reg|
          reg.user_id = exists_member.id
          reg.save
        end
        current_user.comments.each do |comment|
          comment.user_id = exists_member.id
          comment.save
        end
        old_user = current_user
        sign_in exists_member
        old_user.remove
      end
    else
      member = current_user.becomes! Member
    end
    @member_form = MemberForm.new member
    @member_form.submit params[:member]
    User.find(member.id).update type: 'Member'
    if @member_form.save
      redirect_to account_path
    else
      # FIXME fix this shiiiiit!!!!
      ActiveRecord::Base.connection.execute "UPDATE users SET type = NULL WHERE id = #{member.id}"
      render action: :new
    end
  end

  def show
    member = Member.find_by_ticket(params[:ticket])
    if member.member_confirmed?
      @member = member.decorate
      @children = MemberDecorator.decorate_collection member.children.shuffle
      @parent = MemberDecorator.decorate member.parent
      @registrations = ::Event::RegistrationDecorator.decorate_collection member.registrations.date_order
      @news = NewsDecorator.decorate_collection member.tags.active.news.map &:record
      @articles = member.tags.active.articles.map &:record
      @attribute_accesses = member.attribute_accesses
    end
  end
end
