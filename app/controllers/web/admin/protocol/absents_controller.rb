class Web::Admin::Protocol::AbsentsController < Web::Admin::ApplicationController
  def create
    @absent_form = ::Protocol::AbsentForm.new_with_model
    if @absent_form.submit params[:protocol_absent]
      redirect_to admin_protocol_path @absent_form.model.protocol
    else
      render :new
    end
  end

  def destroy
    absent = Protocol::Absent.find params[:id]
    absent.destroy
    redirect_to admin_protocol_path absent.protocol
  end
end
