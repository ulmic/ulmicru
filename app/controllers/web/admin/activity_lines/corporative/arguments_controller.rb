class Web::Admin::ActivityLines::Corporative::ArgumentsController < Web::Admin::ActivityLines::Corporative::ApplicationController

  def destroy
    argument = ::ActivityLines::Corporative::Argument.find params[:id]
    argument.remove
    redirect_to admin_activity_lines_corporative_confession_path argument.confession
  end
end
