class Web::ActivityLines::Lider::YaLider::StagesController < Web::ActivityLines::Lider::YaLider::ApplicationController
  def show
    stage = ActivityLines::Lider::YaLider::Stage.find(params[:id])
    @contest = stage.contest.decorate
    @stage = stage.decorate
    @current_participants = if params[:search].present?
                              ::ActivityLines::Lider::YaLider::Participant.where(
                                id: (stage.participants.search_everywhere(params[:search]).map(&:id) & stage.current_participants.map(&:id))).decorate
                            else
                              stage.current_participants
                            end

  end
end
