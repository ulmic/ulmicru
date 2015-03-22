class Web::ActivityLineController < Web::ApplicationController
  def show
    @activity_line = ActivityLine.find(patams[:id])
  end
end
