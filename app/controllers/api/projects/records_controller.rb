class Api::Projects::RecordsController < Api::ApplicationController
  def create
    if form_allowed?
      record = form_name.new Record.new
      if record.submit params[:record]
        head :ok
      else
        head :bad_request
      end
    else
      head :bad_request
    end
  end

  private

  def form_allowed?
    forms = %w( Projects::ItWay::V2017::ParticipantForm )
    form_name.in? forms
  end

  def form_name
    "Projects::#{params[:project_name]}::V#{params[:project_version]}::#{params[:record_type]}Form"
  end
end
