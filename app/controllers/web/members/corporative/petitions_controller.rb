class Web::Members::Corporative::PetitionsController < Web::Members::Corporative::ApplicationController
  before_filter :choose_members, only: [ :new, :edit ]

  def new
    if submissions_petitions_not_begins?
      redirect_to not_found_page_path
    elsif submissions_petitions_ends?
      redirect_to page_page_path :confession_submissions_petitions_ends
    else
      @petition_form = ::ActivityLines::Corporative::EditConfessionType.new
      @petition_form.build_petition
    end
  end

  def create
    if submissions_petitions_during?
      confession_params = params[:activity_lines_corporative_confession]
      confession_params[:year] = configus.dates.activity_lines.corporative.confession.begining_submissions_petitions.year
      confession_params[:creator_id] = current_user.id
      confession_params[:arguments_attributes].keys.each do |index|
        confession_params[:arguments_attributes][index][:member_id] = current_user.id
      end
      # FIXME привести в адекватный вид
      confession_params[:images_attributes] = {}
      confession_params[:images_attributes][0] = params['activitylines::corporative::image']
      confession_params[:images_attributes][0][:member_id] = current_user.id
      params[:activity_lines_corporative_confession] = confession_params
      @petition_form = ::ActivityLines::Corporative::EditConfessionType.new params[:activity_lines_corporative_confession]
      if @petition_form.save
        confession_params[:images_attributes].keys.each do |index|
          @petition_form.images.create! confession_params[:images_attributes][index].permit!
        end
        redirect_to activity_lines_corporative_petitions_path
      else
        choose_members
        render :new
      end
    else
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
