class Api::Projects::RecordsController < Api::ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if form_allowed?
      record = form_name.constantize.new Project::Record.new, params[:project_record]
      if record.save
        record.record.project.teams.map(&:users).flatten.uniq.each do |user|
          send_notification user, record.record, :create
        end
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
    "Projects::#{params[:project_name].camelize}::#{params[:project_version].camelize}::#{params[:record_type].camelize}Form"
  end
end
