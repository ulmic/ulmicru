class Web::Members::ApplicationController < Web::ApplicationController
  before_filter :authenticate_member!
  before_action :save_object, only: [ :update, :destroy ]
  after_action :log_action, only: [ :create, :update, :destroy, :restore ]
  include Concerns::LoggedActions
end
