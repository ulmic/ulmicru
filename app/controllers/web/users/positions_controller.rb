class Web::Users::PositionsController < Web::Users::ApplicationController
  def create
    @position = Position.new
    @position_form = PositionForm.new @position
    @position_form.submit params[:position]
    if @position_form.save
      redirect_to account_path
    else
      render action: :new
    end
  end

  def update
    @position = Position.find params[:id]
    @position_form = PositionForm.new @position
    @position_form.submit params[:position]
    if @position_form.save
      redirect_to account_path
    else
      render action: :edit
    end
  end

  def destroy
    @position = Position.find params[:id]
    @position.destroy
    redirect_to account_path
  end
end
