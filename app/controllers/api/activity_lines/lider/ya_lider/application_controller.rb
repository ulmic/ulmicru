class Api::ActivityLines::Lider::YaLider::ApplicationController < 
      Api::ActivityLines::Lider::ApplicationController
  before_filter :authenticate
  before_filter :check_ya_lider_token
end
