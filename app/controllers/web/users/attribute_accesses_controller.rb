class Web::Users::AttributeAccessesController < Web::Users::ApplicationController
  def create
    @access = AttributeAccess.where(member_attribute: params[:attribute_access][:member_attribute], member_id: params[:attribute_access][:member_id]).first
    unless @access
      @access = AttributeAccess.new
    end
    @access_form = AttributeAccessForm.new @access
    @access_form.submit params[:attribute_access]
    if @access_form.save
      head :ok
    else
      head :bad_request
    end
  end
end
