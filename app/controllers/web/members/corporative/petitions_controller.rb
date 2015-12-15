class Web::Members::Corporative::PetitionsController < Web::Members::Corporative::ApplicationController
  before_filter :choose_members, only: [ :new, :edit ]

  def new
    if submissions_petitions_not_begins?
      redirect_to not_found_page_path
    elsif submissions_petitions_ends?
      redirect_to page_page_path :confession_submissions_petitions_ends
    else
      @petition_form = ::ActivityLines::Corporative::ConfessionForm.new_with_model
      @petition_form.build_arguments_for_petition
    end
  end

  def create
    if submissions_petitions_during?
      @petition_form = ::ActivityLines::Corporative::ConfessionForm.new_with_model
      @petition_form.submit params[:petition]
      if @petition_form.save
        redirect_to members_corporative_petitions_path
      else
        choose_members
        render :new
      end
    else
      redirect_to not_found_page_path
    end
  end

  def edit
    confession = ::ActivityLines::Corporative::Confession.find params[:id]
    if confession.user_can_update_petition? current_user.id
      @petition_form = ::ActivityLines::Corporative::ConfessionForm.new confession
    else
      redirect_to not_found_page_path
    end
  end

  def update
    confession = ::ActivityLines::Corporative::Confession.find params[:id]
    if confession.user_can_update_petition? current_user.id
      @petition_form = ::ActivityLines::Corporative::ConfessionForm.new confession
      @petition_form.submit params[:petition]
      if @petition_form.save
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
