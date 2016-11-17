class Web::Members::Corporative::PetitionsController < Web::Members::Corporative::ApplicationController
  before_filter :choose_members, only: [ :new, :edit ]
  before_filter :check_submission_dates

  include DatesHelper

  def new
    @petition_form = ::ActivityLines::Corporative::ConfessionForm.new_with_model
    @petition_form.build_arguments_for_petition
  end

  def create
    confession_params = params[:activity_lines_corporative_confession]
    confession_params[:year] = current_confession_year
    confession_params[:creator_id] = current_user.id
    confession_params[:arguments_attributes].keys.each do |index|
      confession_params[:arguments_attributes][index][:member_id] = current_user.id
    end
    params[:activity_lines_corporative_confession] = confession_params
    @petition_form = ::ActivityLines::Corporative::ConfessionForm.new_with_model
    if @petition_form.submit params[:activity_lines_corporative_confession]
      redirect_to activity_lines_corporative_petitions_path
    else
      choose_members
      render :new
    end
  end

  def update
    confession = ::ActivityLines::Corporative::ConfessionForm.find_with_model params[:id]
    if confession.user_can_update_petition? current_user.id
      if confession.submit params[:activity_lines_corporative_confession]
        redirect_to members_corporative_petitions_path
      else
        choose_members
        render :edit
      end
    else
      redirect_to not_found_page_path
    end
  end

  private

  def check_submission_dates
    if !submissions_petitions_begins?
      redirect_to not_found_page_path
    elsif submissions_petitions_ends?
      redirect_to page_page_path :confession_submissions_petitions_ends
    end
  end
end
