class Web::Admin::PositionsController < Web::Admin::ApplicationController
  def update
    @position_form = PositionForm.find_with_model params[:id]
    @position_form.submit params[:position]
    if @position_form.save
      if position_confirmed? && position_header? && position_does_not_have_protocol?
        Protocol.create! title: "Переизбрание #{@position_form.title}", record_id: @position_form.id, record_type: 'Position'
      end
      redirect_to admin_unviewed_index_path anchor: :positions
    else
      redirect_to admin_unviewed_index_path anchor: :positions
    end
  end

  def destroy
    @position = Position.find params[:id]
    @position.remove
    redirect_to admin_unviewed_index_path anchor: :positions
  end

  private

  def position_confirmed?
    params[:position][:state] == 'confirmed' && @prev_object_attributes[:state] != 'confirmed'
  end

  def position_header?
    @position_form.title.include?('Руководитель местного отделения') || @position_form.title.include?('Руководитель первичной организации')
  end

  def position_does_not_have_protocol?
    Protocol.where(record_id: @position_form.id, record_type: 'Position').empty?
  end
end
