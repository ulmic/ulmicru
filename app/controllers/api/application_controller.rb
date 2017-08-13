class Api::ApplicationController < ApplicationController
  include Concerns::NotificationManagment

  skip_before_filter :redirect_to_another_main_page
end
