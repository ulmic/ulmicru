class Web::Members::PositionsController < Web::Members::ApplicationController
  before_filter :set_position, except: [ :new, :create ]
  before_filter :set_team

  def new
    @member = Member.find(params[:id]).decorate
    @position_form = PositionForm.new_with_model
  end

  def create
    @position_form = PositionForm.new_with_model
    if @position_form.submit params[:position]
      redirect_to edit_members_team_path @team
    else
      render :new
    end
  end

  def edit
    @position_form = PositionForm.find_with_model params[:id]
  end

  def update
    @position_form = PositionForm.find_with_model params[:id]
    if @position_form.submit params[:position]
      redirect_to edit_members_team_path @team
    else
      render :edit
    end
  end

  def destroy
    @position = Position.find params[:id]
    @position.remove
    redirect_to :back
  end

  private

  def set_position
    @position = Position.includes(:member).find params[:id]
  end

  def set_team
    @team = Team.find(params[:team_id]).decorate
  end
end
