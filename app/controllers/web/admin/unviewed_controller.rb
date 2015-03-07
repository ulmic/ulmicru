class Web::Admin::UnviewedController < Web::Admin::ApplicationController
  def index
    @members = ::MemberDecorator.decorate_collection Member.unviewed
    @questionaries = Questionary.unviewed.decorate
  end
end
