class Web::Members::PositionsController < Web::Members::ApplicationController
  def edit
    @position = PositionForm.find_with_model params[:id]
  end

  def update
  end
end
