class TeamPresenter < ApplicationPresenter
  attributes :title, :description, :municipality, :school, :publicity

  has_many :users, serializer: ::UserPresenter
end
