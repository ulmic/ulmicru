class Web::ActivityLines::Corporative::PetitionsController < Web::ActivityLines::Corporative::ApplicationController
  before_filter :add_comment, only: :index

  def index
    @debut_of_the_year = ::ActivityLines::Corporative::Confession.debut.of_the_year(current_confession_year).on_vote.decorate
    @number_one_of_the_year = ::ActivityLines::Corporative::Confession.number_one.of_the_year(current_confession_year).on_vote.decorate
    @all_nominates_count = ::ActivityLines::Corporative::Confession.confirmed.count
    @document = Document.find configus.documents.confession_position
  end
end
