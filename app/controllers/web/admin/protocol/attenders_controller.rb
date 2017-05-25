class Web::Admin::Protocol::AttendersController < Web::Admin::ApplicationController
  def create
    @attender_form = ::Protocol::AttenderForm.new_with_model
    if @attender_form.submit params[:protocol_attender]
      redirect_to admin_protocol_path @attender_form.model.protocol
    else
      choose_members
      render :new
    end
  end

  def destroy
    attender = Protocol::Attender.find params[:id]
    attender.destroy
    redirect_to admin_protocol_path attender.protocol
  end
end
