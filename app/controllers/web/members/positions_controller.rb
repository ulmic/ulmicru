class Web::Members::PositionsController < Web::Members::ApplicationController
  def edit
    @position_form = PositionForm.find_with_model params[:id]
    @position = Position.includes(:member).find params[:id]
  end

  def update
  end
end
