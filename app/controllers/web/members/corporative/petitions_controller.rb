class Web::Members::Corporative::PetitionsController < Web::Members::Corporative::ApplicationController
  def index
    @debut_of_the_year = ::ActivityLines::Corporative::Confession.debut.of_the_year(current_confession_year).on_vote
    @number_one_of_the_year = ::ActivityLines::Corporative::Confession.number_one.of_the_year(current_confession_year).on_vote
  end

  def new
    if submissions_petitions_not_begins?
      redirect_to not_found_page_path
    elsif submissions_petitions_ends?
      redirect_to page_page_path :confession_submissions_petitions_ends
    else
      @petition = ::ActivityLines::Corporative::ConfessionForm.new_with_model
    end
  end

  def create
    if submissions_petitions_during?
      @petition = ::ActivityLines::Corporative::ConfessionForm.new_with_model
      @petition.submit params[:petition]
      if @petition.save
        redirect_to members_corporative_petitions_path
      else
        render :new
      end
    else
      redirect_to not_found_page_path
    end
  end

  def edit
    confession = ::ActivityLines::Corporative::ConfessionForm.find params[:id]
    if confession.user_can_update_petition? current_user.id
      @petition = ::ActivityLines::Corporative::Confession.new confession
    else
      redirect_to not_found_page_path
    end
  end

  def update
    confession = ::ActivityLines::Corporative::ConfessionForm.find params[:id]
    if confession.user_can_update_petition? current_user.id
      @petition = ::ActivityLines::Corporative::Confession.new confession
      @petition.submit params[:petition]
      if @petition.save
        redirect_to members_corporative_petitions_path
      else
        render :edit
      end
    else
      redirect_to not_found_page_path
    end
  end
end
