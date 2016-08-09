class Web::Members::PositionsController < Web::Members::ApplicationController
  before_filter :set_position

  def edit
    @position_form = PositionForm.find_with_model params[:id]
  end

  def update
    @position_form = PositionForm.find_with_model params[:id]
    if @position_form.submit params[:position]
      redirect_to params[:back]
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
end
