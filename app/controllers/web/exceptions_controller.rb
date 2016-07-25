class Web::ExceptionsController < Web::ApplicationController
  before_action :status

  #Show the exception page
  def show
    redirect_rule = RedirectRule.find_by_old_path(request.env['PATH_INFO'])
    if redirect_rule.present?
      redirect_to redirect_rule.redirect_to
    end
    @year = 2012 + rand(4)
    render @status_name, status: @status_code and return
  end

  private

  #Get info about exception
  def status
    @exception  = env['action_dispatch.exception']
    @status_code     = ActionDispatch::ExceptionWrapper.new(env, @exception).status_code
    @status_name   = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
  end

  def log_error
    Rails.logger.warn "[Error] Class: #{@exception.class.name}"
    Rails.logger.warn "[Error] Status: #{@status}"
    Rails.logger.warn "[Error] Responce: #{@responce}"
    Rails.logger.warn "[Error] Message: #{@exception.message}"
    Rails.logger.warn "[Error] Backtrace: #{@exception.backtrace.first(30).join("\n")}"
  end
end
