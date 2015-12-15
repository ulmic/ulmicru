class Web::Members::Corporative::PetitionsController < Web::Members::Corporative::ApplicationController
  before_filter :choose_members, only: [ :new, :edit ]

  def new
    if submissions_petitions_not_begins?
      redirect_to not_found_page_path
    elsif submissions_petitions_ends?
      redirect_to page_page_path :confession_submissions_petitions_ends
    else
      @petition_form = ::ActivityLines::Corporative::EditConfessionType.new
      @petition_form.build_arguments_for_petition
    end
  end

  def create
    if submissions_petitions_during?
      params[:activity_lines_corporative_confession][:year] = configus.dates.activity_lines.corporative.confession.begining_submissions_petitions.year
      params[:activity_lines_corporative_confession][:creator_id] = current_user.id
      @petition_form = ::ActivityLines::Corporative::EditConfessionType.new params[:activity_lines_corporative_confession]
      if @petition_form.save
        redirect_to activity_lines_corporative_petitions_path
      else
        choose_members
        render :new
      end
    else
      redirect_to not_found_page_path
    end
  end

  def edit
    confession = ::ActivityLines::Corporative::EditConfessionType.find params[:id]
    unless confession.user_can_update_petition? current_user.id
      redirect_to not_found_page_path
    end
  end

  def update
    confession = ::ActivityLines::Corporative::EditConfessionType.find params[:id]
    if confession.user_can_update_petition? current_user.id
      if confession.update_attributes params[:activity_lines_corporative_confession]
        redirect_to members_corporative_petitions_path
      else
        choose_members
        render :edit
      end
    else
      redirect_to not_found_page_path
    end
  end
end
