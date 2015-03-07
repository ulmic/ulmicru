class Web::Admin::UnviewedController < Web::Admin::ApplicationController
  def index
    @members = ::MemberDecorator.decorate_collection Member.unviewed
  end
end
