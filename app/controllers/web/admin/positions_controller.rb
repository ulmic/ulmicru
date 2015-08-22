class Web::Admin::PositionsController < Web::Admin::ApplicationController
  def update
    @position_form = PositionForm.find_with_model params[:id]
    @position_form.submit params[:position]
    if @position_form.save
      redirect_to admin_unviewed_index_path anchor: :positions
    else
      redirect_to admin_unviewed_index_path anchor: :positions
    end
  end
end
