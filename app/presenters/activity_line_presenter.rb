class ActivityLinePresenter < ApplicationPresenter
  attributes :title, :found_date, :activity_type, :description, :member_id, :created_at, :updated_at, :state, :logo

  def found_date
    object.found_date.iso8601
  end

  def logo
    object.logo.url
  end
end
